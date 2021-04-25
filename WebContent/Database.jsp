<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%! String dbURL = "jdbc:mysql://localhost:3306/CS336"; %>
<%! String dbUser = "root"; %>
<%! String dbPass = "JPhilip12&3"; %>
<%
ApplicationDB.getDB(dbURL, dbUser, dbPass);
%>