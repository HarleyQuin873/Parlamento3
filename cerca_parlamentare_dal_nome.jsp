<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cerca parlamentare dal nome</title>
</head>
<body>
<h2>Leggi un parlamentare:</h2>
<form action="getParlamentare5">
<table>
<tr>
   <td>Nome:</td>
   <td><input type="text" name="nome"><br></td>
 </tr>
   <tr>
   <td><input type="submit" value="invio"><br></td>
   </tr>
   </table>
</form>

</body>
</html>

<!-- <h2>Ricerca parlamentare in base al nome:</h2>
<form action="getParlamentare2">
<table>
<tr>
 <td>Nome:</td>
   <td><input type="text" name="nome"><br></td>
   </tr>
   <tr>
  <td> <input type="submit" value="invio"><br></td>
   </tr>
   </table>
</form> -->