package com.zayats.controller;

import com.zayats.dal.ApiEventRepository;
import com.zayats.dal.ApiInvitationRepository;
import com.zayats.dal.ApiUserRepository;
import com.zayats.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping(value = "home/users")
public class UsersController extends AuthorizedController {

	@Autowired
	ApiUserRepository userRepository;

	@Autowired
    ApiEventRepository familyRepository;

	@Autowired
	ApiInvitationRepository invitationRepository;

	@RequestMapping(value = "/delete/{username}/{familyId}")
	public String deleteUserFromFamily(@PathVariable String username,
			@PathVariable int familyId, Model model, Principal principal) {
		model.addAttribute("navigation", naviMap);
		model.addAttribute("title", "Families");
		String username1 = principal.getName(); // get logged in username
		model.addAttribute("username", username1);
		familyRepository.deleteUserFromEvent(username, familyId);

		return "redirect:/home/families/" + familyId;
	}

	@RequestMapping(value = "/{userString}/{familyId}", method = RequestMethod.GET)
	public @ResponseBody
	List<User> searchUsers(@PathVariable String userString,
			@PathVariable int familyId, Model model, Principal principal) {
		return userRepository.searchUsers(userString, familyId);
	}

}
