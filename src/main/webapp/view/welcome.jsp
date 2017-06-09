<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7-1/css/bootstrap.min.css"/>
	<title>Device Sense</title>
</head>
<body>
	<div class="container-fluid">
		<div>
			<h1>Device Sense</h1>
		</div>
		<div>
			<form action="#" method="post">
				<label for="metric-names">Seleccione una Metrica:</label>
				<select class="form-control" name='metric-name'>
				    <c:forEach items="${metricNames}" var="metricName">
				       <option value="${metricName}">${metricName}</option>
				    </c:forEach>
				</select>
				<input type="submit" value="Consultar Metrica"> falta implementar xD
			</form>
		</div>
	</div>	
<script type="text/javascript" src="webjars/jquery/3.2.1/jquery.min.js"></script>
</body>
</html>