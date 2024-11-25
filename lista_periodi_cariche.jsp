<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.giuggiola.entity.Parlamentare" %>
<%@ page import="com.giuggiola.entity.Periodi_cariche" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.PostgreSQLRangeType" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.Range" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Lista periodi cariche dei parlamentari</title>
<%@ page %>

</head>
<body>
     
     <h2>Lista periodi cariche:</h2>
<form action="getPeriodi_cariche">
     
   
     <h1>Periodi delle cariche: </h1>
     
     <c:forEach items="${periodi_cariche}" var="per_car">
     
     <tr> 
    <td>Nome:</td> 
       <td>${per_car.pk.nome}</td><br>
       <td>Mandato/commissione:</td> 
       <td>${per_car.pk.mandato_commissione}</td><br>
       <td>Periodo carica:</td> 
       <td>${per_car.periodo_carica}</td> <br>
       <br>
       </c:forEach>
      
     </form> 
</body>
</html>