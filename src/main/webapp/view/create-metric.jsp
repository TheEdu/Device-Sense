<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7-1/css/bootstrap.min.css"/>	
	<title>Device Sense</title>
</head>
<body>
	<div class="container-fluid">
		<h2>Crear Metrica</h2>
		<form:form action="/datosRandom" method="POST" id="form2" modelAttribute="consulta">
			<div class="form-container">
				<div class="item-flex">
					<label>Nombre</label>
					<div>
						<form:input path="metrica" type="text" class="form-control"/>
					</div>
					<div class="item-flex">
						<input type="submit" id="button_2" value="Crear Metrica">
					</div>
				</div>
			</div>
		</form:form>
	</div>	
	<script type="text/javascript" src="webjars/jquery/3.2.1/jquery.min.js"></script>
</body>
</html>

