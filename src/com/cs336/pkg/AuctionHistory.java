package com.cs336.pkg;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AuctionHistory {

	public List<HistoryDetails> getHistory(String op) {
		Connection con = ApplicationDB.getConnection();
		Statement st;
		List<HistoryDetails> records = new ArrayList<HistoryDetails>();
		try {
			st = con.createStatement();
			ResultSet rs = st.executeQuery(op);
			while (rs.next()) {
				HistoryDetails record = new HistoryDetails();
				record.setPID(rs.getString("productID"));
				record.setWinner(rs.getString("winner"));
				record.setStartDate(rs.getString("startDate"));
				record.setEndDate(rs.getString("endDate"));
				record.setBidder(rs.getString("bidder"));
				record.setItemName(rs.getString("itemName"));
				record.setItemType(rs.getString("itemType"));
				record.setBidAmount(rs.getString("bidAmount"));
				record.setBidDate(rs.getString("bidDate"));
				records.add(record);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return records;
	}
}
