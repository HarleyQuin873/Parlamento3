<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
</head>
<body>


<%@ page isErrorPage= "true"  %>  
  
<h3>Spiacenti, si è verificata un'eccezione!</h3>  
   <form method="GET" action="/error">
L'eccezione è: ${trace} 
<!--  < % =
eccezione
% > --> 

</form>
</body>
</html>