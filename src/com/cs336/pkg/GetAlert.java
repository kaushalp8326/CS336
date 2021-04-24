package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class GetAlert {

	public List<Wishlist> getWishlist(String op) {
		Connection con = ApplicationDB.getConnection();
		Statement st;
		List<Wishlist> wishlist = new ArrayList<Wishlist>();
		try {
			st = con.createStatement();
			ResultSet rs = st.executeQuery(op);
			while (rs.next()) {
				Wishlist item = new Wishlist();
				item.setUsername(rs.getString("username"));
				item.setProductName(rs.getString("productName"));
				wishlist.add(item);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return wishlist;
	}
}