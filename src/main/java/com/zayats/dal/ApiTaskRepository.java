package com.zayats.dal;

import com.zayats.model.Task;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ApiTaskRepository {

	private RestTemplate restTemplate;

	private static final Logger logger = Logger
			.getLogger(ApiTaskRepository.class);

	@Autowired
	public void setRestTemplate(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}

	public boolean deleteTask(int taskID) {
		logger.info("Go to api: delete task");

		List<Boolean> result = new ArrayList<Boolean>();
		result = restTemplate.getForObject(ApiUtils.url + "/home/tasks/delete/"
				+ taskID, List.class);
		return result.get(0);
	}

	public List<Task> getTasks(int eventId/*, String type*/) {
		logger.info("Go to api: get shoplists for family");

		return restTemplate.getForObject(ApiUtils.url + "/home/tasks/get/"
				+ eventId, List.class);
	}

    public HashMap<String, Integer> getChartData(int eventId) {
        logger.info("Go to api: get ChartData");

        HashMap<String, Integer> result = new HashMap<String, Integer>();
        result = restTemplate.getForObject(ApiUtils.url
                + "/home/tasks/chart/" + eventId, HashMap.class);
        return result;
    }

    public boolean addTask(Task task) {
        logger.info("Go to api: add task");

        List<Boolean> result = new ArrayList<Boolean>();
        result = restTemplate.postForObject(ApiUtils.url + "/home/tasks/add/", task, List.class);
        return result.get(0);
    }

    public List<Task> getTasksForUser(int eventId, Integer userId) {
        logger.info("Go to api: get tasks for user");

        return restTemplate.getForObject(ApiUtils.url + "/home/tasks/get/"
                + eventId + "/" + userId, List.class);
    }

    public Task taskDetail(int taskId) {
        logger.info("Go to api: get task details");

        Task taskList = restTemplate.getForObject(ApiUtils.url + "/home/tasks/detail/"
                + taskId, Task.class);
        return taskList != null ? taskList : null;
    }

    public Boolean editTask(Integer taskId, String status, Integer responsibleId) {
        logger.info("Go to api: get task details");

        Boolean result = restTemplate.getForObject(ApiUtils.url + "/home/tasks/edit/"
                + taskId + "/" + status + "/" + responsibleId, Boolean.class);
        return result != null ? result : null;
    }
}
