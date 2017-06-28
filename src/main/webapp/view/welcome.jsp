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
		
	</style>
	
	<title>Device Sense</title>
</head>
<body>
	<div class="container-fluid">
		<h1>Device Sense</h1>
		<form:form action="/device" method="POST" id="form1" modelAttribute="consulta">		
			<div class="form-container">
				<div class="item-flex">
					<label>Seleccione una Metrica:</label>
					<form:select path="metrica" class="form-control" name='metric-name'>
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
			</div>
		</form:form>
	</div>
	<div id="div-ajax">

	</div>
	
	<script type="text/javascript" src="webjars/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="webjars/jquery-ui/1.11.0/jquery-ui.js"></script>
	<script type="text/javascript" src="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-timepicker-addon.min.js"></script>
	<script type="text/javascript" src="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-sliderAccess.js"></script>
	<script type="text/javascript" src="webjars/d3js/4.2.1/d3.js"></script>
	<script type="text/javascript" src="webjars/d3js/4.2.1/d3.min.js"></script>
	<script type="text/javascript" src="webjars/highcharts/4.0.4/highcharts-all.js"></script>
	
	<script type="text/javascript">
 		var form = $('#form1');
		form.submit(function () {	<%-- La funcion llama al metodo procesarQuery y mete la respuesta en el div-ajax --%>
		 
		$.ajax({
		type: form.attr('method'),				
		url: form.attr('action'),
		data: form.serialize(),
		success: function (data) {
			$("#div-ajax").html(data);
		 
		}
		});
		 
		return false;
		});
	</script>
	
</body>
</html>

