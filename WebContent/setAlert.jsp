<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="Database.jsp"%>
<%
String username = (String) session.getAttribute("user");
String itemName = request.getParameter("itemName");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
Statement st = con.createStatement();
Statement ru = con.createStatement();
ResultSet rs;
rs = st.executeQuery("select * from setAlert where username = '" + username + "' and productName = '" + itemName + "'");
if (rs.next()) {
	out.println(itemName
	+ " is already added to your wishlist. You cannot have identical wishlist items, please <a href='viewListing.jsp'>try again</a>.");

} else {
	ru.executeUpdate("insert into setAlert(username, productName) values " + "('" + username + "', '" + itemName + "')");
	out.println("Added " + itemName + " to your wishlist! Back to <a href='viewListing.jsp'>browing</a>.");

}
%>