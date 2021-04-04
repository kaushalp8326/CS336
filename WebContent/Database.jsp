<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%! String dbURL = "jdbc:mysql://localhost:3306/CS336"; %>
<%! String dbUser = "root"; %>
<%! String dbPass = "12q23w34e45r"; %>
<%
ApplicationDB.getDB(dbURL, dbUser, dbPass);
%>