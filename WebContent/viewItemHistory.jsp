<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.AuctionHistory"%>
<%@ page import="com.cs336.pkg.HistoryDetails"%>
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
System.out.println(def);
AuctionHistory records = new AuctionHistory();
List<HistoryDetails> currentBids = records.getHistory(def);
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
		<%=pid%>!
	</h2>
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
			<td><%=record.getPID()%></td>
			<td><%=record.getItemType()%></td>
			<td><%=record.getItemName()%></td>
			<td><%=record.getBidAmount()%></td>
			<td><%=record.getBidDate()%></td>
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