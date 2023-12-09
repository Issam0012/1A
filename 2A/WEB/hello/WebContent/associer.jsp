<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%@ page import="java.util.*, hello.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action= "Application" method="post">
 <p> Choisir la personne : <br>
  <% Collection<Personne> liste = (Collection<Personne>) request.getAttribute("listePersonnes");
  for (Personne p : liste) { %>
	<input type="checkbox" id="<%=p.getId()%>" name="personne" value="<%=p.getId()%>">
	<label for="<%=p.getId()%>"><%=p.getNom() + " " + p.getPrenom()%></label><br>
  <% } %>
 </p>
 
  <p> Choisir l'adresse : <br>
  <% Collection<Adresse> liste_2 = (Collection<Adresse>) request.getAttribute("listeAdresses");
	for (Adresse a : liste_2) { %>
	<input type="checkbox" id="<%=a.getId()%>" name="adresse" value="<%=a.getId()%>">
	<label for="<%=a.getId()%>"><%=a.getRue() + " " + a.getVille()%></label><br>
  <% } %>
 </p>
 
 <input type="submit" name="op" value="choix">
</form>
</body>
</html>