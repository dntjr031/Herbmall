package com.herbmall.board.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.herbmall.db.ConnectionPoolMgr;
import com.herbmall.db.ConnectionPoolMgr1;

public class ReBoardDAO {
	private ConnectionPoolMgr1 pool;
	
	public ReBoardDAO() {
		pool=ConnectionPoolMgr1.getInstance();
	}
	
	/**
	 * 글등록
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int insertReBoard(ReBoardVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="insert into reBoard(no, name, pwd, title, "
					+ " email, content, groupno, filename, filesize, originalFileName)" + 
					" values(reBoard_seq.nextval, ?,?,?,?,?, reBoard_seq.nextval,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			
			ps.setString(6, vo.getFileName());
			ps.setLong(7, vo.getFileSize());
			ps.setString(8, vo.getOriginalFileName());
			
			int cnt=ps.executeUpdate();
			System.out.println("글 등록 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.returnConnection(con);
		}
	}
	
	/**
	 * 글 목록
	 * @return
	 * @throws SQLException
	 */
	public List<ReBoardVO> selectAll(String condition, String keyword) 
			throws SQLException{
		/*
		 ※ 검색의 경우 
		 	select * from reBoard 
			where title like '%안녕%';
			select * from reBoard 
			where name like '%길%';
			select * from reBoard 
			where content like '%내용%';
		*/
		
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ReBoardVO> list = new ArrayList<ReBoardVO>();
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select * from reBoard";
			if(keyword!=null && !keyword.isEmpty()) { //검색의 경우
				sql+=" where "+ condition +" like '%' || ? || '%'";
			}
			
			sql+=" order by groupno desc, sortno";
			
			ps=con.prepareStatement(sql);
			
			if(keyword!=null && !keyword.isEmpty()) { //검색의 경우
				ps.setString(1, keyword);				
			}
			
			rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt("no");
				String title=rs.getString("title");
				String name=rs.getString("name");
				String pwd=rs.getString("pwd");
				String email=rs.getString("email");
				String content=rs.getString("content");
				int readcount=rs.getInt("readcount");
				Timestamp regdate=rs.getTimestamp("regdate");
				
				int groupno=rs.getInt("groupNo");
				int step=rs.getInt("step");
				int sortno=rs.getInt("sortNo");
				String delFlag=rs.getString("delflag");
				
				String fileName=rs.getString("fileName");
				String originalFileName=rs.getString("originalFileName");
				int downcount=rs.getInt("downcount");
				long fileSize=rs.getInt("fileSize");
				
				ReBoardVO vo = new ReBoardVO(no, name, pwd, title, 
						email, regdate, readcount, content, 
						groupno, step, sortno, delFlag, fileName, 
						fileSize, downcount, originalFileName);
				
				list.add(vo);
			}
			
			System.out.println("글목록 결과 list.size="+list.size()
				+ ", 매개변수 condition="+condition
				+", keyword="+keyword);
			
			return list;
		}finally {
			pool.returnConnection(con);
		}
	}
	
	/**
	 * 글 상세보기
	 * @param no
	 * @return
	 * @throws SQLException
	 */
	public ReBoardVO selectByNo(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		ReBoardVO vo=new ReBoardVO();
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select * from reBoard where no=?";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, no);
			
			//4
			rs=ps.executeQuery();
			if(rs.next()) {
				String title=rs.getString("title");
				String name=rs.getString("name");
				String pwd=rs.getString("pwd");
				String email=rs.getString("email");
				String content=rs.getString("content");
				Timestamp regdate=rs.getTimestamp("regdate");
				int readcount=rs.getInt("readcount");
				
				int groupno=rs.getInt("groupNo");
				int step=rs.getInt("step");
				int sortno=rs.getInt("sortNo");
				String delFlag=rs.getString("delflag");
				
				String fileName=rs.getString("fileName");
				String originalFileName=rs.getString("originalFileName");
				int downcount=rs.getInt("downcount");
				long fileSize=rs.getInt("fileSize");
				
				vo.setContent(content);
				vo.setEmail(email);
				vo.setName(name);
				vo.setNo(no);
				vo.setPwd(pwd);
				vo.setReadcount(readcount);
				vo.setRegdate(regdate);
				vo.setTitle(title);
				
				vo.setGroupNo(groupno);
				vo.setStep(step);
				vo.setSortNo(sortno);
				vo.setDelFlag(delFlag);
				
				vo.setFileName(fileName);
				vo.setFileSize(fileSize);
				vo.setOriginalFileName(originalFileName);
				vo.setDownCount(downcount);
			}
			
			System.out.println("글 상세보기 결과, vo="+vo+", 매개변수no="+no);
			
			return vo;
		}finally{
			pool.returnConnection(con);
		}
	}
	
	/**
	 * 글 수정
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int updateReBoard(ReBoardVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="update reBoard";
			sql += " set name=?,title=?,email=?,content=?";
			
			if(vo.getFileName() != null && !vo.getFileName().isEmpty()) {
				sql +=",filename=?,filesize=?,ORIGINALFILENAME=?";
			}
			
			sql += " where no=?";
			
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getEmail());
			ps.setString(4, vo.getContent());
			
			//파일이 새로 첨부된 경우
			if(vo.getFileName() != null && !vo.getFileName().isEmpty()) {
				ps.setString(5, vo.getFileName());
				ps.setLong(6, vo.getFileSize());
				ps.setString(7, vo.getOriginalFileName());
				ps.setInt(8, vo.getNo());
			}else { //첨부되지 않은 경우
				ps.setInt(5, vo.getNo());
			}
			
			
			int cnt=ps.executeUpdate();
			System.out.println("글 수정 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.returnConnection(con);
		}
	}
	
	public int updateReadCount(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="update reBoard" + 
					" set readcount=readcount+1" + 
					" where no=?";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, no);
			
			int cnt=ps.executeUpdate();
			System.out.println("조회수 증가 결과, cnt="+cnt+", 매개변수 no="+no);
			
			return cnt;
		}finally {
			pool.returnConnection(con);
		}
	}
	
	
	public void deleteReBoard(ReBoardVO vo) throws SQLException {
		Connection con=null;
		CallableStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="call deleteReboard(?,?,?)";
			ps=con.prepareCall(sql);
			
			ps.setInt(1, vo.getNo());
			ps.setInt(2, vo.getStep());
			ps.setInt(3, vo.getGroupNo());
			
			ps.executeUpdate();
			System.out.println("글 삭제  매개변수 vo="+vo);			
		}finally {
			pool.returnConnection(con);
		}
	}
	
	public boolean checkPwd(int no, String pwd) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select pwd from reboard where no=?";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, no);
			
			//4
			rs=ps.executeQuery();
			boolean result=false;
			if(rs.next()) {
				String dbPwd=rs.getString(1);
				
				if(dbPwd.equals(pwd)) {
					result=true;  //비밀번호 일치
				}
			}
			
			System.out.println("비밀번호 체크 결과, result="+result
				+", 매개변수 no="+no+", pwd="+pwd);
			
			return result;
		}finally {
			pool.returnConnection(con);
		}
	}
	
	public int reply(ReBoardVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		int cnt=0;
		try {
			//1,2 con
			con=pool.getConnection();
			
			//transaction 시작
			con.setAutoCommit(false); //자동 커밋 안되도록 설정
			
			//3. ps
			//[1] update
			String sql="update reboard" + 
					" set sortno=sortno+1" + 
					" where groupno=? and sortno>?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, vo.getGroupNo());
			ps.setInt(2, vo.getSortNo());
			
			//4. exec
			cnt=ps.executeUpdate();
			
			//[2] insert
			sql="insert into reboard(no, name, pwd, title, email, "
					+ " content,groupno, step, sortno)" + 
					" values(reboard_seq.nextval,?,?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getContent());
			ps.setInt(6, vo.getGroupNo());
			ps.setInt(7, vo.getStep()+1);
			ps.setInt(8, vo.getSortNo()+1);
			
			cnt=ps.executeUpdate();
			System.out.println("답변하기 결과, cnt="+cnt
				+", 매개변수 vo="+vo);
			
			//모두 성공하면 커밋
			con.commit();
		}catch(SQLException e) {
			//하나라도 실패하면 롤백
			con.rollback();
			e.printStackTrace();
		}finally {
			//다시 자동 커밋되도록 설정
			con.setAutoCommit(true);
			
			pool.returnConnection(con);
		}
		
		return cnt;
	}
	
	public int updateDownCount(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "update reboard" + 
					" set downcount = downcount + 1" + 
					" where no = ?";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, no);
			
			int cnt = ps.executeUpdate();
			
			System.out.println("다운로드 수 증가 cnt=" + cnt + ", 매개변수 no="+no);
			return cnt;
			
		} finally {
			pool.returnConnection(con);
		}
	}
	
}





