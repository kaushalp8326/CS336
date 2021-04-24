<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ include file="Database.jsp" %>
<!DOCTYPE html>
<%@ include file = "header.jsp" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
%>
<html>
<%	if (session.getAttribute("type") == null) { %>
		<body>
			<h1>Home</h1>
			You are not logged in. <br>
			Please <a href="login.jsp">log in</a>.
		</body>
	<% } else if (!session.getAttribute("type").equals("admin")) { %>
		<body>
			<h1>Home</h1>
			You are not logged in. <br>
			Please <a href="login.jsp">log in</a>.
		</body>
	<% } else { %>
	<head>
		<meta charset="ISO-8859-1">
		<title>Admin</title>
	</head>
	<body>
		<h1>Welcome </h1>
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
		<br>
		<form action="logout.jsp"> 
			<input type="submit" value="logout"/>
		</form>
		
		<h3>Sales Reports:</h3>
		<h4>Total Earnings:</h4>
		
		<%
			double totEarnings = 0;
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from clothingAuctions where winner != null or winner != 'reserve'");    
			while (rs.next()) {
				String winner = rs.getString("winner");
				String PID = rs.getString("productID");
				Statement ru = con.createStatement();
				ResultSet maxBid = ru.executeQuery("select max(bidAmount) from bid where bidder = '" + winner + "' and PID = " + PID); 
				if(maxBid.next()) {
					Double earning = maxBid.getDouble("max(bidAmount)");
					totEarnings = totEarnings + earning;
				} else {
					continue;
				}
			}
			out.println("Total Earnings: $" + totEarnings);
		%>
		<br><br>
			
		<table>
			<thead>
				<tr><th>Earning per Item:</th></tr>
			</thead>
			
			<%
				Statement st1 = con.createStatement();
				ResultSet rs1 = st1.executeQuery("select * from clothingAuctions where winner != null or winner != 'reserve'");
				while (rs1.next()) {
					String winner = rs1.getString("winner");
					String PID = rs1.getString("productID");
					Statement ru = con.createStatement();
					ResultSet maxBid = ru.executeQuery("select max(bidAmount) from bid where bidder = '" + winner + "' and PID = " + PID); 
					if(maxBid.next()) {
						Double earning = maxBid.getDouble("max(bidAmount)");
						String itemName = rs1.getString("itemName");
						out.println("<tr><td>Earnings for " + itemName + ": $" + earning + "</td></tr>");
					} else {
						continue;
					}
				}
			%>
		</table>
		<br><br>
		
		<table>
			<thead>
				<tr><th>Earnings per Item Type:</th></tr>
			</thead>
			
			<%
				double shoeEarnings = 0;
				double shirtEarnings = 0;
				double pantsEarnings = 0;
				Statement st2 = con.createStatement();
				ResultSet rs2 = st2.executeQuery("select * from clothingAuctions where winner != null or winner != 'reserve'");
				while (rs2.next()) {
					String winner = rs2.getString("winner");
					String PID = rs2.getString("productID");
					Statement ru = con.createStatement();
					ResultSet maxBid = ru.executeQuery("select max(bidAmount) from bid where bidder = '" + winner + "' and PID = " + PID); 
					if(maxBid.next()) {
						Double earning = maxBid.getDouble("max(bidAmount)");
						String type = rs2.getString("itemType");
						if (type.equals("shoes")) {
							shoeEarnings = shoeEarnings + earning;
						} else if (type.equals("pants")) {
							pantsEarnings = pantsEarnings + earning;
						} else if (type.equals("shirts")) {
							shirtEarnings = shirtEarnings + earning;
						}
					} else {
						continue;
					}
				}
				out.println("<tr><td>Earnings for shoes: $" + shoeEarnings + "</td></tr>");
				out.println("<tr><td>Earnings for shirts: $" + shirtEarnings + "</td></tr>");
				out.println("<tr><td>Earnings for pants: $" + pantsEarnings + "</td></tr>");
			%>
		</table>
		<br><br>	
		
		<table>
			<thead>
				<tr><th>Earnings per user:</th></tr>
			</thead>
			
			<%
				Statement st3 = con.createStatement();
				ResultSet rs3 = st3.executeQuery("select u.username, max(b.bidAmount) earnings from users u, sell s, bid b, (select * from clothingAuctions where winner != null or winner != 'reserve') a where u.type = 'user' and u.username = s.seller and s.PID = a.productID and a.productID = b.PID group by a.productID");     
				while (rs3.next()) {
					String username = rs3.getString("username");
					double earnings = rs3.getDouble("earnings");
					out.println("<tr><td>Earnings for " + username + ": $" + earnings + "</td></tr>");
				}
			%>
		</table>
		<br><br>
		
		<table> 
			<thead>
				<tr><th>Best Selling Items:</th></tr>
			</thead>
		<%
			Statement st4 = con.createStatement();
			ResultSet rs4 = st4.executeQuery("select count(itemName) numItems, itemName from (select * from clothingAuctions where winner is not null or winner != 'reserve') t group by itemName order by numItems desc limit 3");
			int i = 1;
			while (rs4.next()) {
				out.println("<tr><td>#" + i + " best selling item: " + rs4.getString("itemName") + "</td></tr>");
				i++;
			}
		%>
		</table>
		<br><br>
		
		<table> 
			<thead>
				<tr><th>Best Buyer:</th></tr>
			</thead>
		<%
			Statement st5 = con.createStatement();
			ResultSet rs5 = st5.executeQuery("select bidder, count(*) from bid group by bidder order by count(*) desc limit 3");
			int j = 1;
			while (rs5.next()) {
				out.println("<tr><td>#" + j + " best buyer: " + rs5.getString("bidder") + "</td></tr>");
				j++;
			}
		%>
		</table>
		<br><br>
		 
		 
		 <% } %>
		
	</body>
</html> 