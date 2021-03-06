<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.AuctionHistory"%>
<%@ page import="com.cs336.pkg.HistoryDetails"%>
<%@ page import="com.cs336.pkg.AuctionListings"%>
<%@ page import="com.cs336.pkg.ListingDetails"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ include file="Database.jsp" %>

<!DOCTYPE html>
<html>
<%@ include file="header.jsp"%>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/viewListing.css">
<title>Auction/Bid History</title>
</head>
<%
String pid = request.getParameter("param");
String def = "select * from bidHistory where PID = '" + pid + "'";
String op = "select * from allAuctions where ProductID = '" + pid + "'";
System.out.println(def);
AuctionHistory records = new AuctionHistory();
List<HistoryDetails> currentBids = records.getHistory(def);
AuctionListings date = new AuctionListings();
List<ListingDetails> bidDates = date.getListings(op);
String itemType = bidDates.get(0).getType();
String query;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
Statement st = con.createStatement();
ResultSet rs;

String att1 = "", att2 = "", att3 = "";
System.out.println(pid + itemType);

if (itemType.equals("shoes")) {
	query = "select a.itemName, s.PID, s.brand, s.shoeSize, s.color from allAuctions a join shoes s on a.ProductID = s.PID where s.PID = '" + pid + "'";
	rs = st.executeQuery(query);
	if (rs.next()){
		att1 = "Brand: " + rs.getString("brand");
		att2 = "Size: " + rs.getString("shoeSize");
		att3 = "Color: " + rs.getString("color");
		System.out.println(att1 + " " + att2 + " " + att3);
	}
} else if (itemType.equals("pants")) {
	query = "select a.itemName, p.PID, p.brand, p.pantsSize, p.fabric from allAuctions a join pants p on a.ProductID = p.PID where p.PID = '" + pid + "'";
	rs = st.executeQuery(query);
	if (rs.next()){
		att1 = "Brand: " + rs.getString("brand");
		att2 = "Size: " + rs.getString("pantsSize");
		att3 = "Fabric: " + rs.getString("fabric");
		System.out.println(att1 + " " + att2 + " " + att3);
	}
} else {
	query = "select a.itemName, s.PID, s.style, s.shirtSize, s.fabric from allAuctions a join shirts s on a.ProductID = s.PID where s.PID = '" + pid + "'";
	rs = st.executeQuery(query);
	if (rs.next()){
		att1 = "Style: " + rs.getString("style");
		att2 = "Size: " + rs.getString("shirtSize");
		att3 = "Fabric: " + rs.getString("fabric");
		System.out.println(att1 + " " + att2 + " " + att3);
	}
}
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
		Bid history for
		<%=pid%>! Back to <a href="viewListing.jsp">listings</a>.
	</h2>
	<h3>
		Start Date:
		<%=bidDates.get(0).getStartDate()%>
		- End Date:
		<%=bidDates.get(0).getEndDate()%>
		<br>Item Name:
		<%=bidDates.get(0).getName()%>
		<br>Item Type:
		<%=bidDates.get(0).getType()%>
		<br> Current Price: $<%=bidDates.get(0).getPrice()%>
		<br><%=att1%> - <%=att2%> - <%=att3%></h3>
	<%
	if (currentBids.size() == 0) {
	%>
	<h2>No one have bid for this auction yet!</h2>
	<%
	} else {
	%>
	<h3>
		Auction Winner:
		<%
	if (currentBids.get(0).getWinner() == "reserve") {
	%>
		Auction Expired
		<%
	} else if (currentBids.get(0).getWinner() == null) {
	%>
		Auction is still ongoing
		<%
	} else {
	%>
		<%=currentBids.get(0).getWinner()%>
		<%
		}
		%>
	</h3>
	<table>
		<tr>
			<td>Bidder</td>
			<td>Name</td>
			<td>Type</td>
			<td>Bid Amount</td>
			<td>Bid Date</td>
		</tr>
		<%
		for (HistoryDetails record : currentBids) {
		%>
		<tr>
			<td><a href="viewUserHistory.jsp?&param=<%=record.getBidder()%>"><%=record.getBidder()%></a></td>
			<td><%=record.getItemName()%></td>
			<td><%=record.getItemType()%></td>
			<td>$<%=record.getBidAmount()%></td>
			<td><%=record.getBidDate()%></td>
		</tr>
		<%
		}
		}
		%>
	</table>
	<h2>Similar item you might be interested in! (Past 30 days)</h2>
	<%
	AuctionListings test = new AuctionListings();
	List<ListingDetails> testList = date.getListings("select * from auctionView a WHERE a.ProductID <> '" + pid
			+ "' AND a.itemType = '" + bidDates.get(0).getType()
			+ "' AND EXTRACT(YEAR_MONTH FROM a.startDate) > EXTRACT(YEAR_MONTH FROM a.startDate - INTERVAL 1 MONTH)");
	if (testList.size() == 0) {
	%>
	<h2>Oops, there aren't any similar items placed on auction at this
		moment...</h2>
	<%
	} else {
	%>
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
		for (ListingDetails list : testList) {
		%>
		<tr>
			<td><a href="viewItemHistory.jsp?&param=<%=list.getID()%>"><%=list.getID()%></a></td>
			<td><%=list.getType()%></td>
			<td><%=list.getName()%></td>
			<td>$<%=list.getPrice()%></td>
			<td><%=list.getStartDate()%></td>
			<td><%=list.getEndDate()%></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	}
	}
	%>
</body>
<body>

</body>
</html>