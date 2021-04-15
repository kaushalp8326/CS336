<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="Database.jsp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
	<%@ include file = "header.jsp" %>
	<head>
		<title>Home</title>
	</head>
	<% if ((session.getAttribute("user") == null)) { %>
		<body>
			<h1>Home</h1>
			You are not logged in. <br>
			Please <a href="login.jsp">log in</a>.
		</body>
	<% } else { %>
		<body>
			<h1>Home</h1>
			Welcome <%=session.getAttribute("user")%>! <br><br> <% //this will display the username that is stored in the session. %>
			<form action="sell.jsp">
				<button type="submit">Sell an item</button>
			</form>
			<br>
			<form action="viewListing.jsp">
				<button type="submit">View Listings</button>
			</form>
			<br>
			<form action="logout.jsp">
				<button type="submit">Log Out</button>
			</form>
			<br>
			<table id="alertsTable">
				<thead>
					<tr>
						<th>Alerts</th>
					</tr>
				</thead>
				<%
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
				String searchClothingAuctionsString = "select * from clothingAuctions order by endDate desc";
				PreparedStatement searchClothingAuctions = con.prepareStatement(searchClothingAuctionsString);
				ResultSet rs = searchClothingAuctions.executeQuery();
				while(rs.next()){
					LocalDateTime eDate = LocalDateTime.parse(rs.getString("endDate"), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));
					if(eDate.isBefore(LocalDateTime.now())){
						//Auction has ended
						String id = rs.getString("productID");
						String reserve = rs.getString("minimumPrice");
						String searchBidString = "select bidder, bidAmount from bid where bidAmount = (select max(bidAmount) from bid where PID = ? and bidAmount >= ?)";
						PreparedStatement searchBid = con.prepareStatement(searchBidString);
						searchBid.setString(1, id);
						searchBid.setString(2, reserve);
						ResultSet bidWinner = searchBid.executeQuery();
						if(bidWinner.next()){
							//there is a winning bid
							//update winner field to the user who won the auction if it's not already
							if(rs.getString("winner")==null){
								String updateWinnerString = "update clothingAuctions set winner = ? where productID = ?";
								PreparedStatement updateWinner = con.prepareStatement(updateWinnerString);
								updateWinner.setString(1, bidWinner.getString("bidder"));
								updateWinner.setString(2, id);
								updateWinner.executeUpdate();
							}
							//check if this user is the one who won the auction
							if(bidWinner.getString("bidder").equals(session.getAttribute("user"))){
								//output alert
								out.println("<tr><td>You have won the bid for " + rs.getString("itemName") + " (item #" + id + ") for $" + bidWinner.getString("bidAmount") + ".</td></tr>");
							}
						}else{
							//there is no winning bid
							//update winner field to "reserve" if it's not already
							if(rs.getString("winner")==null){
								String updateWinnerString = "update clothingAuctions set winner = 'reserve' where productID = ?";
								PreparedStatement updateWinner = con.prepareStatement(updateWinnerString);
								updateWinner.setString(1, id);
								updateWinner.executeUpdate();
							}
						}
					}
				}
				%>
			</table>
		</body>
	<% } %>
</html>