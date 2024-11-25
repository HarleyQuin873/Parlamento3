<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Parlamentare cancellato
 <form action="deleteParlamentare">
     <c:forEach items="${parlamentari}" var="parlamentare">     
   <tr>
    <td><c:out value="${parlamentare.nome}"/></td>
    </tr>
    <tr>
    <td><c:out value="${parlamentare.partito}"/></td>
    </tr>
    <tr>
    <td><c:out value="${parlamentare.circoscrizione}"/><br></td>
   </tr>
   <tr>
    <td><c:out value="${parlamentare.data_nascita}"/></td>
    </tr>
    <tr>
    <td><c:out value="${parlamentare.luogo}"/></td>
    </tr>
    <tr>
    <td><c:out value="${parlamentare.titolo_studi}"/><br></td>
   </tr>
   <tr>
    <td><c:out value="${parlamentare.mandati}"/></td>
    </tr>
    <tr>
    <td><c:out value="${parlamentare.commissioni}"/></td>
    </tr>
    <tr>
    <td><c:out value="${parlamentare.periodi_cariche}"/><br></td>
   </tr>
   
  </c:forEach>
     </form>
</body>
</html>