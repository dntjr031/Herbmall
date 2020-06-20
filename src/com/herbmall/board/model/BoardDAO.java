package com.herbmall.board.model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import com.herbmall.db.ConnectionPoolMgr2;

public class BoardDAO {
	private ConnectionPoolMgr2 pool = null;

	public BoardDAO() {
		pool = ConnectionPoolMgr2.getInstance();
	}

	public int insertBoard(BoardVo vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();

			String sql = "insert into board(NO, NAME, PWD, TITLE, EMAIL, CONTENT)\n"
					+ "values(BOARD_SEQ.nextval, ?, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);

			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());

			int cnt = ps.executeUpdate();
			System.out.println("글 등록 결과 cnt=" + cnt + ", 매개변수 vo=" + vo);

			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}

	/**
	 * 
	 * @return List<BoardVo>
	 * @throws SQLException
	 */
	public List<BoardVo> selectAll(String condition, String keyword) throws SQLException {
		/*
		 * 검색의 경우
		 * select * from board where title like '%'|| 'a' ||'%';
		 * 
		 * select * from board where name like '%'|| 'a' ||'%';
		 * 
		 * select * from board where content like '%'|| 'a' ||'%';
		 */
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = pool.getConnection();

			String sql = "select * from board";
			if(keyword != null && !keyword.isEmpty()) {
				sql += " where " + condition +  " like '%' || ? || '%'";
			}
			sql += " order by no desc";
			ps = con.prepareStatement(sql);

			if(keyword != null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}
			
			rs = ps.executeQuery();

			List<BoardVo> list = new ArrayList<>();
			while (rs.next()) {

				int no = rs.getInt("no");
				String title = rs.getString("title");
				String name = rs.getString("name");
				String pwd = rs.getString("pwd");
				String email = rs.getString("email");
				String content = rs.getString("content");
				int readcount = rs.getInt("readcount");
				Timestamp regdate = rs.getTimestamp("regdate");

				BoardVo vo = new BoardVo(no, name, pwd, title, email, regdate, readcount, content);
				list.add(vo);
			}

			System.out.println("글목록 결과 list.size=" + list.size() + ", 매개변수 condition="
					+ condition + ", keyword=" + keyword);
			return list;

		} finally {
			pool.dbClose(con, ps, rs);
		}
	}

	public BoardVo selectByNo(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		BoardVo vo = new BoardVo();
		try {
			con = pool.getConnection();

			String sql = "select * from board where no=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, no);

			rs = ps.executeQuery();

			while (rs.next()) {
				String title = rs.getString("title");
				String name = rs.getString("name");
				String pwd = rs.getString("pwd");
				String email = rs.getString("email");
				String content = rs.getString("content");
				Timestamp regdate = rs.getTimestamp("regdate");
				int readcount = rs.getInt("readcount");

				vo.setContent(content);
				vo.setEmail(email);
				vo.setName(name);
				vo.setNo(no);
				vo.setPwd(pwd);
				vo.setReadcount(readcount);
				vo.setRegdate(regdate);
				vo.setTitle(title);

			}

			System.out.println("글 상세보기 결과, vo=" + vo + ", 매개변수 no=" + no);

			return vo;
		} finally {
			pool.dbClose(con, ps, rs);
		}
	}

	public int updateBoard(BoardVo vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();

			String sql = "update board\r\n" + "set NAME=?, TITLE=?, EMAIL=?, CONTENT=?\r\n" + "where no =? and pwd=?";
			ps = con.prepareStatement(sql);

			ps.setString(1, vo.getName());
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getEmail());
			ps.setString(4, vo.getContent());
			ps.setInt(5, vo.getNo());
			ps.setString(6, vo.getPwd());

			int cnt = ps.executeUpdate();

			System.out.println("글 수정 결과 cnt=" + cnt + ", 매개변수 vo=" + vo);
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

			String sql = "update board\r\n" + "set READCOUNT = READCOUNT + 1\r\n" + "where no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);

			int cnt = ps.executeUpdate();

			System.out.println("조회수 증가 결과 cnt=" + cnt + ", 매개변수 no=" + no);
			return cnt;
		} finally {
			pool.dbClose(con, ps);
		}
	}

	public String pwdByNo(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String pwd = "";
		try {
			con = pool.getConnection();

			String sql = "select pwd from board where no = ?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, no);

			rs = ps.executeQuery();
			if (rs.next()) {
				pwd = rs.getString(1);
			}

			System.out.println("비밀번호 찾기 결과 pwd=" + pwd + ", 매개변수 no=" + no);
			return pwd;

		} finally {
			pool.dbClose(con, ps, rs);
		}
	}

	public int deleteByNo(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();

			String sql = "delete from board where no = ?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, no);

			int cnt = ps.executeUpdate();

			System.out.println("삭제 결과 cnt=" + cnt + ", 매개변수 no=" + no);
			return cnt;
		} finally {

		}
	}
	
	public List<BoardVo> selectNotice() throws SQLException {
		/*
		select a.* 
		from(select NO, NAME, PWD, TITLE,
		 EMAIL, REGDATE, READCOUNT, CONTENT 
		 from board order by no desc) a
		where rownum <7
		 */
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = pool.getConnection();

			String sql = "select a.* " + 
					" from(select NO, NAME, PWD, TITLE," + 
					" EMAIL, REGDATE, READCOUNT, CONTENT " + 
					" from board order by no desc) a" + 
					" where rownum < 7";
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();

			List<BoardVo> list = new ArrayList<>();
			while (rs.next()) {


				BoardVo vo = new BoardVo( rs.getInt("no"), rs.getString("name"), 
						rs.getString("pwd"), rs.getString("title"), rs.getString("email"), 
						rs.getTimestamp("regdate"), rs.getInt("readcount"), 
						rs.getString("content"));
				
				list.add(vo);
			}

			System.out.println("공지글 결과 list.size=" + list.size());
			return list;

		} finally {
			pool.dbClose(con, ps, rs);
		}
	}
	
	
}
