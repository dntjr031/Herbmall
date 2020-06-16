package com.herbmall.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.herbmall.db.ConnectionPoolMgr2;

public class MemberDAO {
	
	private ConnectionPoolMgr2 pool = null;
	
	public MemberDAO() {
		pool = ConnectionPoolMgr2.getInstance();
	}

	public int insertMember(MemberVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "insert into member(no, userid, name, pwd, email, hp, zipcode, address, addressdetail)\r\n" + 
					"values(MEMBER_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, vo.getUserid());
			ps.setString(2, vo.getName());
			ps.setString(3, vo.getPwd());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getHp());
			ps.setString(6, vo.getZipcode());
			ps.setString(7, vo.getAddress());
			ps.setString(8, vo.getAddressDetail());
			
			int cnt = ps.executeUpdate();
			System.out.println("등록 결과 cnt = " + cnt + ", vo=" + vo);
			
			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}
	
	public int duplicateId(String userid) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int result = 0;
		try {
			con = pool.getConnection();
			
			String sql = "select count(*) from member where userid=?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				int count = rs.getInt(1);
				if(count > 0) { //해당 아이디가 이미존재
					result = MemberService.EXIST_ID;
				}else {
					result = MemberService.NON_EXIST_ID;
				}
			}
			
			System.out.println("아이디 중복확인 결과 result=" + result);
			
			return result;
			
		}finally {
			pool.dbClose(con, ps, rs);;
		}
	}
}
