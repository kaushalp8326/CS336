<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

	<% if ((session.getAttribute("user") == null)) { %>
		<body>
			<h1>Home</h1>
			You are not logged in. <br>
			Please <a href="login.jsp">log in</a>.
		</body>
	<% } else { %>
	<head>
		<meta charset="ISO-8859-1">
		<title>Customer Representative</title>
	</head>
	<body>
		<h1>Welcome Customer Representative!</h1>
		<h2>Please select an action:</h2>
		<form> 
			<button type="submit">View Questions</button>
		</form>
		<br>
		<form> 
			<button type="submit">Edit Account Information</button>
		</form>
		<br>
		<form> 
			<button type="submit">Delete Account Information</button>
		</form>
		<br>
		<form> 
			<button type="submit">Remove a Bid</button>
		</form>
		<br>
		<form> 
			<button type="submit">Remove an Auction</button>
		</form>
		<br><br>
		<form action="logout.jsp"> 
			<input type="submit" value="logout"/>
		</form>
	</body>
	
	<% } %>
</html>