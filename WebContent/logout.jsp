<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
session.invalidate();
//session.getAttribute("user");   //this will throw an error
response.sendRedirect("login.jsp");
 
%>