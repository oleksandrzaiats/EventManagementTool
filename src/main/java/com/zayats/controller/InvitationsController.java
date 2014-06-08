package com.zayats.controller;

import com.zayats.dal.ApiEventRepository;
import com.zayats.dal.ApiInvitationRepository;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping(value = "home/invitations")
public class InvitationsController extends AuthorizedController {

	@Autowired
    ApiEventRepository familyRepository;

	@Autowired
	ApiInvitationRepository invitationRepository;

	private static final Logger logger = Logger
			.getLogger(InvitationsController.class);

	@RequestMapping(value = "/get")
	public @ResponseBody
	List<HashMap<String, String>> getInvitations(Model model, Principal principal) {
		logger.info("Getting invitations for user");

		List<HashMap<String, String>> list = invitationRepository
				.getUserInvitations(getCurrentUser().getUsername());
		return list;
	}

	@RequestMapping(value = "")
	public String invitations(Model model, Principal principal) {
		model.addAttribute("navigation", naviMap);
		model.addAttribute("title", "Invitations");
		String username = principal.getName(); // get logged in username
		model.addAttribute("username", username);
		return "invitations";
	}

	@RequestMapping(value = "/invite/{familyId}/{toUsername}", method = RequestMethod.GET)
	public @ResponseBody
	List<Boolean> inviteUser(@PathVariable String toUsername,
			@PathVariable int familyId, Model model, Principal principal) {
		logger.info("Send invite to user");
        String fromUsername = getCurrentUser().getUsername();
		boolean isInvited = invitationRepository.createInvitation(familyId,
				fromUsername, toUsername);
		List<Boolean> result = new ArrayList<Boolean>();
		result.add(isInvited);
		return result;
	}

	@RequestMapping(value = "/accept/{eventId}/{invitationId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Boolean> acceptInvitation(@PathVariable int eventId,
			@PathVariable int invitationId, Model model, Principal principal) {
		logger.info("Accept invitation");

		int userId = getCurrentUser().getUserId();
		return invitationRepository.acceptInvitation(eventId, userId,
				invitationId);
	}

	@RequestMapping(value = "/reject/{invitationId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Boolean> rejectInvitation(@PathVariable int invitationId, Model model,
			Principal principal) {
		logger.info("Decine invitation");

		List<Boolean> result = new ArrayList<Boolean>();
		result.add(invitationRepository.deleteInvitation(invitationId));
		return result;
	}

}
