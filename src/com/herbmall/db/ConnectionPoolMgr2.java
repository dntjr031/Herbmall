package com.herbmall.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionPoolMgr2 {
	// 싱글톤 패턴 이용
	private static ConnectionPoolMgr2 instance;
	
	private DataSource ds;
	
	//생성자
	private ConnectionPoolMgr2(){
		
		try {
			
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/oracledb");
			
			System.out.println("DataSource 생성됨");
		}catch (NamingException e) {
			System.out.println("DataSource 생성 실패!");
			e.printStackTrace();
		}
	}//생성자
		
	public Connection getConnection() 
			throws SQLException{
		
		Connection con= ds.getConnection();	
		System.out.println("db연결 여부, con="+con);
		return con;
	}
	
	
	
	//자원해제하는 메서드
	public void dbClose(Connection con, PreparedStatement ps) throws SQLException{
		if(ps!=null) ps.close();
		if(con!=null) con.close();
	}
	
	public void dbClose(Connection con,  PreparedStatement ps,  
			ResultSet rs) throws SQLException{
		if(rs!=null) rs.close();
		if(ps!=null) ps.close();
		if(con!=null) con.close();		
	}
	
	//컨넥션풀 객체를 하나만 생성하는 메서드
	public static ConnectionPoolMgr2 getInstance() {
		if(instance == null) {
			instance = new ConnectionPoolMgr2();
		}
		return instance;
	}
}//class
