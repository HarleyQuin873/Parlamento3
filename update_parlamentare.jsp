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
<title>Aggiorna un parlamentare</title>
<!--  
<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

-->
</head>
<body>

<h2>Aggiorna un parlamentare:</h2>
<form method="POST" action="/Parlamento/updateParlamentare">

<h3>Inserisci il nome del parlamentare da modificare:</h3>
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

<h3>Registra i nuovi dati:</h3>
<table>
  <tr>
   <td>Nome:</td>
   <td><input type="text" name="nome"><br></td>
 </tr>
 <tr>
     <td>Partito:</td>
   <td><input type="text" name="partito"><br></td>
   </tr>
   
   <% String b;
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
        <input type="submit" value="fine" name="end2"><br>
         </td>
       </tr>  
       <% b = request.getParameter("end2");
       } while(
    		   (b != null) && (b.equals("fine"))
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
   
   
   <tr>
       <td>Mandati:</td>    
      <% String xx;
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
          <input type="submit" value="fine" name="end4"><br>
      </td>
        </tr> 
       <% xx = request.getParameter("end4");
       } while((xx != null) && (xx.equals("fine"))); %>
 
 <tr>
     <td>Commissioni:</td>
     <% String yy;
      do { %>  
        <tr>
       <td>Commissione:</td> 
       <td><input type="text" name="commissione"><br></td>
       <td>
          <input type="submit" value="fine" name="end5"><br>
      </td>
  </tr>  
  
        <% yy = request.getParameter("end5");
       } while((yy != null) && (yy.equals("fine")));
       %>
     
   </table>
   <input type="submit" value="invio aggiornamento">
</form>

</body>
</html>

