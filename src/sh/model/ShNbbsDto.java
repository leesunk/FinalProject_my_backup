package sh.model;

import java.io.Serializable;

/*
DROP TABLE SH_NBBS			//공지사항 게시판(SH_NBBS)
CASCADE CONSTRAINTS;			

DROP SEQUENCE SH_NBBS_SEQ;

CREATE TABLE SH_NBBS(			
	SEQ NUMBER(8) PRIMARY KEY,
	ID VARCHAR2(10) NOT NULL,
	
    TITLE VARCHAR2(100) NOT NULL,
	CONTENT VARCHAR2(400) NOT NULL,
    READCOUNT NUMBER(8) NOT NULL,
    WDATE DATE NOT NULL,
	
	DEL NUMBER(1) NOT NULL
);

CREATE SEQUENCE SH_NBBS_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE SH_NBBS
ADD CONSTRAINT SH_NBBS_FK FOREIGN KEY(ID)
REFERENCES SH_MEMBER(ID);	
*/

public class ShNbbsDto implements Serializable {

	private int seq;
	private String id;
	
	private String title;
	private String content;
	private int readcount;
	private String wdate;
	
	private int del;

	public ShNbbsDto() {
	}
	
	public ShNbbsDto(int seq, String id, String title, String content, int readcount, String wdate, int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.wdate = wdate;
		this.del = del;
	}

	public ShNbbsDto(String title, String content, String filename) {
		super();
		this.title = title;
		this.content = content;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	@Override
	public String toString() {
		return "ShNbbsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", readcount="
				+ readcount + ", wdate=" + wdate + ", del=" + del + "]";
	}

}
