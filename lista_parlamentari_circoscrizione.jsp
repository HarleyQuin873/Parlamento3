<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.giuggiola.entity.Parlamentare" %>
<%@ page import="com.giuggiola.entity.Periodi_cariche" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.PostgreSQLRangeType" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.Range" %>   
<!DOCTYPE html>
<html>
<head>
    
<meta charset="UTF-8">

<title>Lista parlamentari di quella circoscrizione</title>
</head>
<body>

     <c:forEach items="${parlamentari}" var="parlamentare" >

<td>Nome:</td>
    <td><c:out value="${parlamentare.getPk().getNome()}"/></td>
    <br>
    </tr>
    <tr>
     <td>Partito:</td>
    <td><c:out value="${pk.partito}"/></td><br>
    </tr>
    <tr>
     <td>Circoscrizione:</td>
   <c:forEach items="${pk.getCircoscrizione()}" var="CIRCOSCRIZIONE">
      <td><c:out value="${CIRCOSCRIZIONE}"/></td> <br>
       </c:forEach>
   </tr>
   <br>
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
   <td>Mandati:</td><br>
   <c:forEach items="${parlamentare.mandati}" var="mandato">
       <table>
        <tr>
       <td>Mandato:</td> 
       <td><c:out value="${mandato}"/></td><br>
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
       <td><c:out value="${commissione}"/></td><br>
       </tr>
       </table>
       </c:forEach>
</c:forEach>

</body>
</html>