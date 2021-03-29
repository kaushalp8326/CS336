<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html>
	<%@ include file = "header.jsp" %>
	<head>
		<meta charset="ISO-8859-1">
		<title>Sell an Item</title>
		<script>
		function setMinDate() {
			var present = new Date();
			//Make the minimum end date at least one day from the present
			present.setDate(present.getDate() + 1);
			var dd = present.getDate();
			if(dd<10){
				dd = "0" + dd;
			}
			var MM = present.getMonth() + 1;
			if(MM<10){
				MM = "0" + MM;
			}
			var yyyy = present.getFullYear();
			var hh = present.getHours();
			if(hh<10){
				hh = "0" + hh;
			}
			var mm = present.getMinutes();
			if(mm<10){
				mm = "0" + mm;
			}
			var minimum = yyyy + "-" + MM + "-" + dd + "T" + hh + ":" + mm;
			document.getElementById("closeDate").min = minimum;
		}
		</script>
		<script>
		function radio() {
			if (document.getElementById('itemTypeShoes').checked) {
				document.getElementById('shoeRow').style.visibility = 'visible';
				document.getElementById('shoeBrand').required = true;
				document.getElementById('shoeSize').required = true;
				document.getElementById('shoeColor').required = true;
				
				document.getElementById('shirtRow').style.visibility = 'hidden';
				document.getElementById('shirtStyle').required = false;
				document.getElementById('shirtSize').required = false;
				document.getElementById('shirtFabric').required = false;
				
				document.getElementById('pantRow').style.visibility = 'hidden';
				document.getElementById('pantBrand').required = false;
				document.getElementById('pantSize').required = false;
				document.getElementById('pantFabric').required = false;
			}else if(document.getElementById('itemTypeShirts').checked){
				document.getElementById('shirtRow').style.visibility = 'visible';
				document.getElementById('shirtStyle').required = true;
				document.getElementById('shirtSize').required = true;
				document.getElementById('shirtFabric').required = true;
				
				document.getElementById('shoeRow').style.visibility = 'hidden';
				document.getElementById('shoeBrand').required = false;
				document.getElementById('shoeSize').required = false;
				document.getElementById('shoeColor').required = false;
				
				document.getElementById('pantRow').style.visibility = 'hidden';
				document.getElementById('pantBrand').required = false;
				document.getElementById('pantSize').required = false;
				document.getElementById('pantFabric').required = false;
			}else if(document.getElementById('itemTypePants').checked){
				document.getElementById('pantRow').style.visibility = 'visible';
				document.getElementById('pantBrand').required = true;
				document.getElementById('pantSize').required = true;
				document.getElementById('pantFabric').required = true;
				
				document.getElementById('shoeRow').style.visibility = 'hidden';
				document.getElementById('shoeBrand').required = false;
				document.getElementById('shoeSize').required = false;
				document.getElementById('shoeColor').required = false;
				
				document.getElementById('shirtRow').style.visibility = 'hidden';
				document.getElementById('shirtStyle').required = false;
				document.getElementById('shirtSize').required = false;
				document.getElementById('shirtFabric').required = false;
			}else{
				document.getElementById('shoeRow').style.visibility = 'hidden';
				document.getElementById('shoeBrand').required = false;
				document.getElementById('shoeSize').required = false;
				document.getElementById('shoeColor').required = false;
				
				document.getElementById('shirtRow').style.visibility = 'hidden';
				document.getElementById('shirtStyle').required = false;
				document.getElementById('shirtSize').required = false;
				document.getElementById('shirtFabric').required = false;
				
				document.getElementById('pantRow').style.visibility = 'hidden';
				document.getElementById('pantBrand').required = false;
				document.getElementById('pantSize').required = false;
				document.getElementById('pantFabric').required = false;
			}
		}
		</script>
	</head>
	<body>
		<h1>Sell an Item</h1>
		<form action="checkSellFields.jsp" method="POST">
			<div>
				<p>Item Type:</p>
				<input type="radio" name="itemType" id="itemTypeShoes" value="shoes" onclick="radio();" required/>
				<label for="itemType1">Shoes</label>
				<br>
				<input type="radio" name="itemType" id="itemTypeShirts" value="shirts" onclick="radio();" required/>
				<label for="itemType2">Shirts</label>
				<br>
				<input type="radio" name="itemType" id="itemTypePants" value="pants" onclick="radio();" required/>
				<label for="itemType3">Pants</label>
				<br>
				<table>
					<tr id="shoeRow" style="visibility:hidden">
						<td>
							<label for="shoeBrand">Brand:</label>
							<input type="text" name="shoeBrand" id="shoeBrand"/>
						</td>
						<td>
							<label for="shoeSize">Size:</label>
							<input type="number" step="1" min="1" name="shoeSize" id="shoeSize"/>
						</td>
						<td>
							<label for="shoeColor">Color:</label>
							<input type="text" name="shoeColor" id="shoeColor"/>
						</td>
					</tr>
					<tr id="shirtRow" style="visibility:hidden">
						<td>
							<label for="shirtStyle">Style:</label>
							<input type="text" name="shirtStyle" id="shirtStyle"/>
						</td>
						<td>
							<label for="shirtSize">Size:</label>
							<input type="text" name="shirtSize" id="shirtSize"/>
						</td>
						<td>
							<label for="shirtFabric">Fabric:</label>
							<input type="text" name="shirtFabric" id="shirtFabric"/>
						</td>
					</tr>
					<tr id="pantRow" style="visibility:hidden">
						<td>
							<label for="pantBrand">Brand:</label>
							<input type="text" name="pantBrand" id="pantBrand"/>
						</td>
						<td>
							<label for="pantSize">Size:</label>
							<input type="number" step="1" min="1" name="pantSize" id="pantSize"/>
						</td>
						<td>
							<label for="pantFabric">Fabric:</label>
							<input type="text" name="pantFabric" id="pantFabric"/>
						</td>
					</tr>
				</table>
			</div>
			<label for="itemName">Item Name:</label>
			<input type="text" name="itemName" id="itemName" required/> <br><br>
			<label for="initialPrice">Initial Price:</label>
			<input type="number" step="0.01" min="0" name="initialPrice" id="initialPrice" onchange="document.getElementById('minimumPrice').min=this.value;" required/> <br><br>
			<label for="minimumPrice">Minimum Selling Price:</label>
			<input type="number" step="0.01" min="0" name="minimumPrice" id="minimumPrice" required/> <br><br>
			<label for="bidIncrement">Minimum Bid Increment:</label>
			<input type="number" step="0.01" min="0" name="bidIncrement" id="bidIncrement" required/> <br><br>
			<label for="closeDate">Auction End Date:</label>
			<input type="datetime-local" name="closeDate" id="closeDate" onclick="setMinDate();" required/> <br><br>
			<input type="submit" value="Post Item For Sale"/>
		</form>
		<br>
		<form action="home.jsp">
			<button type="submit">Cancel</button>
		</form>
	</body>
</html>