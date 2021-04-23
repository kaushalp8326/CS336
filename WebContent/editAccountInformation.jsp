<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%	
	String curUsername = request.getParameter("curUsername");
	String newUsername = request.getParameter("newUsername");
	String newPassword = request.getParameter("newPassword");
	Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
    Statement st = con.createStatement();
    Statement ru = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + curUsername + "'");
	if (rs.next()) {
		
		rs = st.executeQuery("select * from users where username='" + newUsername + "'");
		if (rs.next()) {
			out.println(newUsername + " is already taken");
			out.println("Please <a href='cusRep.jsp'>try again.</a>");
		} else {
			ru.execute("update users set username = '" + newUsername 
					+ "', password = '" + newPassword + "' where username = '"+ curUsername + "'");
			out.println("User successfully updated!");
			out.println("<a href='cusRep.jsp'>Return to customer representative page.</a>");
		}
	} else {
		out.println("Username does not exist");
		out.println("Please <a href='cusRep.jsp'>try again.</a>");
	}
%>
