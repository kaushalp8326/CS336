<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%
	String productID = request.getParameter("productID");
	Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
	Statement st = con.createStatement();
	Statement ru = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from clothingAuctions where productID=" + productID + "");
	if (rs.next()) {
		ru.execute("delete from clothingAuctions where productID=" + productID + "");
		out.println("Auction successfully deleted!");
		out.println("<a href='cusRep.jsp'>Return to customer representative page.</a>");
	} else {
		out.println("Auction does not exist");
		out.println("Please <a href='cusRep.jsp'>try again.</a>");
	}
%>