<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<%@ include file = "header.jsp" %>
	<head>
		<meta charset="ISO-8859-1">
		<title>Add Item to Wishlist</title>
	</head>
	<body>
		<h1>Add Item to Wishlist</h1>
		<form action="setAlert.jsp" method="POST">
			<label for="itemName">Item Name:</label>
			<input type="text" name="itemName" id="itemName" required/> <br><br>
			<input type="submit" value="Add to your Wishlist"/>
			Changed your mind? Go back to <a href='viewListing.jsp'>browsing</a>.
		</form>
	</body>
</html>