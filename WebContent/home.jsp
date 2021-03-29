<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<%@ include file = "header.jsp" %>
	<head>
		<title>Home</title>
	</head>
	<% if ((session.getAttribute("user") == null)) { %>
		<body>
			<h1>Home</h1>
			You are not logged in. <br>
			Please <a href="login.jsp">log in</a>.
		</body>
	<% } else { %>
		<body>
			<h1>Home</h1>
			Welcome <%=session.getAttribute("user")%>! <br><br> <% //this will display the username that is stored in the session. %>
			<form action="sell.jsp">
				<button type="submit">Sell an item</button>
			</form>
			<br>
			<form action="logout.jsp">
				<button type="submit">Log Out</button>
			</form>
		</body>
	<% } %>
</html>