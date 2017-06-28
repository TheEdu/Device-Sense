<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tablita</title>
</head>
<body>

	<table>    
	    <thead>        
		    <tr>                                                      
		          <th>Valor</th>
		          <th>Timestamp</th>
		    </tr>
	    </thead>
	    <tbody id="tabla-ajax" >
	      <c:forEach items="${datos}" var="d"> 
   
	       <tr>
	        <td><c:out value="${d.getValue()}"/></td>      
	        <td>${Date(Long.parseLong(d.getTimestamp()))}</td>               
	      </tr> 
	    </c:forEach> 
	  </tbody>
	</table>

</body>
</html>