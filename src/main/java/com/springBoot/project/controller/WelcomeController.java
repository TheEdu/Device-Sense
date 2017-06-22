package com.springBoot.project.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import org.kairosdb.client.HttpClient;
import org.kairosdb.client.builder.*;
import org.kairosdb.client.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.springBoot.project.dao.MetricDao;

@Controller
@RequestMapping("/")
public class WelcomeController {
	
	@Autowired
	MetricDao metricDao;

	@RequestMapping(method=RequestMethod.GET)
	public String Welcome(Model model){
    	model.addAttribute("metricNames",metricDao.getMetricNames());
    	model.addAttribute("consulta", new Consulta());
		return "welcome";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public String procesarQuery(Consulta consulta, Model model) throws IOException, URISyntaxException{
		QueryBuilder builder = QueryBuilder.getInstance();
		builder.addMetric(consulta.getMetrica());							//Para cree un objeto Consulta que tiene el nombre de la metrica
		builder.setStart(consulta.getDesde(), TimeUnit.valueOf("DAYS"));	//y los desde y hasta. Estas lineas crean la query para Kairos
		builder.setEnd(consulta.getHasta(), TimeUnit.valueOf("DAYS"));		//
		HttpClient client = new HttpClient("http://localhost:8080");
		QueryResponse queryResponse = client.query(builder);				//consulta al cliente con la query que armamos
		client.shutdown();
		
		model.addAttribute("metricNames",metricDao.getMetricNames());		//pasa los nombres de todas las metricas a la vista
		model.addAttribute("datos", ((queryResponse.getQueries()).get(0)).getResults().get(0).getDataPoints());	//pasa los datos a la vista
		
		return "welcome";
	}

}
