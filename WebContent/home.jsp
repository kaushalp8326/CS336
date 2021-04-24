<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="Database.jsp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.cs336.pkg.Wishlist"%>
<%@ page import="com.cs336.pkg.GetAlert"%>
<%@ page import="com.cs336.pkg.AuctionListings"%>
<%@ page import="com.cs336.pkg.ListingDetails"%>
<!DOCTYPE html>
<html>
	<%@ include file = "header.jsp" %>
	<head>
		<title>Home</title>
		<meta http-equiv="refresh" content="30">
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
			<form action="questions.jsp">
				<button type="submit">View Questions</button>
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
						String searchBidString = "select bidder, bidAmount from bid where bidAmount = (select max(bidAmount) from bid where PID = ? and bidAmount >= ?) and PID = ?";
						PreparedStatement searchBid = con.prepareStatement(searchBidString);
						searchBid.setString(1, id);
						searchBid.setString(2, reserve);
						searchBid.setString(3, id);
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
								out.println("<tr><td>You have won the bid for " + rs.getString("itemName") + " (<a href='viewItemHistory.jsp?&param=" + id + "'>item #" + id + "</a>) for $" + bidWinner.getString("bidAmount") + ".</td></tr>");
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
				<%
				String username = (String) session.getAttribute("user");
				String def = "select * from setAlert where username = '" + username + "'";
				String op = "select * from auctionView";
				GetAlert alert = new GetAlert();
				List<Wishlist> wishlist = alert.getWishlist(def);				
				AuctionListings auctions = new AuctionListings();
				List<ListingDetails> currentList = auctions.getListings(op);
				%>
				<h2>Wishlist</h2>
				<%if (wishlist.size() == 0){%>
					<h3>You do not have any items in your wishlist</h3>
				<%}else{%>
			<table id="wishlist">
				<thead id="itemList">
					<tr>
						<th>Item Name</th>
					</tr>
				</thead>
				<%
				int written = 0;
				for (Wishlist item : wishlist) {
					for (ListingDetails list : currentList) {
						if (list.getName().contains(item.getProductName()) || item.getProductName().contains(list.getType())) {
							out.println("<tr>");
							if(written == 0){
								out.println("<td>" + item.getProductName() + "</td>");
								written = 1;
							}else{
								out.println("<td></td>");
							}
							//out.println("<td>" + item.getProductName() + "</td>");
							out.println("<td>[Item Available] <a href='viewItemHistory.jsp?&param=" + list.getID() + "'>" + list.getName() + " (Item #" + list.getID() + ") for $" + list.getPrice() + ".</a></td>");
							out.println("</tr>");
						}
					}
				}
				%>
			</table>
		</body>
	<% }
	} %>
</html>