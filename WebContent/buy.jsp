<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%@ include file="header.jsp"%>
<%@ include file="Database.jsp" %>

<head>
<meta charset="ISO-8859-1">
<title>Auction</title>
</head>
<body>

  <form action="#">    
    
    <label for="upperLimit">Set upper limit</label>
    <input type="text" id="upperLimit" name="upperLimit"><br><br>
      
    <label for="increment">Set bid increment</label>
    <input type="text" id="increment" name="increment"><br><br>
      
    <input type="submit" value="bid">
  </form>
 





</body>
</html>