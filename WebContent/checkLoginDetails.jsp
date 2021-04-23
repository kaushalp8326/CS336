<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid);// the username will be stored in the session
        session.setAttribute("type", rs.getString("type"));
        String type = rs.getString("type");
        if (type.equals("admin")) {
        	response.sendRedirect("admin.jsp");
        } else if (type.equals("rep")) {
        	response.sendRedirect("cusRep.jsp");
        } else {
        	response.sendRedirect("home.jsp");
        }
    } else {
        out.println("Invalid password <a href='login.jsp'>try again</a>");
    }
%>