package com.herbmall.zipcode.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.herbmall.db.ConnectionPoolMgr2;

public class ZipcodeDAO {
	private ConnectionPoolMgr2 pool = null;
	
	
	public ZipcodeDAO() {
		pool = ConnectionPoolMgr2.getInstance();
	}


	public List<ZipcodeVO> searchByDong(String dong) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<ZipcodeVO> list = new ArrayList<ZipcodeVO>();
		
		try {
			con = pool.getConnection();
			
			String sql = "select * from zipcode where dong like '%' || ? || '%'";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, dong);
			
			rs = ps.executeQuery();
			
			while (rs.next()) {
				String zipcode = rs.getString(1);
				String sido = rs.getString(2);
				String gugun = rs.getString(3);
				String dongVo = rs.getString(4);
				String startbunji = rs.getString(5);
				String endbunji = rs.getString(6);
				int seq = rs.getInt(7);
				
				ZipcodeVO vo = new ZipcodeVO(zipcode, sido, gugun, dongVo, startbunji, endbunji, seq);
				
				list.add(vo);
			}
			System.out.println("검색 결과 list.size()=" + list.size() + ", 매개변수 dong=" + dong);
			
			return list;
		} finally {
			pool.dbClose(con, ps, rs);
		}
	}
}
