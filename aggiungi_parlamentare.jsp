<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.giuggiola.entity.Parlamentare" %>
<%@ page import="com.giuggiola.entity.Periodi_cariche" %>
<%@ page import="com.giuggiola.entity.Range2PK" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.PostgreSQLRangeType" %>
<%@ page import="com.vladmihalcea.hibernate.type.range.Range" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Aggiungi un parlamentare</title>
  
<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

</head>
<body>

<h2>Aggiungi un parlamentare</h2>
<form method="POST" action="showParlamentare.jsp">
<table>
 <tr>
   <td>Nome:</td>
   <td><input type="text" name="nome"><br></td>
 </tr>
 <tr>
     <td>Partito:</td>
   <td><input type="text" name="partito"><br></td>
   </tr>
  
     <% String a;
      do { %>
   
   <tr>
     <td>Circoscrizione:</td>
   <td><input type="text" name="circoscrizione"><br></td>
   </tr>
   <tr>
     <td> 
     <input type="submit" value="invio">
     <br></td>
       <td> 
        <input type="submit" value="fine" name="end1"><br>
         </td>
       </tr>  
       <% a = request.getParameter("end1");
       } while(
    		   (a != null) && (a.equals("fine"))
    		   );
       %>

   <tr>
   <td>Data di nascita:</td>
   <td><input type="text" name="data_nascita"><br></td>
 </tr>
 <tr>
     <td>Luogo:</td>
   <td><input type="text" name="luogo"><br></td>
   </tr>
   <tr>
     <td>Titolo di studi:</td>
   <td><input type="text" name="titolo_studi"><br></td>
   </tr>
   </table>
   
   <table>
   <tr>
       <td>Mandati:</td>    
      <% String x;
      do { %>   
        <tr>
       <td>Mandato:</td> 
        <td><input type="text" name="mandato"><br></td>
       </tr>
       <tr>
      <td>
          <input type="submit" value="invio"><br>
      </td>
       <td>
          <input type="submit" value="fine" name="end"><br>
      </td>
        </tr> 
       <% x = request.getParameter("end");
       } while((x != null) && (x.equals("fine"))); %>
  </table>
  
  <table>
 <tr>
     <td>Commissioni:</td>
     <% String y;
      do { %>  
        <tr>
       <td>Commissione:</td> 
       <td><input type="text" name="commissione"><br></td>
       <td>
          <input type="submit" value="fine" name="end2"><br>
      </td>
       </tr>  
        <% y = request.getParameter("end2");
       } while((y != null) && (y.equals("fine")));
       %>
       </table>
    
   <table>
   <tr>
  <td> <input type="submit" value="salva parlamentare" name="end inserimento parlamentare"><br></td>
   </tr>
   </table>
   
</form>

</body>
</html>

