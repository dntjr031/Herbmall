package com.herbmall.zipcode.model;

import java.sql.SQLException;
import java.util.List;

public class ZipcodeService {

	private ZipcodeDAO dao = null;
	
	public ZipcodeService() {
		dao = new ZipcodeDAO();
	}
	
	public List<ZipcodeVO> searchByDong(String dong) throws SQLException {
		return dao.searchByDong(dong);
	}
}
