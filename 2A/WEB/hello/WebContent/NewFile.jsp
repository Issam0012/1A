<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calculatrice</title>
</head>
<body>
<html> <head><title>Directory</title></head><body>
 <h1>Enter numbers</h1>
 <form action= "HW" method="get">
 Nombre 1<input type="text" name="nb1"><br/>
 Nombre 2<input type="text" name="nb2"><br/>
<input type="submit" name="op" value="add">
 </form>
 
 <%if (request.getAttribute("n")!=null){ %>
 <p> Le résultat est : <%= request.getAttribute("n") %>
 </p>
 <% }%>
 
</body></html>
</body>
</html>