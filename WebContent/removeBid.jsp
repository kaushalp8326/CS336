<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%
	String bidder = request.getParameter("bidder");
	String PID = request.getParameter("PID");
	String bidDate = request.getParameter("bidDate");
	Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
	Statement st = con.createStatement();
	Statement ru = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from bid where bidder ='" + bidder 
			+ "' and PID = " + PID + " and bidDate = '" + bidDate + "'");
	if (rs.next()) {
		ru.execute("delete from bid where bidder ='" + bidder 
			+ "' and PID = " + PID + " and bidDate = '" + bidDate + "'");
		out.println("Bid successfully deleted!");
		out.println("<a href='cusRep.jsp'>Return to customer representative page.</a>");
	} else {
		out.println("Bid does not exist");
		out.println("Please <a href='cusRep.jsp'>try again.</a>");
	}
%>