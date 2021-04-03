<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="css/header.css">
	</head>
	<body>
		<nav id="headerNav">
			<ul id="headerUl">
				<li id="headerLiH1">
					<h1 id="headerH1">Site Name</h1>
				</li>
				<% if(session.getAttribute("user")!=null){ %>
					<li id="headerLi1">
						<a id="headerA1" href="home.jsp">Home</a>
					</li>
					<li id="headerLi2">
						<a id="headerA2" href="sell.jsp">Sell</a>
					</li>
					<li id="headerLiLogout">
						<a id="headerALogout" href="logout.jsp">Log Out</a>
					</li>
				<% } %>
			</ul>
		</nav>
	</body>
</html>