package com.herbmall.comment.model;

import java.sql.Timestamp;

public class CommentVO {
	private int no;
	private String name;
	private String pwd;
	private Timestamp regdate;
	private String content;
	private int bdno;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getBdno() {
		return bdno;
	}
	public void setBdno(int bdno) {
		this.bdno = bdno;
	}
	public CommentVO(int no, String name, String pwd, Timestamp regdate, String content, int bdno) {
		super();
		this.no = no;
		this.name = name;
		this.pwd = pwd;
		this.regdate = regdate;
		this.content = content;
		this.bdno = bdno;
	}
	public CommentVO() {
		super();
	}
	@Override
	public String toString() {
		return "CommentVO [no=" + no + ", name=" + name + ", pwd=" + pwd + ", regdate=" + regdate + ", content="
				+ content + ", bdno=" + bdno + "]";
	}
	
	
}

