<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
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
		


		.area {
		  fill: steelblue;
		  clip-path: url(#clip);
		}
		
		.zoom {
		  cursor: move;
		  fill: none;
		  pointer-events: all;
		}
		
	
	</style>
	<meta charset="utf-8">
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
		
		<svg width="960" height="500"></svg>
		
	</div>
	

	<script type="text/javascript" src="webjars/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="webjars/jquery-ui/1.11.0/jquery-ui.js"></script>
	<script type="text/javascript" src="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-timepicker-addon.min.js"></script>
	<script type="text/javascript" src="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-sliderAccess.js"></script>
	<script type="text/javascript" src="webjars/d3js/4.2.1/d3.js"></script> 
	<script type="text/javascript" src="webjars/d3js/4.2.1/d3.min.js"></script>
	<script type="text/javascript" src="webjars/metrics-graphics/2.11.0/dist/metricsgraphics.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script type="text/javascript" src="webjars/d3/4.9.1/d3.min.js"></script> 
	
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
 		/*form.submit(function (event) {
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
					    width: 1000,
					    height: 400,
					    animate_on_load: true,
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
		});*/
		
 		/*form.submit(function (event) {
			event.preventDefault();
			$.ajax({
		        type: form.attr('method'),
		        url:  form.attr('action'),
		        data: form.serialize(),
		        success: function (kairosData) {
		        	alert("Success");
		        	var data = kairosData.map(function(d) {
		        		return {
		                     x: d.timestamp,
		                     y: d.value
		                  };
	                  });
		        	
		        	
		        	Highcharts.chart('testMG', {
		                chart: {
		                    zoomType: 'x'
		                },
		                title: {
		                    text: $("#select-metricas").val()
		                },
		                subtitle: {
		                    text: document.ontouchstart === undefined ?
		                            'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
		                },
		                xAxis: {
		                    type: 'datetime'
		                },
		                yAxis: {
		                    title: {
		                        text: 'Value'
		                    }
		                },
		                legend: {
		                    enabled: false
		                },
		                plotOptions: {
		                    area: {
		                        fillColor: {
		                            linearGradient: {
		                                x1: 0,
		                                y1: 0,
		                                x2: 0,
		                                y2: 1
		                            },
		                            stops: [
		                                [0, Highcharts.getOptions().colors[0]],
		                                [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
		                            ]
		                        },
		                        marker: {
		                            radius: 2
		                        },
		                        lineWidth: 1,
		                        states: {
		                            hover: {
		                                lineWidth: 1
		                            }
		                        },
		                        threshold: null
		                    }
		                },

		                series: [{
		                    type: 'area',
		                    name: 'Value',
		                    data: data
		                }]
		            });
		        },
		        error: function (e) {
					alert("error");
		            console.log("ERROR : ", e);
		            $("#btn-search").prop("disabled", false);
	
		        }
		    });
		});*/
		
		
 		form.submit(function (event) {
			event.preventDefault();
			$("svg").empty();
			$.ajax({
		        type: form.attr('method'),
		        url:  form.attr('action'),
		        data: form.serialize(),
		        success: function (kairosData) {

		        	alert("Success");
			        var svg = d3.select("svg"),
			            margin = {top: 20, right: 20, bottom: 110, left: 40},
			            margin2 = {top: 430, right: 20, bottom: 30, left: 40},
			            width = +svg.attr("width") - margin.left - margin.right,
			            height = +svg.attr("height") - margin.top - margin.bottom,
			            height2 = +svg.attr("height") - margin2.top - margin2.bottom;
		
			        var x = d3.scaleTime().range([0, width]),
			            x2 = d3.scaleTime().range([0, width]),
			            y = d3.scaleLinear().range([height, 0]),
			            y2 = d3.scaleLinear().range([height2, 0]);
		
			        var xAxis = d3.axisBottom(x),
			            xAxis2 = d3.axisBottom(x2),
			            yAxis = d3.axisLeft(y);
		
			        var brush = d3.brushX()
			            .extent([[0, 0], [width, height2]])
			            .on("brush end", brushed);
		
			        var zoom = d3.zoom()
			            .scaleExtent([1, Infinity])
			            .translateExtent([[0, 0], [width, height]])
			            .extent([[0, 0], [width, height]])
			            .on("zoom", zoomed);
		
			        var area = d3.area()
			            //.curve(d3.curveMonotoneX)
			            .x(function(d) { return x(d.date); })
			            .y0(height)
			            .y1(function(d) { return y(d.price); });
		
			        var area2 = d3.area()
			            //.curve(d3.curveMonotoneX)
			            .x(function(d) { return x2(d.date); })
			            .y0(height2)
			            .y1(function(d) { return y2(d.price); });
		
			        svg.append("defs").append("clipPath")
			            .attr("id", "clip")
			          .append("rect")
			            .attr("width", width)
			            .attr("height", height);
		
			        var focus = svg.append("g")
			            .attr("class", "focus")
			            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
			        var context = svg.append("g")
			            .attr("class", "context")
			            .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")");
			        	
			        var data = kairosData.map(function(d) {
			        		return {
			                     date: new Date(d.timestamp),
			                     price: d.value
			                  };
		                  });
		        
					x.domain(d3.extent(data, function(d) { return d.date; }));
					y.domain([0, d3.max(data, function(d) { return d.price; })]);
					x2.domain(x.domain());
					y2.domain(y.domain());
					
					focus.append("path")
					    .datum(data)
					    .attr("class", "area")
					    .attr("d", area);
					
					focus.append("g")
					    .attr("class", "axis axis--x")
					    .attr("transform", "translate(0," + height + ")")
					    .call(xAxis);
					
					focus.append("g")
					    .attr("class", "axis axis--y")
					    .call(yAxis);
					
					context.append("path")
					    .datum(data)
					    .attr("class", "area")
					    .attr("d", area2);
					
					context.append("g")
					    .attr("class", "axis axis--x")
					    .attr("transform", "translate(0," + height2 + ")")
					    .call(xAxis2);

					context.append("g")
					    .attr("class", "brush")
					    .call(brush)
					    .call(brush.move, x.range());
					
					svg.append("rect")
					    .attr("class", "zoom")
					    .attr("width", width)
					    .attr("height", height)
					    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
					    .call(zoom);
					
				
					 function brushed() {
						if (d3.event.sourceEvent && d3.event.sourceEvent.type === "zoom") return; // ignore brush-by-zoom
						var s = d3.event.selection || x2.range();
						x.domain(s.map(x2.invert, x2));
						focus.select(".area").attr("d", area);
						focus.select(".axis--x").call(xAxis);
						svg.select(".zoom").call(zoom.transform, d3.zoomIdentity
						    .scale(width / (s[1] - s[0]))
						    .translate(-s[0], 0));
					}
					
					function zoomed() {
						if (d3.event.sourceEvent && d3.event.sourceEvent.type === "brush") return; // ignore zoom-by-brush
						var t = d3.event.transform;
						x.domain(t.rescaleX(x2).domain());
						focus.select(".area").attr("d", area);
						focus.select(".axis--x").call(xAxis);
						context.select(".brush").call(brush.move, x.range().map(t.invertX, t));
					}

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

