<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<form action="#" method="post">		
			<div class="form-container">
				<div class="item-flex">
					<label>Seleccione una Metrica:</label>
					<select class="form-control" name='metric-name'>
					    <c:forEach items="${metricNames}" var="metricName">
					       <option value="${metricName}">${metricName}</option>
					    </c:forEach>
					</select>
				</div>
				<div class="item-flex date-container">
					<div>
						<label>Desde</label>
						<input type="text" id="dateFrom" class="date-time-picker">
					</div>
					<div>
						<label>Hasta</label>
						<input type="text" id="dateTo" class="date-time-picker">
					</div>
				</div>
				<div class="item-flex">
					<input type="submit" value="Consultar Metrica"> falta implementar xD
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="webjars/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="webjars/jquery-ui/1.11.0/jquery-ui.js"></script>
	<script type="text/javascript" src="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-timepicker-addon.min.js"></script>
	<script type="text/javascript" src="webjars/jQuery-Timepicker-Addon/1.4.5/jquery-ui-sliderAccess.js"></script>
	<script>
	  $( function() {
		$(".date-time-picker").datetimepicker({
			showTimezone: false,
			showTime: false,
			showMicrosec: false,
			showMillisec: true,
			dateFormat: "yy-mm-dd",
			timeFormat: "hh:mm:ss.l tt"
		});
	  });
	</script>
</body>
</html>