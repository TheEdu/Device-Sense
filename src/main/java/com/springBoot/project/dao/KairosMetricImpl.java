package com.springBoot.project.dao;

import java.util.List;

import org.kairosdb.client.HttpClient;
import org.kairosdb.client.builder.AggregatorFactory;
import org.kairosdb.client.builder.QueryBuilder;
import org.kairosdb.client.builder.TimeUnit;
import org.kairosdb.client.response.QueryResponse;
import org.springframework.stereotype.Repository;

@Repository
public class KairosMetricImpl implements MetricDao {

	@Override
	public List<String> getMetricNames() {
		List<String> result = null;
    	try{
	    	HttpClient client = new HttpClient("http://localhost:8090");
	    	result = client.getMetricNames().getResults();
	    	client.shutdown();
    	} catch(Exception e){
    		System.out.println("Error: " + e.getMessage());
    	}
		return result;
	}

	@Override
	public QueryResponse getMetricValues(String metricName) {
		QueryResponse response = null;
    	QueryBuilder builder = QueryBuilder.getInstance();
    	builder.setStart(5, TimeUnit.HOURS)
    	       .addMetric("metricName")
    	       .addAggregator(AggregatorFactory.createSumAggregator(1, TimeUnit.MILLISECONDS));
    	
    	try{
    		HttpClient client = new HttpClient("http://localhost:8090");
    		response = client.query(builder);
    		client.shutdown();
    	} catch (Exception e){
    		System.out.println("Error: " + e.getMessage());
    	}
		return response;
	}

}
