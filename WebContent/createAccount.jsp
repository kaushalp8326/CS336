<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%
    String userid = request.getParameter("newUsername");   
    String pwd = request.getParameter("newPassword");
    String cpwd = request.getParameter("confirmPassword");
    if (!pwd.equals(cpwd))
    {
    	out.println("Passwords do not match!");
        out.println("Please <a href='register.jsp'>try again.</a>");
    }
    else
    {
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
	    Statement st = con.createStatement();
	    Statement ru = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select * from users where username='" + userid + "'");
	    if (rs.next()) {
	        out.println(userid + " is already taken.");
	        out.println("Please <a href='register.jsp'>try again.</a>");
	    } else {
	    	//out.println("insert into users values " + "('" + userid + "', '" + pwd + "')");
	    	ru.executeUpdate("insert into users(username, password, type) values " + "('" + userid + "', '" + pwd + "', 'user'" + ")");
	    	out.println("Registration success! Please <a href='login.jsp'>log in.</a>");
	    }
    }
%>