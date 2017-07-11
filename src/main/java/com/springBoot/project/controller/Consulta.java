package com.springBoot.project.controller;

import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Repository
@JsonIgnoreProperties(ignoreUnknown = true)
public class Consulta {
	
	private String metrica;
	private Integer desde;
	private Integer hasta;
	
	public Consulta(){
		
	}

	public String getMetrica() {
		return metrica;
	}

	public void setMetrica(String metrica) {
		this.metrica = metrica;
	}

	public Integer getDesde() {
		return desde;
	}

	public void setDesde(Integer desde) {
		this.desde = desde;
	}

	public Integer getHasta() {
		return hasta;
	}

	public void setHasta(Integer hasta) {
		this.hasta = hasta;
	}

}
