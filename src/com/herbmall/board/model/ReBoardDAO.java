package com.herbmall.board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.herbmall.db.ConnectionPoolMgr;

public class ReBoardDAO {
	private ConnectionPoolMgr pool;

	public ReBoardDAO() {
		pool = new ConnectionPoolMgr();
	}

	/**
	 * 글등록
	 * 
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int insertReBoard(ReBoardVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			// 1,2
			con = pool.getConnection();

			// 3
			String sql = "insert into reBoard(no, name, pwd, title, " + " email, content, groupno)"
					+ " values(reBoard_seq.nextval, ?,?,?,?,?,reBoard_seq.nextval)";
			ps = con.prepareStatement(sql);

			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());

			int cnt = ps.executeUpdate();
			System.out.println("글 등록 결과, cnt=" + cnt + ", 매개변수 vo=" + vo);

			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}

	/**
	 * 글 목록
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<ReBoardVO> selectAll(String condition, String keyword) throws SQLException {
		/*
		 * ※ 검색의 경우 select * from reBoard where title like '%안녕%'; select * from reBoard
		 * where name like '%길%'; select * from reBoard where content like '%내용%';
		 */

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		List<ReBoardVO> list = new ArrayList<ReBoardVO>();
		try {
			// 1,2
			con = pool.getConnection();

			// 3
			String sql = "select * from reBoard";
			if (keyword != null && !keyword.isEmpty()) { // 검색의 경우
				sql += " where " + condition + " like '%' || ? || '%'";
			}

			sql += " order by groupno desc, sortno";

			ps = con.prepareStatement(sql);

			if (keyword != null && !keyword.isEmpty()) { // 검색의 경우
				ps.setString(1, keyword);
			}

			rs = ps.executeQuery();
			while (rs.next()) {
				int no = rs.getInt("no");
				String title = rs.getString("title");
				String name = rs.getString("name");
				String pwd = rs.getString("pwd");
				String email = rs.getString("email");
				String content = rs.getString("content");
				int readcount = rs.getInt("readcount");
				Timestamp regdate = rs.getTimestamp("regdate");

				int groupNo = rs.getInt("groupno");
				int step = rs.getInt("step");
				int sortNo = rs.getInt("sortNo");
				String delflag = rs.getString("delflag");

				ReBoardVO vo = new ReBoardVO(no, name, pwd, title, email, regdate, readcount, content, groupNo, step,
						sortNo, delflag);
				list.add(vo);
			}

			System.out.println(
					"글목록 결과 list.size=" + list.size() + ", 매개변수 condition=" + condition + ", keyword=" + keyword);

			return list;
		} finally {
			pool.dbClose(con, ps, rs);
		}
	}

	/**
	 * 글 상세보기
	 * 
	 * @param no
	 * @return
	 * @throws SQLException
	 */
	public ReBoardVO selectByNo(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		ReBoardVO vo = new ReBoardVO();
		try {
			// 1,2
			con = pool.getConnection();

			// 3
			String sql = "select * from reBoard where no=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, no);

			// 4
			rs = ps.executeQuery();
			if (rs.next()) {
				String title = rs.getString("title");
				String name = rs.getString("name");
				String pwd = rs.getString("pwd");
				String email = rs.getString("email");
				String content = rs.getString("content");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");

				int groupNo = rs.getInt("groupno");
				int step = rs.getInt("step");
				int sortNo = rs.getInt("sortNo");
				String delflag = rs.getString("delflag");

				vo.setContent(content);
				vo.setEmail(email);
				vo.setName(name);
				vo.setNo(no);
				vo.setPwd(pwd);
				vo.setReadcount(readcount);
				vo.setRegdate(regdate);
				vo.setTitle(title);
				vo.setGroupNo(groupNo);
				vo.setStep(step);
				vo.setSortNo(sortNo);
				vo.setDelflag(delflag);
			}

			System.out.println("글 상세보기 결과, vo=" + vo + ", 매개변수no=" + no);

			return vo;
		} finally {
			pool.dbClose(con, ps, rs);
		}
	}

	/**
	 * 글 수정
	 * 
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int updateReBoard(ReBoardVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			// 1,2
			con = pool.getConnection();

			// 3
			String sql = "update reBoard" 
					+ " set name=?,title=?,email=?,content=?" 
					+ " where no=? and pwd=?";
			ps = con.prepareStatement(sql);

			ps.setString(1, vo.getName());
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getEmail());
			ps.setString(4, vo.getContent());
			ps.setInt(5, vo.getNo());
			ps.setString(6, vo.getPwd());

			int cnt = ps.executeUpdate();
			System.out.println("글 수정 결과, cnt=" + cnt + ", 매개변수 vo=" + vo);

			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}

	public int updateReadCount(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();

			String sql = "update reBoard" + " set readcount=readcount+1" + " where no=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, no);

			int cnt = ps.executeUpdate();
			System.out.println("조회수 증가 결과, cnt=" + cnt + ", 매개변수 no=" + no);

			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}

	public int deleteReBoard(int no, String pwd) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			// 1,2
			con = pool.getConnection();

			// 3
			String sql = "delete from reBoard where no=? and pwd=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, no);
			ps.setString(2, pwd);

			int cnt = ps.executeUpdate();
			System.out.println("글 삭제 결과, cnt=" + cnt + ", 매개변수 no=" + no + ", pwd=" + pwd);

			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}

	public int reply(ReBoardVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;

		int cnt =0;
		
		try {
			// 1,2 con
			con = pool.getConnection();

			// transaction 시작
			con.setAutoCommit(false); // 자동 커밋 안되도록 설정

			// 3 ps
			//[1] update
			String sql = "update reboard" 
					+ " set sortno = sortno+1" 
					+ " where groupno=? and sortno>?";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, vo.getGroupNo());
			ps.setInt(2, vo.getSortNo());
			
			// 4 exec
			cnt = ps.executeUpdate();
			
			//[2] insert
			sql = "insert into reboard" + 
					" values(reBoard_seq.nextval, ?, ?, ?, ?, default, default, ?, ?, ?, ?, default)";
			ps2 = con.prepareStatement(sql);
			
			ps2.setString(1, vo.getName());
			ps2.setString(2, vo.getPwd());
			ps2.setString(3, vo.getTitle());
			ps2.setString(4, vo.getEmail());
			ps2.setString(5, vo.getContent());
			ps2.setInt(6, vo.getGroupNo());
			ps2.setInt(7, vo.getStep()+1);
			ps2.setInt(8, vo.getSortNo()+1);
			
			cnt = ps2.executeUpdate();
			System.out.println("답변하기 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			//모두 성공하면 커밋
			con.commit();
		}catch (SQLException e) {
			//하나라도 실패하면 롤백
			con.rollback();
			e.printStackTrace();
		} finally {
			//다시 자동으로 커밋되도록 설정
			con.setAutoCommit(true);
			
			if(ps2 != null) ps2.close();
			pool.dbClose(con, ps);
			
		}
		
		return cnt;
	}
}
