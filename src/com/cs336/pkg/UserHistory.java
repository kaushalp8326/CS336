package com.cs336.pkg;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserHistory {

	public List<UserDetails> BidHistory(String op) {
		Connection con = ApplicationDB.getConnection();
		Statement st;
		List<UserDetails> bids = new ArrayList<UserDetails>();
		try {
			st = con.createStatement();
			ResultSet rs = st.executeQuery(op);
			while (rs.next()) {
				UserDetails bid = new UserDetails();
				bid.setUsername(rs.getString("username"));
				bid.setPID(rs.getString("PID"));
				bids.add(bid);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return bids;
	}
	
	public List<UserDetails> SellHistory(String op) {
		Connection con = ApplicationDB.getConnection();
		Statement st;
		List<UserDetails> sells = new ArrayList<UserDetails>();
		try {
			st = con.createStatement();
			ResultSet rs = st.executeQuery(op);
			while (rs.next()) {
				UserDetails sell = new UserDetails();
				sell.setUsername(rs.getString("username"));
				sell.setPID(rs.getString("PID"));
				sells.add(sell);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return sells;
	}
}
