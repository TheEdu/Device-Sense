package com.springBoot.project.controller;


import org.kairosdb.client.HttpClient;
import org.kairosdb.client.builder.AggregatorFactory;
import org.kairosdb.client.builder.QueryBuilder;
import org.kairosdb.client.builder.TimeUnit;
import org.kairosdb.client.response.GetResponse;
import org.kairosdb.client.response.QueryResponse;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class queryController {
	
    @RequestMapping("/metricNames")
	public GetResponse getMetricNames(){
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
		return response;
	}
    
    @RequestMapping("/DefaultMetricValues")
	public QueryResponse getMetricValues(){
    	QueryResponse response = null;
    	QueryBuilder builder = QueryBuilder.getInstance();
    	builder.setStart(5, TimeUnit.HOURS)
    	       .addMetric("kairosdb.datastore.query_time")
    	       .addAggregator(AggregatorFactory.createSumAggregator(1, TimeUnit.MILLISECONDS));
    	
    	try{
    		HttpClient client = new HttpClient("http://localhost:8080");
    		response = client.query(builder);
    		client.shutdown();
    	} catch (Exception e){
    		System.out.println("Error: " + e.getMessage());
    	}
		return response;
	}
    
}
