<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.giuggiola.entity.Parlamentare" %>
<%@ page import="com.giuggiola.entity.Periodi_cariche" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.PostgreSQLRangeType" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.Range" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Lista parlamentari</title>
</head>
<body>

      <h2>Lista dei parlamentari:</h2>
<form method="GET" action="/lista_parlamentari">
     <c:forEach items="${parlamentari}" var="parlamentare">
     <table>
   <tr>
    <td>Nome:</td>
    <td><c:out value="${parlamentare.nome}"/></td>
    </tr>
    <tr>
     <td>Partito:</td>
    <td><c:out value="${parlamentare.partito}"/></td>
    </tr>
    <tr>
     <td>Circoscrizione:</td>
   <c:forEach items="${parlamentare.circoscrizione}" var="CIRCOSCRIZIONE">
      <td><c:out value="${CIRCOSCRIZIONE}"/><br></td> 
       </c:forEach>
   </tr>
    <tr>
   <td>Data di nascita:</td>
   <td><c:out value="${parlamentare.data_nascita}"/><br></td>
 </tr>
 <tr>
     <td>Luogo:</td>
   <td><c:out value="${parlamentare.luogo}"/><br></td>
   </tr>
   <tr>
     <td>Titolo di studi:</td>
   <td><c:out value="${parlamentare.titolo_studi}"/><br></td>
   </tr>
   <tr>
   <td>Mandati:</td>
   <c:forEach items="${parlamentare.mandati}" var="mandato">
       <table>
        <tr>
       <td>Mandato:</td> 
       <td><c:out value="${mandato}"/></td>
       </tr>
       </table>
       </c:forEach>
 </tr>
 
 <tr>
     <td>Commissioni:</td>
      <c:forEach items="${parlamentare.commissioni}" var="commissione">
       <table>
        <tr>
       <td>Commissione:</td> 
       <td><c:out value="${commissione}"/></td>
       </tr>
       </table>
       </c:forEach>
   </tr>
 </table>
   </c:forEach>
</form>
    
</body>
</html>

