<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, hello.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lister</title>
</head>
<body>
Les gens et leurs adresses : <br>
<% Collection<Personne> listePersonnes = (Collection<Personne>) request.getAttribute("listePersonnes");%>
<%if (!listePersonnes.isEmpty()) {
  for (Personne p : listePersonnes) { %>
  <%=p.getNom()%>   <%=p.getPrenom() %> : <br>
      <% Collection<Adresse> listeAdresses = p.getAdresses(); %>
      <% if (!listeAdresses.isEmpty()) {
      	for (Adresse a : listeAdresses) { %>
    	  <%=a.getRue()%>   <%=a.getVille() %> <br>
      <% }
      } %>
  	<br>
  <%
  }
}
%>
</body>
</html>