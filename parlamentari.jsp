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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!--  <meta charset="ISO-8859-1"> -->

<title>Parlamentari</title>

<!--  <script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
-->
</head>
<body>

<h1>Parlamentari</h1>
     <h2><a href="aggiungi_parlamentare.jsp">AGGIUNGI UN PARLAMENTARE</a></h2>
    <!--   <h2><a href="leggi_parlamentare.jsp">LEGGI PARLAMENTARE</a></h2> -->
     <h2><a href="cancella_parlamentare.jsp">CANCELLA PARLAMENTARE</a></h2>
     <h2><a href="update_parlamentare.jsp">AGGIORNA PARLAMENTARE</a></h2>
     <h2><a href="cerca_parlamentare_dal_nome.jsp">CERCA PARLAMENTARE DAL NOME</a></h2>
     <h2><a href="cerca_parlamentare_dal_partito.jsp">CERCA PARLAMENTARE DAL PARTITO</a></h2>
     <h2><a href="cerca_parlamentare_dalla_circoscrizione.jsp">CERCA PARLAMENTARE DALLA CIRCOSCRIZIONE</a></h2>
     <h2><a href="lista_parlamentari">LISTA PARLAMENTARI</a> </h2>
     <h2><a href="lista_periodi_cariche">LISTA PERIODI CARICHE</a> </h2>

</body>
</html>