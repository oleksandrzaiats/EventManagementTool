package com.zayats.controller;

import java.util.HashMap;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.HttpClientErrorException;

import com.zayats.dal.ApiUserRepository;
import com.zayats.exceptions.EmailOrLoginUsedException;
import com.zayats.model.User;

@Controller
public class IndexController {

	@Autowired
	ApiUserRepository userRepository;

	public static final HashMap<String, String> naviMap;
	static {
		naviMap = new HashMap<String, String>();
		naviMap.put("Login", "/login.html");
		naviMap.put("Register", "/register.html");
		naviMap.put("About", "/about.html");
	}

	private static final Logger logger = Logger
			.getLogger(IndexController.class);

	@RequestMapping(value = "/login")
	public String login(Model model) {
		model.addAttribute("title", "Login");
		model.addAttribute("navigation", naviMap);
		return "login";
	}

	@RequestMapping(value = "/about")
	public String about(Model model) {
		model.addAttribute("title", "About");
		model.addAttribute("navigation", naviMap);
		return "about";
	}

	@RequestMapping(value = "/")
	public String index(Model model) {
		return "redirect:about";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Model model) {
		model.addAttribute("navigation", naviMap);
		model.addAttribute("title", "Register");
		model.addAttribute("user", new User());
		return "register";
	}

	@RequestMapping(value = "/registeruser", method = RequestMethod.POST)
	public String registerUser(@ModelAttribute("user") @Valid User user,
			BindingResult result, Model model) {
		logger.info("Register controller.");

		model.addAttribute("navigation", naviMap);
		model.addAttribute("title", "Register");

		if (result.hasErrors()) {
			logger.info("Registration form has errors.");
			return "register";
		}

		String password = user.getPassword();
		Md5PasswordEncoder md = new Md5PasswordEncoder();
		user.setPassword(md.encodePassword(password, null));

		boolean registerResult = false;
		try {
			registerResult = userRepository.register(user);
		} catch (HttpClientErrorException e) {
			model.addAttribute("errors", e.getMessage());
			logger.info("Catched HttpClientErrorException " + e.getMessage());
			user.setPassword(null);
			return "register";
		} catch (EmailOrLoginUsedException e) {
			model.addAttribute("errors", e.getMessage());
			logger.info("Catched EmailOrLoginUsedException " + e.getMessage());
			user.setPassword(null);
			return "register";
		}

		if (!registerResult) {
			model.addAttribute("errors", "Unknown error.");
			logger.info("Unknown error");
			user.setPassword(null);
			return "register";
		}

		model.addAttribute("message",
				"You have succesfuly register. Go to login page and enter to site.");
		return "about";
	}
}
