<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<%@ include file = "header.jsp" %>
	<head>
		<meta charset="ISO-8859-1">
		<title>Register</title>
	</head>
	<body>
		<h1>Register</h1>
		<form action="createAccount.jsp" method="POST">
			<label for="newUsername">New Username:</label>
			<input type="text" name="newUsername" id="newUsername" required/> <br><br>
			<label for="newPassword">New Password:</label>
			<input type="password" name="newPassword" id="newPassword" required/> <br><br>
			<label for="confirmPassword">Confirm Password:</label>
			<input type="password" name="confirmPassword" id="confirmPassword" required/> <br><br>
			<input type="submit" value="Register"/>
			Already have an account? <a href='login.jsp'>Log in</a> here.
		</form>
	</body>
</html>