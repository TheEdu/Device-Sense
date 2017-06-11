package com.springBoot.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springBoot.project.dao.MetricDao;

@Controller
public class WelcomeController {
	
	@Autowired
	MetricDao metricDao;
	
	@RequestMapping("/")
	public String Welcome(Model model){
    	model.addAttribute("metricNames",metricDao.getMetricNames());
		return "welcome";
	}

}
