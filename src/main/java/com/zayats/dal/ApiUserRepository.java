package com.zayats.dal;

import com.zayats.controller.IndexController;
import com.zayats.exceptions.EmailOrLoginUsedException;
import com.zayats.model.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;

public class ApiUserRepository {

	private RestTemplate restTemplate;

	private static final Logger logger = Logger
			.getLogger(IndexController.class);

	@Autowired
	public void setRestTemplate(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	public boolean register(User user) throws EmailOrLoginUsedException {
		logger.info("Go to api: register user");

		try {
			HashMap<String, Object> result = restTemplate.postForObject(ApiUtils.url
					+ "/user/register", user, HashMap.class);
			if ((Boolean) result.get("isRegister")) {
				logger.info(result.toString());
				return true;
			} else
				return false;
		} catch (HttpServerErrorException e) {
			throw new EmailOrLoginUsedException();
		}
	}

	public List<User> searchUsers(String userString, int eventId) {
		logger.info("Go to api: search users");

		return restTemplate.getForObject(ApiUtils.url + "/home/users/" + userString
				+ "/" + eventId, List.class);
	}
}
