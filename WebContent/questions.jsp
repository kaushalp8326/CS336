<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ include file="Database.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Questions</title>
</head>
<body>
<%
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
	
	String cpQID = request.getParameter("cpQID");
	if (cpQID != null ) {
		String answer = request.getParameter("answer");
		Statement tmp = con.createStatement();
		Statement tmp1 = con.createStatement();
		ResultSet tmpRS = tmp.executeQuery("select * from questionForum where questionID = " + cpQID);
		if (tmpRS.next()) {
			tmp1.executeUpdate("update questionForum set answer = '" + answer + "' where questionID = " + cpQID);
		} else {
			out.println("<br><br>No question exists with that ID.<br><br>");
		}
	}
	String euQID = request.getParameter("euQID");
	if (euQID != null) {
		String question = request.getParameter("question");
		Statement tmp = con.createStatement();
		Statement tmp1 = con.createStatement();
		ResultSet tmpRS = tmp.executeQuery("select * from questionForum where questionID = " + euQID);
		if (tmpRS.next()) {
			out.println("<br><br>There is already a question that exists with that ID.<br><br>");
		} else {
			tmp1.executeUpdate("insert into questionForum(questionID, question, answer) values (" + euQID + ", '" + question + "', null)");
		}
	}
	
	String keyWord = request.getParameter("keyWord");
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from questionForum");
	if (keyWord != null) {
		rs = st.executeQuery("select * from questionForum where question like '%" + keyWord + "%'");
	} else {
		rs = st.executeQuery("select * from questionForum");
	}
	
	
%>
<% if ((session.getAttribute("user") == null)) { %>

		<h1>Home</h1>
		You are not logged in. <br>
		Please <a href="login.jsp">log in</a>.
		
	<% } else if (session.getAttribute("type").equals("rep")) { %>
		<%@ include file = "header.jsp" %>
		<h1>Questions</h1>
		
		<form action="cusRep.jsp">
			<button type="submit">Back</button>
		</form>
		<br><br>
			
		<form action="questions.jsp" method="POST">
			<label for="cpQID">QID:</label>
			<input type="text" name="cpQID" id="cpQID" required/> <br><br>
			<label for="answer">Answer:</label>
			<input type="text" name="answer" id="answer" required/> <br><br>
			<button type="submit">Answer Question</button>
		</form>
		<br><br>
		
		<form action="questions.jsp">
			<label for="keyWord">Search:</label>
			<input type="text" name="keyWord" id="keyWord" required/><br><br>
			<button type="submit">Search</button>
		</form>
		<br><br>
		<form action="questions.jsp">
			<button type="submit">Reset</button>
		</form>
		<br><br>
		
		<% 
		while (rs.next()) {
			int id = rs.getInt("questionID");
			String q = rs.getString("question");
			String a = rs.getString("answer");
			out.println("ID: " + id + "<br>Q: " + q + "<br>");
			if (a == null) {
				out.println("<br>");
			} else {
				out.println("A: " + a + "<br><br>");
			}
		}
		%>
		
	<% } else { %>
		<%@ include file = "header.jsp" %>
		<h1>Questions</h1>
		
		<form action="home.jsp">
			<button type="submit">Back</button>
		</form>
		<br><br>
		
		<form action="questions.jsp" method="POST">
			<label for="euQID">QID:</label>
			<input type="text" name="euQID" id="euQID" required/> <br><br>
			<label for="question">Question:</label>
			<input type="text" name="question" id="question" required/> <br><br>
			<button type="submit">Post Question</button>
		</form>
		<br><br>
		
		<form action="questions.jsp">
			<label for="keyWord">Search:</label>
			<input type="text" name="keyWord" id="keyWord" required/><br><br>
			<button type="submit">Search</button>
		</form>
		<br><br>
		
		<% 
		while (rs.next()) {
			int id = rs.getInt("questionID");
			String q = rs.getString("question");
			String a = rs.getString("answer");
			out.println("ID: " + id + "<br>Q: " + q + "<br>");
			if (a == null) {
				out.println("<br>");
			} else {
				out.println("A: " + a + "<br><br>");
			}
		}
		%>
		
	<% } %>
	
</body>
</html>