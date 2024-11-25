<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.giuggiola.entity.Parlamentare" %>
<%@ page import="com.giuggiola.entity.Periodi_cariche" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.PostgreSQLRangeType" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.Range" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancella parlamentare</title>
</head>
<body>

<h2>Elimina un parlamentare</h2>
<form method="POST" action="parlamentareDeleted.jsp">
 <table>
 <tr>
  <td>Nome:</td>
    <td>
   <input type="text" name="nome"><br>
   </td>
   </tr>
   <tr>
      <td>
   <input type="submit" value="invio"><br>
   </td>
   </tr>
   </table>
</form>

</body>
</html>
<!-- <h2>Elimina un parlamentare</h2>
<form action="deleteParlamentare">
 <table>
 <tr>
  <td>Nome:</td>
    <td>
   <input type="text" name="nome"><br>
   </td>
   </tr>
   <tr>
      <td>
   <input type="submit" value="invio"><br>
   </td>
   </tr>
   </table>
</form> -->