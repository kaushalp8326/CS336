package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AutoBidding {
	String bidder;
	int upperLimit;
	int increment;
	int pid;
	public AutoBidding() {}
	public AutoBidding(String b, int u, int i, int p) {
		bidder=b;
		upperLimit=u;
		increment=i;
		pid=p;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getBidder() {
		return bidder;
	}
	public void setBidder(String bidder) {
		this.bidder = bidder;
	}
	
	public int getUpperLimit() {
		return upperLimit;
	}
	public void setUpperLimit(int upperLimit) {
		this.upperLimit = upperLimit;
	}
	public int getIncrement() {
		return increment;
	}
	public void setIncrement(int increment) {
		this.increment = increment;
	}
	private boolean checkBid ()
	{
		Connection con = ApplicationDB.getConnection();
		Statement st;
		
		try {
			st = con.createStatement();
			int amount = 0;
			
			do {
				amount +=increment;
				String query = String.format("SELECT 1 FROM bids WHERE pid = %d AND bidAmount > %d", pid, amount);
				
				ResultSet rs = st.executeQuery(query);
				if(!rs.next())
				{
					return true;
				}
				
			}while (amount<upperLimit);
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	private void usage () {
		AutoBidding auto = new AutoBidding();
		auto.setPid(123);
		auto.setIncrement(1);
		auto.setUpperLimit(100);
		
		if (auto.checkBid())
		{
			
		}
	}
}
