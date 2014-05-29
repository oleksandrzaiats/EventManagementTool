package com.zayats.controller;

import com.zayats.dal.ApiEventRepository;
import com.zayats.dal.ApiShoplistRepository;
import com.zayats.model.Event;
import com.zayats.model.Shopitem;
import com.zayats.model.Shoplist;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/home/shoplists")
public class ShoplistsController extends AuthorizedController {

	@Autowired
	ApiShoplistRepository listRepository;

	@Autowired
    ApiEventRepository familyRepository;

	private static final Logger logger = Logger
			.getLogger(ShoplistsController.class);

	@RequestMapping(value = "")
	public String getFamilies(Model model, Principal principal) {
		model.addAttribute("navigation", naviMap);
		model.addAttribute("title", "Lists");
		String username = principal.getName(); // get logged in username
		model.addAttribute("username", username);

		List<Event> list = null;
		try {
			logger.info("Get families for user.");
			list = familyRepository.getAllEventsForUser(username);
		} catch (EmptyResultDataAccessException e) {
			logger.info("Can't get families for user. No data received.");
			model.addAttribute("error",
					"Can't get families for user. Please, try later.");
		}

		if (list.size() == 0)
			list = null;

		model.addAttribute("familyList", list);
		return "shoplists";
	}

	@RequestMapping(value = "/get/{familyId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Shoplist> getShoplists(@PathVariable int familyId) {
		logger.info("Get shoplists");

		List<Shoplist> shoplists = listRepository
				.getShoplistsForFamily(familyId);
		return shoplists;
	}

	@RequestMapping(value = "/create/{name}/{familyId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Boolean> createShoplist(@PathVariable int familyId,
			@PathVariable String name) {
		logger.info("Create shoplist");

		List<Boolean> isCreated = new ArrayList<Boolean>();
		isCreated.add(listRepository.createShoplist(name, familyId));
		return isCreated;
	}

	@RequestMapping(value = "/shopitems/{shoplistId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Shopitem> getShopitems(@PathVariable int shoplistId) {
		logger.info("Get shopitems");

		List<Shopitem> shopitems = listRepository
				.getItemsOfShoplist(shoplistId);
		return shopitems;
	}

	@RequestMapping(value = "/delete/{shoplistId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Boolean> deleteShoplist(@PathVariable int shoplistId) {
		logger.info("Delete shoplist");

		List<Boolean> result = new ArrayList<Boolean>();
		result.add(listRepository.deleteShoplist(shoplistId));
		return result;
	}

	@RequestMapping(value = "/addShopitem/{name}/{quantity}/{shoplistId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Boolean> addShopitem(@PathVariable int shoplistId,
			@PathVariable String quantity, @PathVariable String name) {
		logger.info("Add shopitem");

		List<Boolean> result = new ArrayList<Boolean>();
		result.add(listRepository.addShopitem(name, quantity, shoplistId));
		return result;
	}

	@RequestMapping(value = "/deleteShopitem/{shopitemId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Boolean> deleteShopitem(@PathVariable int shopitemId) {
		logger.info("Delete shopitem");

		List<Boolean> result = new ArrayList<Boolean>();
		result.add(listRepository.deleteShopitem(shopitemId));
		return result;
	}

	@RequestMapping(value = "/buyShopitem/{shopitemId}", method = RequestMethod.GET)
	public @ResponseBody
	List<Boolean> buyShopitem(@PathVariable int shopitemId) {
		logger.info("Buy shopitem");

		List<Boolean> result = new ArrayList<Boolean>();
		result.add(listRepository.buyShopitem(shopitemId));
		return result;
	}
}
