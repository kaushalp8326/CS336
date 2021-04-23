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
    	
    	if (session.getAttribute("type") == null) {
    		out.println("Please <a href='register.jsp'>try again.</a>");
    	} else if (session.getAttribute("type").equals("admin")) {
    		out.println("Please <a href='admin.jsp'>try again.</a>");
    	}
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
	        
	        if (session.getAttribute("type") == null) {
	    		out.println("Please <a href='register.jsp'>try again.</a>");
	    	} else if (session.getAttribute("type").equals("admin")) {
	    		out.println("Please <a href='admin.jsp'>try again.</a>");
	    	}
	        
	    } else if ((session.getAttribute("type") == null)) {
	    	ru.executeUpdate("insert into users(username, password, type) values " + "('" 
		    	+ userid + "', '" + pwd + "', 'user'" + ")");
		    out.println("Registration success! Please <a href='login.jsp'>log in.</a>");
		    
	    } else if ((session.getAttribute("type").equals("admin"))) {
	    	ru.executeUpdate("insert into users(username, password, type) values " + "('" 
		    	+ userid + "', '" + pwd + "', 'rep'" + ")");
		    out.println("Registration success! <a href='admin.jsp'>Return to Admin Page.</a>");
	    }
    }
%>