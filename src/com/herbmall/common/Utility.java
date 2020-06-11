package com.herbmall.common;

import java.sql.Timestamp;

public class Utility {
	
	/*<!-- 답변글인 경우 re이미지 보여주기 -->*/
	public static String displayRe(int step) {
		String result = "";
		if(step >0){
			for(int j = 0; j < step; j++){
				result += "&nbsp";
			}
			result += "<img alt='답변 화살표' src='../images/re.gif'>";
			
		}
		
		return result;
	}
	
	/* <!-- 제목이 긴 경우 일부만 보여주기 --> */
	public static String cutString(String title, int legth) {
		if(title.length() > legth) {
			title = title.substring(0, legth) + "...";
		}
		return title;
	}
	
	public static String displayNew(Timestamp regdate, int setHour) {
		//24시간 이내의 글인 경우 new 이미지 보여주기
		
		long today = System.currentTimeMillis();
		long reg = regdate.getTime();		
		
		int hour = (int)((today - reg)/1000/60/60.0);
		
		String result = "";
		if(hour < setHour) {
			result += "<img alt=\"new 이미지\" src=\"../images/new.gif\">";
		}
		return result;
	}
}
