package com.bolsadeideas.springboot.app.auth.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collection;

import javax.crypto.SecretKey;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import com.bolsadeideas.springboot.app.auth.SimpleGrantedAuthoritiesMixin;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

import com.bolsadeideas.springboot.app.auth.filter.JWTAuthenticationFilter;

public class JWTAuthorizationFilter extends BasicAuthenticationFilter {

	public JWTAuthorizationFilter(final AuthenticationManager authenticationManager) {
		super(authenticationManager);
	}

	@Override
	protected void doFilterInternal(final HttpServletRequest request, final HttpServletResponse response, final FilterChain chain)
			throws IOException, ServletException {
		final String header = request.getHeader("Authorization");

		if (!requiresAuthentication(header)) {
			chain.doFilter(request, response);
			return;
		}

		boolean validoToken;
		Claims token = null;
		try {
			token = Jwts.parserBuilder()
			.setSigningKey(JWTAuthenticationFilter.secretKey).build()
			.parseClaimsJws(header.replace("Bearer ", "")).getBody();
			validoToken = true; 
		} catch (JwtException | IllegalArgumentException e) {

			validoToken = false;
		}
		
		UsernamePasswordAuthenticationToken authentication = null;
		
		if(validoToken) {
			final String username = token.getSubject();
			final Object roles = token.get("authorities");
			
			final Collection<? extends GrantedAuthority> authorities = Arrays.asList(new ObjectMapper()
					.addMixIn(SimpleGrantedAuthority.class, SimpleGrantedAuthoritiesMixin.class)
					.readValue(roles.toString().getBytes(), SimpleGrantedAuthority[].class));
					
			authentication = new UsernamePasswordAuthenticationToken(username, null, authorities);
		}
		
		SecurityContextHolder.getContext().setAuthentication(authentication);
		chain.doFilter(request, response);

	}

	protected boolean requiresAuthentication(final String header) {
		if (header == null || !header.startsWith("Bearer ")) {
			return false;
		}
		return true;
	}

}
