package com.herbmall.member.model;

import java.sql.SQLException;

//db작업 이외의 비즈니스 로직을 처리하는 클래스
// jsp => DAO
// jsp => Service => DAO
public class MemberService {
	//아이디 중복확인 관련 상수
	public static final int EXIST_ID = 1; //해당 아이디가 이미 존재하는 경우
	public static final int NON_EXIST_ID = 2; //아이디가 존재하지 않는 경우
	
	private MemberDAO memberDao;
	
	public MemberService() {
		memberDao = new MemberDAO();
	}
	
	public int insertMember(MemberVO vo) throws SQLException {
		int cnt = memberDao.insertMember(vo);
		return cnt;
	}
	
	public int duplicateId(String userid) throws SQLException {
		int cnt = memberDao.duplicateId(userid);
		return cnt;
	}
}