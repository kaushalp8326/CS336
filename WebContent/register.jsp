<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Register Form</title>
	</head>
	<body>
		<form action="createAccount.jsp" method="POST">
			New Username: <input type = "text" name = "newUsername" required/> <br/>
			New Password: <input type = "password" name = "newPassword" required/> <br/>
			Confirm Password: <input type = "password" name = "confirmPassword" required/> <br/>
			<input type="submit" value="Register"/>
			Already have an account? <a href='login.jsp'>Log in</a> here.
		</form>
	</body>
</html>