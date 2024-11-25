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
<title>Cerca un parlamentare dalla circoscrizione</title>
</head>
<body>

<h2>Ricerca parlamentare in base alla circoscrizione:</h2>


 <form  method="GET" action="/lista_parlamentari_circoscrizione.jsp"  modelAttribute="parlamentari"> 
<table>
<tr>
<td>Circoscrizione:</td>

  <td> <input type="text" name="circoscrizione"><br></td>
   </tr>
   <tr>
   <td>
       <td><input type="submit" value="invio" action="/lista_parlamentari_circoscrizione"></td></br>
   </tr>
   </table>
</form>
  
</body>
</html>