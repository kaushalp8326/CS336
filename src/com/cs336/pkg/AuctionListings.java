package com.cs336.pkg;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AuctionListings {

	public List<ListingDetails> getListings() {
		Connection con = ApplicationDB.getConnection();
		Statement st;
		List<ListingDetails> listings = new ArrayList<ListingDetails>();
		try {
			st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from clothingAuctions");
			while (rs.next()) {
				ListingDetails listing = new ListingDetails();
				listing.setID(rs.getString("productID"));
				listing.setType(rs.getString("itemType"));
				listing.setName(rs.getString("itemName"));
				listing.setPrice(rs.getString("initialPrice"));
				listing.setStartDate(rs.getString("startDate"));
				listing.setEndDate(rs.getString("endDate"));
				listings.add(listing);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return listings;
	}
}
