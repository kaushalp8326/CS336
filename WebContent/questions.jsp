<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Questions</title>
</head>
<body>
<% if ((session.getAttribute("user") == null)) { %>

		<h1>Home</h1>
		You are not logged in. <br>
		Please <a href="login.jsp">log in</a>.
		
	<% } else if (session.getAttribute("type").equals("rep")) { %>
		<h1>Questions</h1>
		
		<form action="cusRep.jsp">
			<button type="submit">Back</button>
		</form>
		
	<% } else { %>
		<%@ include file = "header.jsp" %>
		<h1>Questions</h1>
		
		<form action="postQuestion.jsp" method="POST">
			
		</form>
		
		<form action="searchQuestions.jsp">
			
		</form>
		
	<% } %>
</body>
</html>