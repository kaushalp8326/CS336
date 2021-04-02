<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
	//PID will be generated later
	String itemType = request.getParameter("itemType");
	String itemName = request.getParameter("itemName");   
	Double initialPrice = Double.parseDouble(request.getParameter("initialPrice"));
	//Double minimumPrice = Double.parseDouble(request.getParameter("minimumPrice"));
	Double minimumPrice;
	System.out.println("mp:"+request.getParameter("minimumPrice"));
	if(request.getParameter("minimumPrice")==null || request.getParameter("minimumPrice").isEmpty()){
		minimumPrice = 0.0;
	}else{
		minimumPrice = Double.parseDouble(request.getParameter("minimumPrice"));
	}
	Double bidIncrement = Double.parseDouble(request.getParameter("bidIncrement"));
	LocalDateTime startDate = LocalDateTime.now();
	LocalDateTime endDate = LocalDateTime.parse(request.getParameter("endDate"));
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
	String username = (String) session.getAttribute("user");
	
	String insertSellString = "insert into sell (seller, PID) values (?, ?)";
	String searchClothingAuctionsString = "select * from clothingAuctions where productID = ?";
	String insertClothingAuctionsString = "insert into clothingAuctions (productID, itemType, itemName, initialPrice, minimumPrice, bidIncrement, startDate, endDate) values (?, ?, ?, ?, ?, ?, ?, ?)";
	
	PreparedStatement insertSell = con.prepareStatement(insertSellString);
	PreparedStatement searchClothingAuctions = con.prepareStatement(searchClothingAuctionsString);
	PreparedStatement insertClothingAuctions = con.prepareStatement(insertClothingAuctionsString);
	
	//generate unique product id from 0 to 9999
	int id;
	ResultSet rs;
	do{
		id = (int) ((Math.random() * (9999 - 0)) + 0);
		searchClothingAuctions.setString(1, String.valueOf(id));
		rs = searchClothingAuctions.executeQuery();
	} while(rs.next());
	
	//add item to auctions table
	/*insert into clothingAuctions (productID, itemType, itemName, initialPrice, minimumPrice,
			bidIncrement, startDate, endDate) values (?, ?, ?, ?, ?, ?, ?, ?)*/
	insertClothingAuctions.setString(1, String.valueOf(id));
	insertClothingAuctions.setString(2, itemType);
	insertClothingAuctions.setString(3, itemName);
	insertClothingAuctions.setString(4, Double.toString(initialPrice));
	insertClothingAuctions.setString(5, Double.toString(minimumPrice));
	insertClothingAuctions.setString(6, Double.toString(bidIncrement));
	insertClothingAuctions.setString(7, startDate.toString());
	insertClothingAuctions.setString(8, endDate.toString());
	insertClothingAuctions.executeUpdate();
	
	//add tuple to sell relationship table
	insertSell.setString(1, username);
	insertSell.setString(2, String.valueOf(id));
	insertSell.executeUpdate();
	
	//add item to correct items table to store additional product info
	if(itemType.equals("shoes")){
		//has fields PID, brand, shoeSize, color
		String brand = request.getParameter("shoeBrand");
		String shoeSize = request.getParameter("shoeSize");
		String color = request.getParameter("shoeColor");
		
		String insertShoesString = "insert into shoes (PID, brand, shoeSize, color) values (?, ?, ?, ?)";
		PreparedStatement insertShoes = con.prepareStatement(insertShoesString);
		insertShoes.setString(1, String.valueOf(id));
		insertShoes.setString(2, brand);
		insertShoes.setString(3, shoeSize);
		insertShoes.setString(4, color);
	}else if(itemType.equals("shirts")){
		//has fields PID, style, shirtSize, fabric
		String style = request.getParameter("shirtStyle");
		String shirtSize = request.getParameter("shirtSize");
		String fabric = request.getParameter("shirtFabric");
		
		String insertShirtsString = "insert into shirts (PID, style, shirtSize, fabric) values (?, ?, ?, ?)";
		PreparedStatement insertShirts = con.prepareStatement(insertShirtsString);
		insertShirts.setString(1, String.valueOf(id));
		insertShirts.setString(2, style);
		insertShirts.setString(3, shirtSize);
		insertShirts.setString(4, fabric);
	}else{
		//itemType is pants
		//has fields PID, brand, pantsSize, fabric
		String brand = request.getParameter("pantBrand");
		String pantsSize = request.getParameter("pantSize");
		String fabric = request.getParameter("pantFabric");
		
		String insertPantsString = "insert into pants (PID, brand, pantsSize, fabric) values (?, ?, ?, ?)";
		PreparedStatement insertPants = con.prepareStatement(insertPantsString);
		insertPants.setString(1, String.valueOf(id));
		insertPants.setString(2, brand);
		insertPants.setString(3, pantsSize);
		insertPants.setString(4, fabric);
	}
	
	//redirect to home page
	response.sendRedirect("home.jsp");
%>