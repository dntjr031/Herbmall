package com.herbmall.comment.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.herbmall.db.ConnectionPoolMgr2;

public class CommentDAO {
	private ConnectionPoolMgr2 pool;
	
	public CommentDAO() {
		pool = ConnectionPoolMgr2.getInstance();
	}

	public int insertComment(CommentVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = pool.getConnection();
			
			String sql = "insert into comments(NO, NAME, PWD, CONTENT, BDNO)" + 
					" values(COMMENTS_SEQ.nextval,?,?,?,?)";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getContent());
			ps.setInt(4, vo.getBdno());
			
			int cnt = ps.executeUpdate();
			System.out.println("댓글 등록결과 cnt=" + cnt + ", 매개변수 vo=" + vo);
			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}
	
	public List<CommentVO> selectAll(int bdno) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			
			String sql = "select * from comments where bdno=? order by no desc";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, bdno);
			
			rs = ps.executeQuery();
			List<CommentVO> list = new ArrayList<CommentVO>();
			while (rs.next()) {
				CommentVO vo = new CommentVO();
				vo.setBdno(rs.getInt("bdno"));
				vo.setContent(rs.getString("content"));
				vo.setName(rs.getString("name"));
				vo.setNo(rs.getInt("no"));
				vo.setPwd(rs.getString("pwd"));
				vo.setRegdate(rs.getTimestamp("regdate"));
				list.add(vo);
			}
			System.out.println("댓글 조회 결과 list.size=" + list.size());
			
			return list;
		} finally {
			pool.dbClose(con, ps, rs);
		}
	}
	
	public int selectCount(int bdno) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "select count(*) from comments where bdno = ?";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, bdno);
			
			rs = ps.executeQuery();
			int cnt = 0;
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			
			System.out.println("댓글 수 조회 결과 cnt=" + cnt + ", 매개변수 bdno=" + bdno);
			return cnt;
		} finally {
			pool.dbClose(con, ps, rs);
		}
	}
}
