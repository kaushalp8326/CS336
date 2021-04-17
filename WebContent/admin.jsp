<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Admin</title>
	</head>
	<body>
		<h1>Welcome Admin!</h1>
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
		
		<h3>Generate Sales Reports:</h3>
		<form action="generateSalesReports.jsp" method="GET">
			<input type="checkbox" name="totalEarnings"/> Total Earnings
         	<input type="checkbox" name="earningsPerItem"/> Earnings per Item
         	<input type="checkbox" name="earningsPerItemType"/> Earnings per Item Type
         	<input type="checkbox" name="earningsPerEndUser"/> Earnings per End User
         	<input type="checkbox" name="bestSellingItems"/> Best Selling Items
         	<input type="checkbox" name="bestBuyers"/> Best Buyers
         	<input type="submit" value="Generate Sales" />
		</form>
	</body>
</html> 