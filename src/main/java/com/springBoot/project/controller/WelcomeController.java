package com.springBoot.project.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;

import org.kairosdb.client.HttpClient;
import org.kairosdb.client.builder.*;
import org.kairosdb.client.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springBoot.project.dao.MetricDao;

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
    	model.addAttribute("consulta", consulta);
		return "welcome";
	}
	
	@RequestMapping("/device")
	public String procesarQuery(Consulta consulta, Model model) throws IOException, URISyntaxException{
		QueryBuilder builder = QueryBuilder.getInstance();
		builder.addMetric(consulta.getMetrica());					//Cree un objeto Consulta que tiene el nombre de la metrica
		builder.setStart(consulta.getDesde(), TimeUnit.DAYS);	    //y los desde y hasta. Estas lineas crean la query para Kairos
		//builder.setEnd(consulta.getHasta(), TimeUnit.DAYS));		//
		HttpClient client = new HttpClient("http://localhost:8080");
		QueryResponse queryResponse = client.query(builder);				//consulta al cliente con la query que armamos
		client.shutdown();
		
		List<DataPoint> datos = ((queryResponse.getQueries()).get(0)).getResults().get(0).getDataPoints();

		model.addAttribute("datos", datos);	//pasa los datos a la vista
		
		return "tablita";		//Devuelve la vista tablita, que solo tiene la tabla que muestra los datos
	}
	
	
	@RequestMapping("/datosRandom")
	public void agregarDatosRandom(Consulta consulta,Model model) throws URISyntaxException, IOException, InterruptedException{
		
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
		
	}

}
