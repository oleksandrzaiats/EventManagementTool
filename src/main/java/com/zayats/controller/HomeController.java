package com.zayats.controller;

import com.zayats.authprovider.UserDetailsExt;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequestMapping("/home")
public class HomeController extends AuthorizedController {

	@RequestMapping(value = "")
	public String home(Model model, Principal principal) {
		model.addAttribute("navigation", naviMap);
        UserDetailsExt userDetails = (UserDetailsExt)((Authentication)principal).getPrincipal();
        setCurrentUser(userDetails);
		model.addAttribute("title", "Home");
		String username = principal.getName(); // get logged in username
		model.addAttribute("username", username);
		return "home";
	}

}
