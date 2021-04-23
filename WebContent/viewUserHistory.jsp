<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.cs336.pkg.UserHistory"%>
<%@ page import="com.cs336.pkg.UserDetails"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<%@ include file="header.jsp"%>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/viewListing.css">
<title>User History</title>
</head>
<%
String username = request.getParameter("param");
String bidDef = "select * from userBidHistory where username = '" + username + "'";
String sellDef = "select * from userSellHistory where username = '" + username + "'";
UserHistory history = new UserHistory();
List<UserDetails> bidList = history.BidHistory(bidDef);
List<UserDetails> sellList = history.SellHistory(sellDef);
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
	<h3>
		Welcome
		<%=userid%>, here are auction's that
		<%=username%>
		has participated in! <br>Back to <a href="viewListing.jsp">listings</a>.
	</h3>
	<%
	if (bidList.size() == 0) {
	%>
	<h2>This user has not placed any bids yet.</h2>
	<%
	} else {
	%>
	<table>
		<tr>
			<td><h2>
					Auction's
					<%=username%>
					has placed bids on
				</h2></td>
		</tr>
		<%
		for (UserDetails bid : bidList) {
		%>
		<tr>
			<td><a href="viewItemHistory.jsp?&param=<%=bid.getPID()%>"><%=bid.getPID()%></a></td>
		</tr>
		<%
		}
		}
		%>
	</table>
	<%
	if (sellList.size() == 0) {
	%>
	<h2>This user has not listed any items for sale yet.</h2>
	<%
	} else {
	%>
	<table>
		<tr>
			<td><h2>
					Auction's
					<%=username%>
					has listed
				</h2></td>
		</tr>
		<%
		for (UserDetails sell : sellList) {
		%>
		<tr>
			<td><a href="viewItemHistory.jsp?&param=<%=sell.getPID()%>"><%=sell.getPID()%></a></td>
		</tr>
		<%
		}
		}
		}
		%>
	</table>
</body>
<body>

</body>
</html>