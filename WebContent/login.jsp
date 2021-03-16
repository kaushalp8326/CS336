<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Login Form</title>
	</head>
	<body>
		<form action="checkLoginDetails.jsp" method="POST">
			Username: <input type="text" name="username" required/> <br/>
			Password: <input type="password" name="password" required/> <br/>
			<input type="submit" value="Log in"/>
			Don't have an account? <a href='register.jsp'>Register</a> here!
		</form>
	</body>
</html>