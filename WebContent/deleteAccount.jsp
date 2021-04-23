<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%	
	String currentUsername = request.getParameter("curUsername");
	Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
    Statement st = con.createStatement();
    Statement ru = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + currentUsername + "'");
	if (rs.next()) {
		ru.execute("delete from users where username = '" + currentUsername + "'");
		out.println("User successfully deleted!");
		out.println("<a href='cusRep.jsp'>Return to customer representative page.</a>");
	} else {
		out.println("Username does not exist");
		out.println("Please <a href='cusRep.jsp'>try again.</a>");
	}


%>
