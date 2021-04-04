package com.cs336.pkg;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AuctionListings {
	
	public List<ListingDetails> getListings(){
		Connection con = ApplicationDB.getConnection();
		Statement st;
		List<ListingDetails> listings = new ArrayList<ListingDetails>();
		try {
			st = con.createStatement();
			ResultSet rs = st.executeQuery("select * from auctionView");
			while (rs.next()) {		
				ListingDetails listing = new ListingDetails();
				listing.setID(rs.getString("ID"));
				listing.setType(rs.getString("Type"));
				listing.setName(rs.getString("Name"));
				listing.setPrice(rs.getString("Initial_Price"));
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
