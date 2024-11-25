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
<meta charset="UTF-8">

<!-- <meta http-equiv="refresh" content="0; URL='/showParlamentare'" /> -->
<title>Cerca parlamentare dal nome</title>

<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
</head>
<body>

<h2>Leggi un parlamentare:</h2>
<form action="getParlamentare">
<!--  method="POST" action="showParlamentare.jsp">-->
<table>
<tr>
   <td>Nome:</td>
   <td><input type="text" name="nome"><br></td>
 </tr>
 <tr>
     <td>Partito:</td>
   <td><input type="text" name="partito"><br></td>
   </tr>
   <tr>
     <td>Circoscrizione:</td>
   <td><input type="text" name="circoscrizione"><br></td>
   </tr>
   <tr>
   <td><input type="submit" value="invio"><br></td>
   </tr>
   </table>
</form>
<a href = "showParlamentare.jsp"> risultato </ a>
</body>
</html>


<!-- <h2>Ricerca parlamentare in base al nome:</h2>
<form action="getParlamentare2">
<table>
<tr>
 <td>Nome:</td>
   <td><input type="text" name="nome"><br></td>
   </tr>
   <tr>
  <td> <input type="submit" value="invio"><br></td>
   </tr>
   </table>
</form> -->


<!-- <h2>Leggi un parlamentare:</h2>
<form action="getParlamentare">
<table>
<tr>
   <td>Nome:</td>
   <td><input type="text" name="nome"><br></td>
 </tr>
 <tr>
     <td>Partito:</td>
   <td><input type="text" name="partito"><br></td>
   </tr>
   <tr>
     <td>Circoscrizione:</td>
   <td><input type="text" name="circoscrizione"><br></td>
   </tr>
   <tr>
   <td><input type="submit" value="invio"><br></td>
   </tr>
   </table>
</form> -->