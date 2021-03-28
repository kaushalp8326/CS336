<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<%@ include file = "header.jsp" %>
	<head>
		<meta charset="ISO-8859-1">
		<h1>Login</h1>
	</head>
	<body>
		<form action="checkLoginDetails.jsp" method="POST">
			<label for="username">Username:</label>
			<input type="text" name="username" id="username" required/> <br><br>
			<label for="password">Password:</label>
			<input type="password" name="password" id="password" required/> <br><br>
			<input type="submit" value="Log in"/>
			Don't have an account? <a href='register.jsp'>Register</a> here!
		</form>
	</body>
</html>