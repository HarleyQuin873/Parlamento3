<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Page 500</title>
<!-- google font -->
<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:400,700"  rel="stylesheet">
<!--  Custom stylesheet -->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
<div id="notfound">
   <div class="notfound-500">
       <div class="notfound-500">
           <h1>${statusCode}</h1>
       </div>
       <p>${exception}</p>
       <a href="${pageContext.request.contextPath}/">Go Home</a>
   </div>
</div>
</body>
</html>