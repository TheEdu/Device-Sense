package com.springBoot.project.dao;

import java.util.List;

import org.kairosdb.client.response.QueryResponse;

public interface MetricDao {
	
	public List<String> getMetricNames();
	public QueryResponse getMetricValues(String metricName);

}
