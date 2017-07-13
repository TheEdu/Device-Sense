<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7-1/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-timepicker-addon.min.css"/>
	<link rel="stylesheet" type="text/css" href="webjars/jquery-ui/1.11.0/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="webjars/metrics-graphics/2.11.0/dist/metricsgraphics.css"/>
	<style type="text/css">
		label{
			display:block;
		}
		
		.date-time-picker{
			width:215px;
		}
	
		.form-container{
			height: 200px;
			margin-left: 30px;
			
			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: space-around;
			align-items:flex-start;
		}
		
		.date-container{
			width:60%;
	
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: space-between;
			align-items:flex-start;
		}
	
		.axis path,
		.axis line {
		  	fill: none;
		  	stroke: #000;
		 	shape-rendering: crispEdges;
		}
		
		.x.axis path {
		  	display: none;
		}
		
		.line {
		  	fill: none;
		  	stroke: steelblue;
		  	stroke-width: 1.5px;
		}
		
	</style>
	
	<title>Device Sense</title>
</head>
<body>
	<div class="container-fluid">
		<h1>Device Sense</h1>
		<form:form action="/d3-graphic" method="POST" id="form1" modelAttribute="consulta">		
			<div class="form-container">
				<div class="item-flex">
					<label>Seleccione una Metrica:</label>
					<form:select id="select-metricas" path="metrica" class="form-control" name='metric-name'>
					    <c:forEach items="${metricNames}" var="metricName">
					       <option value="${metricName}">${metricName}</option>
					    </c:forEach>
					</form:select>
				</div>
				<div class="item-flex date-container">
					<div>
						<label>Desde</label>
						<form:input path="desde" type="text" class="date-time-picker"/>
						Hay que poner las horas relativas desde ahora (para probar 24)
					</div>
					<div>
						<label>Hasta</label>
						<form:input path="hasta" type="text" class="date-time-picker"/>
						 Hay que poner las horas relativas desde ahora (para probar 1)
					</div>
				</div>
				<div class="item-flex">
					<input type="submit" id="button_1" value="Consultar Metrica">
				</div>
				<div class="item-flex">
					<a href="/create-metric">
					   <input type="button" value="Crear Metrica" />
					</a>
				</div>
				
			</div>
		</form:form>
		
		<div id="testMG">
		</div>
	</div>
	
	<script type="text/javascript" src="webjars/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="webjars/jquery-ui/1.11.0/jquery-ui.js"></script>
	<script type="text/javascript" src="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-timepicker-addon.min.js"></script>
	<script type="text/javascript" src="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-sliderAccess.js"></script>
	<script type="text/javascript" src="webjars/d3js/4.2.1/d3.js"></script>
	<script type="text/javascript" src="webjars/metrics-graphics/2.11.0/dist/metricsgraphics.js"></script>
	
	<script type="text/javascript">
	
		var form = $('#form1');
		/*
		form.submit(function (event) {
			event.preventDefault();
			$.ajax({
		        type: form.attr('method'),
		        url:  form.attr('action'),
		        data: form.serialize(),
		        success: function (kairosData) {
		        	alert("Success");
		           	     
		            var margin = {top: 20, right: 20, bottom: 30, left: 50},
		                width = 700 - margin.left - margin.right,
		                height = 300 - margin.top - margin.bottom;

		            var x = d3.scaleTime()
		                .range([0, width])

		            var y = d3.scaleLinear()
		                .range([height, 0]);

		            var line = d3.line()
		                .x(function(d) { return x(d.date); })
		                .y(function(d) { return y(d.close); });

		            var svg = d3.select("body").append("svg")
		                .attr("width", width + margin.left + margin.right)
		                .attr("height", height + margin.top + margin.bottom)
		              .append("g")
		                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		              var data = kairosData.map(function(d) {
		                  return {
		                     date: new Date(d.timestamp),
		                     close: d.value
		                  };
		                  
		              });

		              x.domain(d3.extent(data, function(d) { return d.date; }));
		              y.domain(d3.extent(data, function(d) { return d.close; }));

		              svg.append("g")
		                  .attr("class", "x axis")
		                  .attr("transform", "translate(0," + height + ")")
		                  .call(d3.axisBottom(x));

		              svg.append("g")
		                  .attr("class", "y axis")
		                  .call(d3.axisLeft(y))
		                .append("text")
		                  .attr("transform", "rotate(-90)")
		                  .attr("y", 6)
		                  .attr("dy", ".71em")
		                  .style("text-anchor", "end")
		                  .text("Price ($)");

		              svg.append("path")
		                  .datum(data)
		                  .attr("class", "line")
		                  .attr("d", line);
	
		        },
		        error: function (e) {
					alert("error");
		            console.log("ERROR : ", e);
		            $("#btn-search").prop("disabled", false);
	
		        }
		    });
		});
 		*/		
 		form.submit(function (event) {
			event.preventDefault();
			$.ajax({
		        type: form.attr('method'),
		        url:  form.attr('action'),
		        data: form.serialize(),
		        success: function (kairosData) {
		        	alert("Success");
		        	var data = kairosData.map(function(d) {
		        		return {
		                     date: new Date(d.timestamp),
		                     value: d.value
		                  };
	                  });
		        	
					MG.data_graphic({
					    title: $("#select-metricas").val(),
					    description: "This is a simple line chart. You can remove the area portion by adding area: false to the arguments list.",
					    data: data,
					    width: 600,
					    height: 200,
					    right: 40,
					    target: document.getElementById('testMG'),
					    x_accessor: 'date',
					    y_accessor: 'value'
					});	
		        },
		        error: function (e) {
					alert("error");
		            console.log("ERROR : ", e);
		            $("#btn-search").prop("disabled", false);
	
		        }
		    });
		});
	</script>
	


	
	
</body>
</html>

