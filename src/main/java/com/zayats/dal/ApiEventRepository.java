package com.zayats.dal;

import com.zayats.exceptions.DataAccessDbException;
import com.zayats.exceptions.EventNotExistsException;
import com.zayats.model.Event;
import com.zayats.model.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.web.client.RestTemplate;

import java.util.*;

public class ApiEventRepository {

    private RestTemplate restTemplate;

    private static final Logger logger = Logger
            .getLogger(ApiEventRepository.class);

    @Autowired
    public void setRestTemplate(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public boolean createEvent(Event event)
            throws DataAccessDbException {
        logger.info("Go to api: add event");
        List<Boolean> result = new ArrayList<Boolean>();
        result = restTemplate.postForObject(ApiUtils.url + "/home/events/add/", event, List.class);
        return result.get(0);
    }

    public List<Event> getEventsForUser(Integer id) {
        logger.info("Go to api: get events for user");

        List<LinkedHashMap<String, Object>> list = restTemplate.getForObject(ApiUtils.url + "/home/events/" + id.toString(),
                List.class);
        List<Event> result = new ArrayList<Event>();
        for (LinkedHashMap<String, Object> item : list) {
            Event event = new Event();
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis((Long) item.get("date"));
            event.setDate(calendar.getTime());
            event.setId((Integer) item.get("id"));
            event.setName((String) item.get("name"));
            event.setDescription((String) item.get("description"));
            event.setAddress((String) item.get("address"));
            User user = new User();
            user.setUserId((Integer) ((LinkedHashMap) (item.get("owner"))).get("userId"));
            user.setUsername((String) ((LinkedHashMap) (item.get("owner"))).get("username"));
            user.setFirstName((String) ((LinkedHashMap) (item.get("owner"))).get("firstName"));
            user.setLastName((String) ((LinkedHashMap) (item.get("owner"))).get("lastName"));
            event.setOwner(user);
            result.add(event);
        }
        return result;
    }

    public boolean deleteUserFromEvent(String username, int eventId) {
        logger.info("Go to api: delete user from event");

        List<Boolean> result = new ArrayList<Boolean>();
        result = restTemplate.getForObject(ApiUtils.url + "/home/users/delete/"
                + username + "/" + eventId, List.class);
        return result.get(0);
    }

    public List<User> getParticipans(int eventId, String username)
            throws EmptyResultDataAccessException, EventNotExistsException {
        logger.info("Go to api: get participans of event");

        return restTemplate.getForObject(ApiUtils.url + "/home/events/" + eventId
                + "/" + username, List.class);
    }

    public List<Event> getAllEventsForUser(String username) {
        logger.info("Go to api: get all events for user");

        return restTemplate.getForObject(ApiUtils.url + "/home/shoplists/" + username,
                List.class);
    }

    public boolean deleteEvent(int eventId) throws DataAccessDbException {
        logger.info("Go to api: delete event");

        List<Boolean> result = new ArrayList<Boolean>();
        result = restTemplate.getForObject(ApiUtils.url + "/home/events/delete/"
                + eventId, List.class);
        return result.get(0);
    }

    public List<Event> getEvent(int eventId) throws EmptyResultDataAccessException, EventNotExistsException {
        logger.info("Go to api: get event details");

        List<LinkedHashMap<String, Object>> list = restTemplate.getForObject(ApiUtils.url + "/home/events/detail/" + eventId,
                List.class);
        List<Event> result = new ArrayList<Event>();
        for (LinkedHashMap<String, Object> item : list) {
            Event event = new Event();
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis((Long) item.get("date"));
            event.setDate(calendar.getTime());
            event.setId((Integer) item.get("id"));
            event.setName((String) item.get("name"));
            event.setDescription((String) item.get("description"));
            event.setAddress((String) item.get("address"));
            User user = new User();
            user.setUserId((Integer) ((LinkedHashMap) (item.get("owner"))).get("userId"));
            user.setUsername((String) ((LinkedHashMap) (item.get("owner"))).get("username"));
            user.setFirstName((String) ((LinkedHashMap) (item.get("owner"))).get("firstName"));
            user.setLastName((String) ((LinkedHashMap) (item.get("owner"))).get("lastName"));
            event.setOwner(user);
            result.add(event);
        }
        return result;
    }
}
