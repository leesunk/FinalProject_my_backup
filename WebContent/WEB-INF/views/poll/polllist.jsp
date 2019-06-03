
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sh.util.DateUtil"%>
<%@page import="sh.model.ShPollDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 코어 테그나 el테그 3줄 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
    
<!-- 짐 푸는 곳 -->
<%
List<ShPollDto> plists = (List<ShPollDto>)request.getAttribute("plists");

SimpleDateFormat test = new SimpleDateFormat("yyyy-MM-dd");		//
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
@import url("/css/table.css");

.list_table {
	margin-bottom: 50px;
	width: 1000px;
	float: center;
}

.list_table th {

}

.list_table td {
	text-align: center;
	margin-left: 20px;
	background-color: #ffffff;
}

#_makeBtn {
	width: 200px;
	margin-left: 200px;
	margin-right: 200px;
	padding-left: 200px;
	padding-right: 200px;	
}
</style>

</head>
<body>

<!-- 관리자 -->
<c:if test="${login.auth eq '1' }">

<table class="list_table" style="width: 1000px">
<colgroup>	
<col width="50"><col width="50"><col width="300">
<col width="100"><col width="100"><col width="75">
<col width="75"><col width="100">
</colgroup>

<tr>
	<th>번호</th><th>아이디</th><th>질문</th>
	<th>시작일</th><th>종료일</th><th>질문항수</th>
	<th>투표수</th><th>등록일</th>
</tr>

 
	<c:if test="${empty polllist }">
	<tr>
		<td colspan="8">등록된 투표가 없습니다</td> 
	</tr>	
	</c:if> 

<%
	ShPollDto poll = null;
	for(int i = 0;i < plists.size(); i++){		//for문
		poll = plists.get(i);												//
		java.sql.Date sqlSDate = poll.getSdate();							//
		java.util.Date utilSDate = new java.util.Date(sqlSDate.getTime());	//
		java.sql.Date sqlEDate = poll.getEdate();							//
		java.util.Date utilEDate = new java.util.Date(sqlEDate.getTime());	//
		%>
		<tr bgcolor="#aabbcc">	
			<td><%=i+1 %></td>
			<td><%=poll.getId() %></td>
			<td>
				<a href="polldetail.do?pollid=<%=poll.getPollid() %>"><%=poll.getQuestion() %></a>
			</td>
			<%-- <td><%=poll.getSdate() %></td>
			<td><%=poll.getEdate() %></td> --%>
			<td><%=test.format(utilSDate) %></td>	<%-- --%>
			<td><%=test.format(utilEDate) %></td>	<%-- --%>
			<td><%=poll.getItemcount() %></td>
			<td><%=poll.getPolltotal() %></td>
			<td><%=poll.getWdate() %></td>
		</tr>
		<%
	}
%>
		<tr>
			<td colspan="8" align="center" 
				style="float: center; border-left: none; 
				border-right: none; border-bottom: none;">
			<c:if test="${login.auth eq '1' }">
				<button type="button" class="btn btn-default btn-block"
						id="_makeBtn" onclick="location.href='pollmake.do'">투표 만들기</button>
			</c:if>
			</td>
		</tr>

</table>

</c:if>

<!-- 사용자 -->
<c:if test="${login.auth eq '3' }">

<table class="list_table">	<!-- 관리자 따로 코어태그 필요할듯  -->
<colgroup>
<col width="50"><col width="50"><col width="260"><col width="40">
<col width="100"><col width="100"><col width="75">
<col width="75"><col width="100">
</colgroup>

<tr>
	<th>번호</th><th>아이디</th><th>질문</th><th>결과</th>
	<th>시작일</th><th>종료일</th><th>질문항수</th>
	<th>투표수</th><th>등록일</th>
</tr>

<%-- 
	<c:if test="${empty polllist }">
	<tr>
		<td colspan="8">작성된 투표가 없습니다</td> 
	</tr>	
	</c:if> 
--%> <!-- 강사님께 물어봅시다 -->

<%
	for(int i = 0;i < plists.size(); i++){		//for문
		ShPollDto poll = plists.get(i);
		%>
		<tr bgcolor="#aabbcc">	
			<td><%=i+1 %></td>
			<td><%=poll.getId() %></td>
			<%
			boolean isS = poll.isVote();
			if(isS || DateUtil.isEnd(poll.getEdate())){
			//투표했음	투표기한이 끝났음	
				%>
				<td>[마감]<%=poll.getQuestion()%></td>	
				<%
			}else{
			%>
			<td>
				<a href="polldetail.do?pollid=<%=poll.getPollid() %>">
					<%=poll.getQuestion() %>
				</a>
			</td>
			<%
			}
			%>
			
			<td>
			<%
			if(isS || DateUtil.isEnd(poll.getEdate())){		//결과 볼수 있음
				%>
				<a href="pollresult.do?pollid=<%=poll.getPollid() %>">결과</a>
			<%	
			} else {		//결과를 볼수 없음
			%>
			<img alt="" src="image/pen.gif">
			<%
			}
			%>		
			</td>
			
			<td><%=poll.getSdate() %></td>
			<td><%=poll.getEdate() %></td>
			<td><%=poll.getItemcount() %></td>
			<td><%=poll.getPolltotal() %></td>
			<td><%=poll.getWdate() %></td>
		</tr>	
		<%
	}
%>

</table>
</c:if>
<%-- <div style="float: center">
<table style="float: center">
<tr>
	<td>
	<c:if test="${login.auth eq '1' }">
		<button type="button" onclick="location.href='pollmake.do'">투표 만들기</button>
	</c:if>
	</td>
</tr>
</table>

</div> --%>


</body>
</html>