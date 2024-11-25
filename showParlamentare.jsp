<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- leggi_parlamentare.jsp -->
<title>Parlamentare restituito</title>
</head>
<body>
    <form action="getParlamentare">     
    
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
  
   </form>  
      
</body>
</html>