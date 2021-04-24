<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<%@ include file = "header.jsp" %>
	<% if ((session.getAttribute("user") == null)) { %>
		<body>
			<h1>Home</h1>
			You are not logged in. <br>
			Please <a href="login.jsp">log in</a>.
		</body>
	<% } else if (!session.getAttribute("type").equals("rep")) { %>
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
		<form action="logout.jsp"> 
			<input type="submit" value="logout"/>
		</form>
		<br><br>
		
		<h3>View Questions:</h3>
		<form action="questions.jsp"> 
			<button type="submit">Questions</button>
		</form>
		<br><br>
		
		<h3>Edit a user account:</h3>
		<form action="editAccountInformation.jsp"> 
			<label for="curUsername">Current Username:</label>
			<input type="text" name="curUsername" id="curUsername" required/> <br><br>
			<label for="newUsername">New Username:</label>
			<input type="text" name="newUsername" id="newUsername" required/> <br><br>
			<label for="newPassword">New Password:</label>
			<input type="password" name="newPassword" id="newPassword" required/> <br><br>
			<button type="submit">Edit Account Information</button>
		</form>
		<br><br>
		
		<h3>Delete a user account:</h3>
		<form action="deleteAccount.jsp"> 
			<label for="Username">Username:</label>
			<input type="text" name="Username" id="Username" required/> <br><br>
			<button type="submit">Delete Account:</button>
		</form>
		<br><br>
		
		<h3>Remove a bid:</h3>
		<form action="removeBid.jsp"> 
			<label for="bidder">Bidder:</label>		
			<input type="text" name="bidder" id="bidder" required/> <br><br>
			<label for="PID">PID:</label>
			<input type="text" name="PID" id="PID" required/> <br><br>
			<label for="bidDate">Bid Date:</label>
			<input type="text" name="bidDate" id="bidDate" required/> <br><br>
			<button type="submit">Remove a Bid</button>
		</form>
		<br><br>
		
		<h3>Remove an Auction</h3>
		<form action="removeAuction.jsp">
			<label for="productID">ProductID:</label>
			<input type="text" name="productID" id="productID" required/> <br><br>
			<button type="submit">Remove an Auction</button>
		</form>
	</body>
	
	<% } %>
</html>