<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.AuctionListings"%>
<%@ page import="com.cs336.pkg.ListingDetails"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<%@ include file="header.jsp"%>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/viewListing.css">
<title>Current Listings</title>
</head>
<%
AuctionListings auctions = new AuctionListings();
List<ListingDetails> currentList = auctions.getListings();
String userid = (String) session.getAttribute("user");
if ((userid == null)) {
%>
<body>
	<h1>Home</h1>
	You are not logged in.
	<br> Please
	<a href="login.jsp">log in</a>.
</body>
<%
} else {
%>
<body>
	<h2>
		Welcome
		<%=userid%>, here are today's listings!
	</h2>
	<table>
		<tr>
			<td>ProductID</td>
			<td>Type</td>
			<td>Name</td>
			<td>Price</td>
			<td>Start Date</td>
			<td>End Date</td>
		</tr>
		<%
		for (ListingDetails list : currentList) {
		%>
		<tr>
			<td><%=list.getID()%></td>
			<td><%=list.getType()%></td>
			<td><%=list.getName()%></td>
			<td><%=list.getPrice()%></td>
			<td><%=list.getStartDate()%></td>
			<td><%=list.getEndDate()%></td>
		</tr>
		<%
		}
		}
		%>
	</table>
</body>
<body>

</body>
</html>