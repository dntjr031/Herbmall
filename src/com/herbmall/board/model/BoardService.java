package com.herbmall.board.model;

import java.sql.SQLException;
import java.util.List;

public class BoardService {
	private BoardDAO dao = null;
	
	public BoardService(){
		dao = new BoardDAO();
	}
	
	public List<BoardVo> selectNotice() throws SQLException {
		return dao.selectNotice();
	}
}
