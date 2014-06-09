package com.zayats.controller;

import com.zayats.dal.ApiEventRepository;
import com.zayats.dal.ApiTaskRepository;
import com.zayats.exceptions.EventNotExistsException;
import com.zayats.model.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/home/tasks")
public class TasksController extends AuthorizedController {

    @Autowired
    ApiTaskRepository taskRepository;

    @Autowired
    ApiEventRepository eventsRepository;

    @Autowired
    ApiEventRepository eventRepository;

    private static final Logger logger = Logger
            .getLogger(TasksController.class);

    @RequestMapping(value = "")
    public String getEvents(Model model, Principal principal) {
        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Tasks");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);
        model.addAttribute("userId", getCurrentUser().getUserId());

        List<Event> list = null;
        try {
            logger.info("Get events for user.");
            list = eventRepository.getAllEventsForUser(getCurrentUser().getUserId());
        } catch (EmptyResultDataAccessException e) {
            logger.info("Can't get events for user. No data received.");
            model.addAttribute("error",
                    "Can't get events for user. Please, try later.");
        }

        if (list.size() == 0)
            list = null;

        model.addAttribute("eventList", list);
        return "tasks";
    }

    @RequestMapping(value = "/get/{eventId}", method = RequestMethod.GET)
    public
    @ResponseBody
    List<Task> getTasks(@PathVariable int eventId/*, @PathVariable String type*/) {
        logger.info("Get tasks");

        List<Task> tasks = taskRepository
                .getTasks(eventId/*, type*/);
        return tasks;
    }

    @RequestMapping(value = "/getForUser/{eventId}", method = RequestMethod.GET)
    public
    @ResponseBody
    List<Task> getTasksForUser(@PathVariable int eventId/*, @PathVariable String type*/) {
        logger.info("Get tasks");

        List<Task> tasks = taskRepository
                .getTasksForUser(eventId, getCurrentUser().getUserId()/*, type*/);
        return tasks;
    }

    @RequestMapping(value = "/show/{eventId}", method = RequestMethod.GET)
    public String showTasks(@PathVariable int eventId/*, @PathVariable String type*/, Model model, Principal principal) {
        logger.info("Get tasks");
        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Events");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);
        model.addAttribute("userId", getCurrentUser().getUserId());
        List<Task> tasks = taskRepository
                .getTasks(eventId/*, type*/);
        if (tasks.size() == 0) {
            tasks = null;
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

        List<User> usersList = null;
        try {
            usersList = eventsRepository.getParticipans(eventId);
        } catch (EventNotExistsException e) {
            model.addAttribute("errors", e.getMessage());
            logger.info("No such event");
            return "event_details";
        }
        if (usersList.size() == 0) {
            usersList = null;
        }
        model.addAttribute("event", eventList.get(0));
        model.addAttribute("users", usersList);
        model.addAttribute("tasks", tasks);
        return "task_manager";
    }

    @RequestMapping(value = "/chart/{eventId}", method = RequestMethod.GET)
    public
    @ResponseBody
    HashMap<String, Integer> getChartData(@PathVariable int eventId) {
        logger.info("Get chart data");

        HashMap<String, Integer> chartData = taskRepository
                .getChartData(eventId);
        return chartData;
    }

    @RequestMapping(value = "/add")
    public String addTask(@RequestParam("name") String name,
                          @RequestParam("dueDate") String dueDate,
                          @RequestParam("responsible") String responsible,
                          @RequestParam("description") String description,
                          @RequestParam("eventId") String eventId,
                          Model model,
                          Principal principal) {
        logger.info("Creating new task");

        model.addAttribute("navigation", naviMap);
        model.addAttribute("title", "Events");
        String username = principal.getName(); // get logged in username
        model.addAttribute("username", username);
        User user = new User();
        user.setUserId(Integer.parseInt(responsible));
        SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
        Date dateFormatted = null;
        try {
            dateFormatted = formatter.parse(dueDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Task task = new Task(name, TaskStatus.OPEN, description, new Date(), dateFormatted, null, Integer.parseInt(eventId), user);
        String errors = "";
        if (taskRepository.addTask(task) == false) {
            errors = "Unexpected error.";
        }
        model.addAttribute("errors", errors);
        return "redirect:/home/tasks/show/" + eventId;
    }

    @RequestMapping(value = "/delete/{taskId}", method = RequestMethod.GET)
    public
    @ResponseBody
    List<Boolean> deleteShoplist(@PathVariable int taskId) {
        logger.info("Delete task");

        List<Boolean> result = new ArrayList<Boolean>();
        result.add(taskRepository.deleteTask(taskId));
        return result;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String editTask(@RequestParam("status") String status, @RequestParam("taskId") Integer taskId, @RequestParam("responsible") Integer responsible) {
        logger.info("Edit task");
        List<Boolean> result = new ArrayList<Boolean>();
        result.add(taskRepository.editTask(taskId, status, responsible));
        return "redirect:/home/tasks/detail/" + taskId;
    }

    @RequestMapping(value = "/detail/{taskId}", method = RequestMethod.GET)
    public String getDetails(@PathVariable int taskId, Model model) {
        logger.info("Get Task details");

        Task task = taskRepository.taskDetail(taskId);
        model.addAttribute("navigation", naviMap);
        model.addAttribute("task", task);
        String username = getCurrentUser().getUsername(); // get logged in username
        model.addAttribute("username", username);
        model.addAttribute("userId", getCurrentUser().getUserId());
        List<User> usersList = null;
        try {
            usersList = eventsRepository.getParticipans(task.getEventId());
        } catch (EventNotExistsException e) {
            model.addAttribute("errors", e.getMessage());
            logger.info("No such event");
            return "event_details";
        }
        if (usersList.size() == 0) {
            usersList = null;
        }
        List<Event> eventList = null;
        try {
            eventList = eventsRepository.getEvent(task.getEventId());
        } catch (EventNotExistsException e) {
            model.addAttribute("errors", e.getMessage());
            logger.info("No such event");
            return "event_details";
        }
        if (eventList.size() == 0) {
            eventList = null;
        }
        model.addAttribute("users", usersList);
        model.addAttribute("event", eventList.get(0));
        return "task_details";
    }
}
