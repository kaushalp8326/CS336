<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.AuctionListings"%>
<%@ page import="com.cs336.pkg.ListingDetails"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="Database.jsp" %>

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
if (search == "" || search == null) {
	search = "";
} else {
	search = " where itemName like '%" + search + "%' OR itemType like '%" + search + "%'";
}
sort = request.getParameter("type");
if (sort == null) {
	sort = request.getParameter("price");
}
if (sort == null) {
	sort = request.getParameter("name");
}
if (sort == null) {
	query = def + search;
} else {
	query = def + " " + sort;
}
System.out.println(query);
AuctionListings auctions = new AuctionListings();
List<ListingDetails> currentList = auctions.getListings(query);
String userid = (String) session.getAttribute("user");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
Statement st = con.createStatement();
ResultSet rs;

String att1 = "", att2 = "", att3 = "";

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
	Interested in an item but it's not listed? <a href='wishlist.jsp'>Add it to your wishlist</a>!
	<table>
		<tr>
			<td>
				<h3>Look up an item name:</h3>
			</td>
			<td>
				<form action="viewListing.jsp">
					<input type="text" name="search"> <input type="submit"
						value="Search" />
				</form>
			</td>
			<td>
				<h3>Sort by:</h3>
			</td>
			<td>
				<form action="viewListing.jsp">
					<input type="hidden" name="type" value="order by itemType">
					<button type="submit" value="type">Type</button>
				</form>
			</td>
			<td>
				<form action="viewListing.jsp">
					<input type="hidden" name="price" value="order by bidAmount">
					<button type="submit" value="price">Price</button>
				</form>
			</td>
			<td>
				<form action="viewListing.jsp">
					<input type="hidden" name="name" value="order by itemName">
					<button type="submit" value="name">Name</button>
				</form>
			</td>
			<td>
				<form action="viewListing.jsp">
					<input type="hidden" name="reset" value="">
					<button type="submit" value="reset">Reset</button>
				</form>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td>ProductID</td>
			<td>Type</td>
			<td>Name</td>
			<td>Price</td>
			<td>Start Date</td>
			<td>End Date</td>
			<td>Brand/Style</td>
			<td>Size</td>
			<td>Color/Fabric</td>
		</tr>
		<%
		for (ListingDetails list : currentList) {
			String itemType = list.getType();
			String pid = list.getID();
			if (itemType.equals("shoes")) {
				query = "select a.itemName, s.PID, s.brand, s.shoeSize, s.color from allAuctions a join shoes s on a.ProductID = s.PID where s.PID = '" + pid + "'";
				rs = st.executeQuery(query);
				if (rs.next()){
					att1 = rs.getString("brand");
					att2 = rs.getString("shoeSize");
					att3 = rs.getString("color");
					System.out.println(att1 + " " + att2 + " " + att3);
				}
			} else if (itemType.equals("pants")) {
				query = "select a.itemName, p.PID, p.brand, p.pantsSize, p.fabric from allAuctions a join pants p on a.ProductID = p.PID where p.PID = '" + pid + "'";
				rs = st.executeQuery(query);
				if (rs.next()){
					att1 = rs.getString("brand");
					att2 = rs.getString("pantsSize");
					att3 = rs.getString("fabric");
					System.out.println(att1 + " " + att2 + " " + att3);
				}
			} else {
				query = "select a.itemName, s.PID, s.style, s.shirtSize, s.fabric from allAuctions a join shirts s on a.ProductID = s.PID where s.PID = '" + pid + "'";
				rs = st.executeQuery(query);
				if (rs.next()){
					att1 = rs.getString("style");
					att2 = rs.getString("shirtSize");
					att3 = rs.getString("fabric");
					System.out.println(att1 + " " + att2 + " " + att3);
				}
			}
		%>
		<tr>
			<td><a href="viewItemHistory.jsp?&param=<%=list.getID()%>"><%=list.getID()%></a></td>
			<td><%=list.getType()%></td>
			<td><%=list.getName()%></td>
			<td>$<%=list.getPrice()%></td>
			<td><%=list.getStartDate()%></td>
			<td><%=list.getEndDate()%></td>
			<td><%=att1%></td>
			<td><%=att2%></td>
			<td><%=att3%></td>
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