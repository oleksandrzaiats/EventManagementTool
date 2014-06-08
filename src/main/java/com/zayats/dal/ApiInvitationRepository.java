package com.zayats.dal;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ApiInvitationRepository {

	private RestTemplate restTemplate;

	private static final Logger logger = Logger
			.getLogger(ApiInvitationRepository.class);

	@Autowired
	public void setRestTemplate(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	public boolean createInvitation(int familyId, String fromUsername,
			String toUsername) {
		logger.info("Go to api: create invitation");

		List<Boolean> result = new ArrayList<Boolean>();
		result = restTemplate.getForObject(ApiUtils.url + "/home/invitations/invite/"
				+ familyId + "/" + fromUsername + "/" + toUsername, List.class);
		return result.get(0);
	}

	public List<Boolean> acceptInvitation(int eventId, int userId,
			int invitationId) {
		logger.info("Go to api: accept invitation");

		return restTemplate.getForObject(ApiUtils.url + "/home/invitations/accept/"
				+ eventId + "/" + invitationId + "/" + userId, List.class);
	}

	public boolean deleteInvitation(int invitationId) {
		logger.info("Go to api: delete invitation");

		List<Boolean> result = new ArrayList<Boolean>();
		result = restTemplate.getForObject(ApiUtils.url + "/home/invitations/reject/"
				+ invitationId, List.class);
		return result.get(0);
	}

	public List<HashMap<String, String>> getUserInvitations(String toUsername) {
		logger.info("Go to api: get user's invitations");

		List<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();
		result = restTemplate.getForObject(ApiUtils.url + "/home/invitations/"
				+ toUsername, List.class);
		return result;
	}

}
