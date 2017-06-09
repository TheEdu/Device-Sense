package com.springBoot.project.controller;

import java.util.List;

import org.kairosdb.client.HttpClient;
import org.kairosdb.client.response.GetResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WelcomeController {
	
	@RequestMapping("/")
	public String Welcome(Model model){
		model.addAttribute("message", "Hola Mundo");
		
		GetResponse response = null;
    	try{
	    	HttpClient client = new HttpClient("http://localhost:8080");
	    	response = client.getMetricNames();
	
	    	System.out.println("Response Code =" + response.getStatusCode());
	    	for (String name : response.getResults()){
	    		System.out.println(name);
	    	}
	    	
	    	client.shutdown();
    	} catch(Exception e){
    		System.out.println("Error: " + e.getMessage());
    	}
    	List<String> metricNames = response.getResults();
    	
    	model.addAttribute("metricNames",metricNames);
			
		return "welcome";
	}

}
