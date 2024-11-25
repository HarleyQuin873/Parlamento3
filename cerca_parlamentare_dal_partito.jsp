<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.giuggiola.entity.Parlamentare" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.PostgreSQLRangeType" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.Range" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cerca parlamentare dal partito</title>
<!--  
<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
-->
</head>
<body>

<form method="GET" action="lista_parlamentari.jsp">

<!--  <h2>Ricerca parlamentare in base al partito:</h2> -->
<table>
<tr>
<td>Partito:</td>
   <td><input type="text" name="partito"><br></td>
   </tr>
   <tr>
   <td><input type="submit" value="invio"><br></td>
   </tr>
   </table>
</form>



</body>
</html>

<!-- <h2>Ricerca parlamentare in base al partito:</h2>
<form action="getParlamentare3">
<table>
<tr>
<td>Partito:</td>
   <td><input type="text" name="partito"><br></td>
   </tr>
   <tr>
   <td><input type="submit" value="invio"><br></td>
   </tr>
   </table>
</form> -->