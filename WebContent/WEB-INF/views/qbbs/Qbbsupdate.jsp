<%@page import="sh.model.ShMemberDto"%>
<%@page import="sh.model.ShQbbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Qbbsupdate</title>
<style type="text/css">
@import url ("/css/table.css");

.list_table {
	width: 1000px;
}

.list_table th {

}

.list_table td {
	text-align: left;
	padding-left: 20px;
	border-right: 1px solid #efefef;
}

.list_table textarea {
	resize: none;
}
</style>

<!--  	
.center{
	margin: auto;
	width: 60%;
	border: 3px solid #8AC007;
	padding: 10px;
}
input {
	size: 50;
}
 -->

</head>
<body>
<!-- 
<a href="logout.jsp">로그아웃</a>

<h1>글 수정</h1> -->

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

ShQbbsDto qbbs = (ShQbbsDto)request.getAttribute("Qbbs");
%>

<%
Object ologin = session.getAttribute("login");
ShMemberDto mem = null;
mem = (ShMemberDto)ologin;
%>

<div class="list_table">
	
<form action="QbbsupdateAf.do" method="post">
<input type="hidden" name="seq" value="<%=seq %>">
				
<table border="1">
	<col width="100"><col width="500"> 
		
	<tr>
		<td>아이디</td>
		<td>
			<input type="text" name="id" readonly="readonly" size="50" 
				value="<%=mem.getId() %>"> 		
		</td>	
	</tr>
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="title" size="50" 
				value="<%=qbbs.getTitle() %>">		
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea rows="10" cols="50" name="content"><%=qbbs.getContent() %></textarea>		
			</td>
		</tr>
		<tr>
			<td align="left" style="padding-left: 10px">
				<button type="button" name="backBtn" id="_backBtn" value="back"
						class="btn btn-default btn-block" onclick="location.href='nbbslist.do'">목록 보기</button>
			</td>
			<td>
				<input type="submit" value="글수정">
			</td>
		</tr>
		
	</table>
	
	</form>

</div>

</body>
</html>