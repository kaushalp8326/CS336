<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="Database.jsp" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
	String itemType = request.getParameter("itemType");

	//PID will be generated later
	/*
	String brand;
	int shoeSize;
	String color;
	String style;
	String shirtSize;
	String fabric;
	int pantsSize;
	
	if(itemType.equals("shoes")){
		//has fields PID, brand, shoeSize, color
		brand = request.getParameter("shoeBrand");
		shoeSize = Integer.parseInt(request.getParameter("shoeSize"));
		color = request.getParameter("shoeColor");
	}else if(itemType.equals("shirts")){
		//has fields PID, style, shirtSize, fabric
		style = request.getParameter("shirtStyle");
		shirtSize = request.getParameter("shirtSize");
		fabric = request.getParameter("shirtFabric");
	}else{
		//itemType is pants
		//has fields PID, brand, pantsSize, fabric
		brand = request.getParameter("pantBrand");
		pantsSize = Integer.parseInt(request.getParameter("pantSize"));
		fabric = request.getParameter("pantFabric");
	}
	*/
	String itemName = request.getParameter("itemName");   
    Double initialPrice = Double.parseDouble(request.getParameter("initialPrice"));
    Double minimumPrice = Double.parseDouble(request.getParameter("minimumPrice"));
    Double bidIncrement = Double.parseDouble(request.getParameter("bidIncrement"));
    LocalDateTime closeDate = LocalDateTime.parse(request.getParameter("closeDate"));
    
    /*
    System.out.println(itemType);
    System.out.println(itemName);
    System.out.println(initialPrice);
    System.out.println(minimumPrice);
    System.out.println(bidIncrement);
    System.out.println(closeDate);
    */
    
    if(minimumPrice<initialPrice){
    	out.println("Minimum price cannot be less than initial price.");
    	out.println("<a href='sell.jsp'>Try again</a>");
    }else{
    	Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
	    String username = (String) session.getAttribute("user");
	    
	    String searchSellersString = "select * from sellers where sellerName = ?";
	    String insertSellersString = "insert into sellers values (?)";
	    String searchClothingAuctionsString = "select * from clothingAuctions where productID = ?";
	    String insertClothingAuctionsString = "insert into clothingAuctions (productID, itemName, initialPrice, minimumPrice, bidIncrement, closeDate, seller) values (?, ?, ?, ?, ?, ?, ?)";
	    
	    PreparedStatement searchSellers = con.prepareStatement(searchSellersString);
	    PreparedStatement insertSellers = con.prepareStatement(insertSellersString);
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
    	
    	//make sure this user is included in seller
    	searchSellers.setString(1, username);
    	ResultSet rs2 = searchSellers.executeQuery();
    	if(!rs2.next()){
    		//not in sellers table yet
    		insertSellers.setString(1, username);
    		insertSellers.executeUpdate();
    	}
    	
    	//add item to auctions table
    	/*insert into clothingAuctions (productID, itemName, initialPrice, minimumPrice, bidIncrement, 
    			closeDate, seller) values (?, ?, ?, ?, ?, ?, ?)*/
    	insertClothingAuctions.setString(1, String.valueOf(id));
    	insertClothingAuctions.setString(2, itemName);
    	insertClothingAuctions.setString(3, Double.toString(initialPrice));
    	insertClothingAuctions.setString(4, Double.toString(minimumPrice));
    	insertClothingAuctions.setString(5, Double.toString(bidIncrement));
    	insertClothingAuctions.setString(6, closeDate.toString());
    	insertClothingAuctions.setString(7, username);
    	insertClothingAuctions.executeUpdate();
    	
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
    }
%>