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
String def = "select * from auctionView";
String query;
String sort;
String search = request.getParameter("search");
if (search == "" || search  == null){
	search = "";
}else{
	search = " where itemName like '%" + search + "%'";
}
sort = request.getParameter("type");
if (sort == null){
	sort = request.getParameter("price");
}
if (sort == null){
	sort = request.getParameter("name");
}
if (sort == null){
	query = def + search;
}else{
	query = def + " " + sort;
}
System.out.println(query);
AuctionListings auctions = new AuctionListings();
List<ListingDetails> currentList = auctions.getListings(query);
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
	<form action="viewListing.jsp">
		<h2>Look up an item name:</h2>
		<input type="text" name="search"> <input type="submit" value="Search" />
	</form>
	<form action="viewListing.jsp">
		<h2>Sort by:</h2>
		<input type="hidden" name="type" value="order by itemType">
		<button type="submit" value="type">Type</button>
	</form>
	<form action="viewListing.jsp">
		<input type="hidden" name="price" value="order by bidAmount">
		<button type="submit" value="price">Price</button>
	</form>
	<form action="viewListing.jsp">
		<input type="hidden" name="name" value="order by itemName">
		<button type="submit" value="name">Name</button>
	</form>
	<form action="viewListing.jsp">
		<input type="hidden" name="reset" value="">
		<button type="submit" value="reset">Reset</button>
	</form>
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
			<td><a href="viewItemHistory.jsp?&param=<%=list.getID()%>"><%=list.getID()%></a></td>
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