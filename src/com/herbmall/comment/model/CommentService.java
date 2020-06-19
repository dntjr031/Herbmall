package com.herbmall.comment.model;

import java.sql.SQLException;
import java.util.List;

public class CommentService {
	private CommentDAO dao;
	
	public CommentService() {
		dao = new CommentDAO();
	}

	public int insertComment(CommentVO vo) throws SQLException {
		return dao.insertComment(vo);
	}
	
	public List<CommentVO> selectAll(int bdno) throws SQLException {
		return dao.selectAll(bdno);
	}
	
	public int selectCount(int bdno) throws SQLException {
		return dao.selectCount(bdno);
	}
}
