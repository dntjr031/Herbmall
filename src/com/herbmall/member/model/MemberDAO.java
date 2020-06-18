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
	
	public int loginCheck(String userid, String pwd) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			
			String sql = "select pwd from member where userid = ? and outdate is null";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			int result = 0;
			if(rs.next()) {
				String userpwd = rs.getString(1);
				if(userpwd.equals(pwd)) {
					result = MemberService.LOGIN_OK;
				}else {
					result = MemberService.PWD_DISAGREE;
				}
			}else {
				result = MemberService.ID_NONE;
			}
			System.out.println("로그인 처리결과 result="+result +", 매개변수 userid="+userid
					+ ", pwd=" + pwd);
			return result;
		} finally {
			pool.dbClose(con, ps, rs);
		}
	}
	
	public MemberVO selectMember(String userid) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "select * from member where userid = ?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			MemberVO vo = new MemberVO();
			while (rs.next()) {
				vo.setAddress(rs.getString("address"));
				vo.setAddressDetail(rs.getString("addressdetail"));
				vo.setEmail(rs.getString("email"));
				vo.setHp(rs.getString("hp"));
				vo.setMileage(rs.getInt("mileage"));
				vo.setName(rs.getString("name"));
				vo.setNo(rs.getInt("no"));
				vo.setOutdate(rs.getTimestamp("outdate"));
				vo.setPwd(rs.getString("pwd"));
				vo.setRegdate(rs.getTimestamp("regdate"));
				vo.setUserid(rs.getString("userid"));
				vo.setZipcode(rs.getString("zipcode"));
			}
			
			System.out.println("조회 결과 vo=" + vo + ", 매개변수 userid=" + userid);
			return vo;
		} finally {
			pool.dbClose(con, ps, rs);
		}
	}
	
	public int updateMember(MemberVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "update member"
					+ " set zipcode=?, address=?, addressdetail=?, hp=?, email=?"
					+ " where userid=?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, vo.getZipcode());
			ps.setString(2, vo.getAddress());
			ps.setString(3, vo.getAddressDetail());
			ps.setString(4, vo.getHp());
			ps.setString(5, vo.getEmail());
			ps.setString(6, vo.getUserid());
			
			int cnt = ps.executeUpdate();
			System.out.println("수정결과 cnt=" + cnt + ", 매개변수 vo=" + vo);
			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}
	
	public int memberOut(String userid) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "update member\r\n" + 
					"set outdate = sysdate\r\n" + 
					"where userid = ?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, userid);
			
			int cnt = ps.executeUpdate();
			
			System.out.println("탈퇴결과 cnt=" + cnt + ", 매개변수 userid=" + userid);
			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}
}
