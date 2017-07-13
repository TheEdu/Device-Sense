package com.springBoot.project.controller;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import org.kairosdb.client.HttpClient;
import org.kairosdb.client.builder.*;
import org.kairosdb.client.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springBoot.project.dao.MetricDao;
import com.springBoot.project.repository.Consulta;

@Controller
@RequestMapping("/")
public class WelcomeController {
	
	@Autowired
	MetricDao metricDao;
	@Autowired
	Consulta consulta;

	@RequestMapping("/")
	public String Welcome(Model model){
    	model.addAttribute("metricNames",metricDao.getMetricNames());
    	consulta.setDesde(24);
    	consulta.setHasta(1);
    	model.addAttribute("consulta", consulta);
		return "welcome";
	}
	
	@RequestMapping("/create-metric")
	public String Create(Model model){
		model.addAttribute("consulta", consulta);
		return "create-metric";
	}
	
	
	@RequestMapping("/datosRandom")
	public String agregarDatosRandom(Consulta consulta,Model model) throws URISyntaxException, IOException, InterruptedException{
		
		MetricBuilder builder = MetricBuilder.getInstance();

		for(int i=1;i<=10;i++){
			builder.addMetric(consulta.getMetrica())
				.addTag("host", "server1")
				.addTag("customer", "Acme")
				.addDataPoint(System.currentTimeMillis(), Math.floor((Math.random()*100)));
			Thread.sleep(5);
		}
		HttpClient client = new HttpClient("http://localhost:8080");
		//Response response = client.pushMetrics(builder);
		client.pushMetrics(builder);
		client.shutdown();
		//model.addAttribute("metricNames",metricDao.getMetricNames());
		//return "welcome";
		return Welcome(model);
		
	}
	
	
	@RequestMapping(value = "/d3-graphic", method = RequestMethod.POST)
	public @ResponseBody
	List<DataPoint>  test(Consulta consulta) throws URISyntaxException, IOException{
		
		QueryBuilder builder = QueryBuilder.getInstance();
		builder.addMetric(consulta.getMetrica());					
		builder.setStart(consulta.getDesde(), TimeUnit.DAYS);
		HttpClient client = null;
		client = new HttpClient("http://localhost:8080");
		QueryResponse queryResponse;	
		queryResponse = client.query(builder);
		client.shutdown();
		List<DataPoint> datos = ((queryResponse.getQueries()).get(0)).getResults().get(0).getDataPoints();
		return datos;
		
		
		}

}
