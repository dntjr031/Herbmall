package com.herbmall.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionPoolMgr {
	public ConnectionPoolMgr() {
		// 드라이버 연결
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 로딩 성공!");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패!");
			e.printStackTrace();
		}
	}

	public Connection getConnection(String user, String upwd, String url) throws SQLException {
		// con
		Connection con = DriverManager.getConnection(url, user, upwd);
		System.out.println("db연결 여부 con=" + con);

		return con;
	}

	public Connection getConnection(String user, String upwd) throws SQLException {
		// con
		String url = "jdbc:oracle:thin:@DESKTOP-Q8AMKFB:1521:xe";
		Connection con = getConnection(user, upwd,url);
		return con;
	}

	public Connection getConnection() throws SQLException {
		// con
		String url = "jdbc:oracle:thin:@DESKTOP-Q8AMKFB:1521:xe";
		String user="herb", password="herb123";

		Connection con = getConnection(user, password,url);
		return con;
	}

	public void dbClose(Connection con, PreparedStatement ps, ResultSet rs) throws SQLException {
		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();
		if (con != null)
			con.close();

	}

	public void dbClose(Connection con, PreparedStatement ps) throws SQLException {

		if (ps != null)
			ps.close();
		if (con != null)
			con.close();

	}
}
