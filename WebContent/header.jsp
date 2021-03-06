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
					<h1 id="headerH1">Auctions Project</h1>
				</li>
				<% if(session.getAttribute("user")!=null){ %>
					<li id="headerLi1">
						<% if(session.getAttribute("type").equals("user")){ %>
							<a id="headerA1" href="home.jsp">Home</a>
						<% } else if (session.getAttribute("type").equals("admin")) { %>
							<a id="headerA1" href="admin.jsp">Home</a>
						<% } else { %>
							<a id="headerA1" href="cusRep.jsp">Home</a>
						<% } %>
					</li>
					<li id="headerLi2">
						<a id="headerA2" href="sell.jsp">Sell</a>
					</li>
					<li id="headerLi3">
						<a id="headerA3" href="viewListing.jsp">View Listings</a>
					</li>
					<li id="headerLi4">
						<a id="headerA4" href="questions.jsp">View Questions</a>
					</li>
					<li id="headerLiLogout">
						<a id="headerALogout" href="logout.jsp">Log Out</a>
					</li>
				<% } %>
			</ul>
		</nav>
	</body>
</html>