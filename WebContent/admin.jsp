<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%	if (session.getAttribute("type") == null) { %>
		<body>
			<h1>Home</h1>
			You are not logged in. <br>
			Please <a href="login.jsp">log in</a>.
		</body>
	<% } else if (!session.getAttribute("type").equals("admin")) { %>
		<body>
			<h1>Home</h1>
			You are not logged in. <br>
			Please <a href="login.jsp">log in</a>.
		</body>
	<% } else { %>
	<head>
		<meta charset="ISO-8859-1">
		<title>Admin</title>
	</head>
	<body>
		<h1>Welcome </h1>
		<h2>Create new Customer Rep. Accounts here:</h2>
		<form action="createAccount.jsp" method="POST">
			<label for="newUsername">New Username:</label>
			<input type="text" name="newUsername" id="newUsername" required/> <br><br>
			<label for="newPassword">New Password:</label>
			<input type="password" name="newPassword" id="newPassword" required/> <br><br>
			<label for="confirmPassword">Confirm Password:</label>
			<input type="password" name="confirmPassword" id="confirmPassword" required/> <br><br>
			<input type="submit" value="Register New Customer Representative"/>
		</form>
		<br>
		<form action="logout.jsp"> 
			<input type="submit" value="logout"/>
		</form>
		
		<h3>Sales Reports:</h3>
		<h4>Total Earnings:</h4>
		<%
		
		%>
		<h4>Earning per Item:</h4>
		<%
		
		%>
		<h4>Earnings per Item Type:</h4>
		<%
		
		%>
		<h4>Earnings per User:</h4>
		<%
		
		%>
		<h4>Best Selling Items:</h4>
		<%
		
		%>
		<h4>Best Buyers:</h4>
		<%
		
		%>
		
		<% } %>
		
	</body>
</html> 