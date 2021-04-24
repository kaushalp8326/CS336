<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.AuctionHistory"%>
<%@ page import="com.cs336.pkg.HistoryDetails"%>
<%@ page import="com.cs336.pkg.AuctionListings"%>
<%@ page import="com.cs336.pkg.ListingDetails"%>
<%@ page import="java.util.List"%>

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
		<br> Current Price: $<%=bidDates.get(0).getPrice()%></h3>
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
	List<ListingDetails> testList = date.getListings("select * from auctionView a WHERE YEAR(a.startDate) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(a.startDate) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)");
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
			System.out.println("list: " + list.getType());
			System.out.println("item: " + bidDates.get(0).getType());
			if (!list.getID().equals(pid) && list.getType().equals(bidDates.get(0).getType())) {
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
		}
		%>
	</table>
	<%
	}
	%>
</body>
<body>

</body>
</html>