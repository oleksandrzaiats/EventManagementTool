package com.zayats.authprovider;

import com.zayats.controller.IndexController;
import com.zayats.dal.ApiUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service("apiUserDetailService")
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private RestTemplate restTemplate;

	private static final Logger logger = Logger
			.getLogger(IndexController.class);

	public void setRestTemplate(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	static {
		GrantedAuthority authorityAdmin = new GrantedAuthorityImpl("ROLE_ADMIN");
		GrantedAuthority authorityGuest = new GrantedAuthorityImpl("ROLE_USER");
	}

	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("username", username);
		HttpHeaders requestHeaders = new HttpHeaders();
		requestHeaders.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<?> httpEntity = new HttpEntity<Object>(params,
				requestHeaders);
		logger.info("Create map and do request.");
		HashMap<String, String> result = restTemplate.postForObject(
                ApiUtils.url + "/user/login",
				httpEntity, HashMap.class);

		if (result == null) {
			throw new UsernameNotFoundException("Wrong username or password");
		}
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new GrantedAuthorityImpl(result.get("authority")));
		UserDetailsExt user = new UserDetailsImpl(result.get("username"),
				result.get("password"), Integer.parseInt(result.get("id")), authorities);

		return user;
	}
}
