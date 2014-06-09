package com.zayats.controller;

import com.zayats.dal.ApiEventRepository;
import com.zayats.exceptions.DataAccessDbException;
import com.zayats.exceptions.EventNotExistsException;
import com.zayats.model.Event;
import com.zayats.model.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "home/events")
public class EventsController extends AuthorizedController {

    String errors;

    @Autowired
    ApiEventRepository eventsRepository;

    private static final Logger logger = Logger
            .getLogger(EventsController.class);

    @RequestMapping(value = "")
    public String events(Model model, Principal principal) {
        logger.info("Getting events for user");

        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Events");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);

        List<Event> list = eventsRepository.getEventsForUser(getCurrentUser().getUserId());
        List<Event> result = new ArrayList<Event>();
        if (list.size() == 0) {
            list = null;
        }

        model.addAttribute("eventsList", list);
        model.addAttribute("errors", errors);
        return "events";
    }

    @RequestMapping(value = "/{eventId}")
    public String getEvent(@PathVariable String eventId, Model model,
                                Principal principal) {
        logger.info("Getting event details");

        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Event Manager");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);
        model.addAttribute("userId", getCurrentUser().getUserId());
        model.addAttribute("eventsId", eventId);

        List<Event> eventList = null;
        try {
            eventList = eventsRepository.getEvent(Integer.parseInt(eventId));
        } catch (EventNotExistsException e) {
            model.addAttribute("errors", e.getMessage());
            logger.info("No such event");
            return "event_details";
        }
        if (eventList.size() == 0) {
            eventList = null;
        }

        model.addAttribute("title", eventList.get(0).getName());
        model.addAttribute("event", eventList.get(0));
        return "event_details";
    }

    @RequestMapping(value = "/users/{eventId}")
    public String eventsManager(@PathVariable int eventId, Model model,
                                Principal principal) {
        logger.info("Getting events participants for event manager");

        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Users Manager");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);

        List<User> list = null;
        try {
            list = eventsRepository.getParticipans(eventId);
        } catch (EventNotExistsException e) {
            model.addAttribute("errors", e.getMessage());
            logger.info("No such events");
            return "user_manager";
        } catch (EmptyResultDataAccessException e) {
            model.addAttribute("errors",
                    "There are no users in events. You can invite someone.");
        }
        if (list.size() == 0) {
            list = null;
        }

        List<Event> eventList = null;
        try {
            eventList = eventsRepository.getEvent(eventId);
        } catch (EventNotExistsException e) {
            model.addAttribute("errors", e.getMessage());
            logger.info("No such event");
            return "event_details";
        }
        if (eventList.size() == 0) {
            eventList = null;
        }
        model.addAttribute("event", eventList.get(0));
        model.addAttribute("users", list);
        return "user_manager";
    }

    @RequestMapping(value = "/add")
    public String addEvent(@RequestParam("name") String name,
                           @RequestParam("date") String date,
                           @RequestParam("address") String address,
                           @RequestParam("description") String description,
                           Model model,
                           Principal principal) {
        logger.info("Creating new events");

        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Events");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);
        User user = new User();
        user.setUserId(getCurrentUser().getUserId());
        SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        Date dateFormatted = null;
        try {
            dateFormatted = formatter.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Event event = new Event(name, description, dateFormatted, address, user);
        try {
            if (eventsRepository.createEvent(event) == false) {
                errors = "You have already had events with such name. Type another name for events.";
            }
        } catch (DataAccessDbException e) {
            errors = e.getMessage();
        }

        return "redirect:/home/events";
    }

    @RequestMapping(value = "/delete/{eventsId}")
    public String deleteEvent(@PathVariable String eventsId, Model model,
                              Principal principal) {
        logger.info("Delete events");

        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Events");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);

        try {
            eventsRepository.deleteEvent(Integer.parseInt(eventsId));
        } catch (DataAccessDbException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/home/events";
    }

    @RequestMapping(value = "/calendar")
    public String calendar(Model model, Principal principal) {
        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Events");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);
        List<Event> list = null;
        try {
            logger.info("Get events for user.");
            list = eventsRepository.getAllEventsForUser(getCurrentUser().getUserId());
        } catch (EmptyResultDataAccessException e) {
            logger.info("Can't get events for user. No data received.");
            model.addAttribute("error",
                    "Can't get events for user. Please, try later.");
        }

        if (list.size() == 0)
            list = null;

        model.addAttribute("events", list);
        return "calendar";
    }
}
