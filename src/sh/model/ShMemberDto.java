package sh.model;

import java.io.Serializable;

/*
 
DROP TABLE SH_MEMBER
CASCADE CONSTRAINTS;

CREATE TABLE SH_MEMBER(				
	ID VARCHAR2(50) PRIMARY KEY,
	PWD VARCHAR2(50) NOT NULL,
	NAME VARCHAR2(50) NOT NULL,
	GENDER VARCHAR2(10) NOT NULL,
	RDATE VARCHAR2(50) NOT NULL,	
	EMAIL VARCHAR2(50) UNIQUE,	
	PNUM VARCHAR2(50) NOT NULL,	
	AUTH NUMBER(1) NOT NULL		
);
INSERT INTO SH_MEMBER(ID, PWD, NAME, GENDER, RDATE, EMAIL, PNUM, AUTH)
VALUES('admin','admin', 'name', 'M', '20190502', 'admin@soho.com', '01012345678', 1);
*/

public class ShMemberDto implements Serializable {
	
	private String id;
	private String pwd;
	private String name;
	private String gender;
	private String rdate;
	private String email;
	private String pnum;
	private int auth;		// 사용자(3)/관리자(1)
	private int del;
	
	public ShMemberDto() {
	}
	

	public ShMemberDto(String id, String pwd, String name, String gender, String rdate, String email, String pnum,
			int auth, int del) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.gender = gender;
		this.rdate = rdate;
		this.email = email;
		this.pnum = pnum;
		this.auth = auth;
		this.del = del;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getPwd() {
		return pwd;
	}


	public void setPwd(String pwd) {
		this.pwd = pwd;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getRdate() {
		return rdate;
	}


	public void setRdate(String rdate) {
		this.rdate = rdate;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPnum() {
		return pnum;
	}


	public void setPnum(String pnum) {
		this.pnum = pnum;
	}


	public int getAuth() {
		return auth;
	}


	public void setAuth(int auth) {
		this.auth = auth;
	}
	
	
	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}


	@Override
	public String toString() {
		return "ShMemberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", gender=" + gender + ", rdate=" + rdate
				+ ", email=" + email + ", pnum=" + pnum + ", auth=" + auth + ", del=" + del + "]";
	}
	
}
