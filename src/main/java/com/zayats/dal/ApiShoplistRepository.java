package com.zayats.dal;

import com.zayats.model.Shopitem;
import com.zayats.model.Shoplist;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

public class ApiShoplistRepository {

	private RestTemplate restTemplate;

	private static final Logger logger = Logger
			.getLogger(ApiShoplistRepository.class);

	@Autowired
	public void setRestTemplate(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	public boolean createShoplist(String name, int familyId) {
		logger.info("Go to api: create shoplist");

		List<Boolean> result = new ArrayList<Boolean>();
		result = restTemplate.getForObject(ApiUtils.url + "/home/shoplists/create/"
				+ name + "/" + familyId, List.class);
		return result.get(0);
	}

	public boolean deleteShoplist(int listId) {
		logger.info("Go to api: delete shoplist");

		List<Boolean> result = new ArrayList<Boolean>();
		result = restTemplate.getForObject(ApiUtils.url + "/home/shoplists/delete/"
				+ listId, List.class);
		return result.get(0);
	}

	public List<Shoplist> getShoplistsForFamily(int familyId) {
		logger.info("Go to api: get shoplists for family");

		return restTemplate.getForObject(ApiUtils.url + "/home/shoplists/get/"
				+ familyId, List.class);
	}

	public List<Shopitem> getItemsOfShoplist(int listId) {
		logger.info("Go to api: get shopitems of shoplist");

		return restTemplate.getForObject(ApiUtils.url + "/home/shoplists/shopitems/"
				+ listId, List.class);
	}

	public boolean addShopitem(String name, String quantity, int shoplistId) {
		logger.info("Go to api: add shopitem to shoplist");

		List<Boolean> result = new ArrayList<Boolean>();
		result = restTemplate.getForObject(ApiUtils.url + "/home/shoplists/addShopitem/"
				+ name + "/" + quantity + "/" + shoplistId, List.class);
		return result.get(0);
	}

	public boolean deleteShopitem(int shopitemId) {
		logger.info("Go to api: delete shopitem from shoplist");

		List<Boolean> result = new ArrayList<Boolean>();
		result = restTemplate.getForObject(ApiUtils.url
				+ "/home/shoplists/deleteShopitem/" + shopitemId, List.class);
		return result.get(0);
	}

	public boolean buyShopitem(int shopitemId) {
		logger.info("Go to api: buy shopitem");

		List<Boolean> result = new ArrayList<Boolean>();
		result = restTemplate.getForObject(ApiUtils.url + "/home/shoplists/buyShopitem/"
				+ shopitemId, List.class);
		return result.get(0);
	}

}
