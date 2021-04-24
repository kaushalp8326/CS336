<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%
  
  // JAVA SCRIPTLET
  
  
    String upperlimit = request.getParameter("upperLimit");   
    String increment = request.getParameter("increment");
    // WE NEED INFO ABOUT THE ITEM ID
     

   session.setAttribute("user", userid); // you'll want to get the userid from the session

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
    Statement st = con.createStatement();
    ResultSet rs;


	// We want to insert a bid for the current session user, and the set item and upper limit and increment
    rs = st.executeQuery("insert * from users where username='" + userid + "' and password='" + pwd + "'");

	// do some verification
    if (rs.next()) {
        
    } else {
        out.println("Invalid password <a href='login.jsp'>try again</a>");
    }
%>