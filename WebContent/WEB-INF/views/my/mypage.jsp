<%@page import="java.awt.print.Book"%>
<%@page import="sh.model.ShBookingDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
.yetable {
	float: center;
}
.yetable th {
	text-align: center;
}
</style>
</head>
<body>
<%
	List<ShBookingDto> blist = (List<ShBookingDto>)(request.getAttribute("booking"));
	/* System.out.println("jsp print : " +blist); */
	ShBookingDto book = new ShBookingDto();	
	
%>



	<div class="modal-dialog">

		<div style="margin-top: 12px" align="center">
		<!-- 홈페이지 로고 -->
		<img alt="" src="image/nlogo_w.png" border="0" id="logo" width="300px">
		
		</div>
		<!-- Modal content-->
		<div class="modal-content">

			<div class="modal-header" style="padding: 35px 50px;">
				<h4>
					 My Page
				</h4>
				<label>${login.name }님 환영합니다!</label>
			</div>
			<div class="modal-body" style="padding: 40px 50px;">
				<form action="deleteMypage.do" id="_frmForm" name="frmForm" method="post">
					
					<div id="_rgetid"></div>
					<div class="form-group">	
						<label> 아이디 : ${login.id }</label>
					</div>
					
					<c:if test="${login.auth eq 3 }">
					<div class="form-group">
						<label> 이름 : ${login.name }</label>
					</div>
					
					<div class="form-group">
						<label> 성별 : ${login.gender }</label>
					</div>
					
					<div class="form-group">	
						<label> 생년월일 : ${login.rdate }</label>
					</div>
					</c:if>
					
					<div class="form-group">	
						<label> 이메일 : ${login.email }</label>
					</div>
					
					<div class="form-group">	
						<label> 연락처 : ${login.pnum }</label>
					</div>
					
					<c:if test="${login.auth eq 3 }">
					<div class="form-group">	
						<label> ${login.name }님 예약정보</label>
					</div>
					
					<div align="center" style="text-align: center">
					<table border="1" class="yetable">
					<col width="100"><col width="100"><col width="100">
					<col width="100"><col width="100"><col width="100">
					<col width="100">

							<%
								if (book.getChecknum() != 2) {
									if (book.getChecknum() != 2 && blist.size() != 0) {
										for (int i = 0; i < blist.size(); i++) {
							%>
							<tr align="center">
								<th align="center">객실이름</th>
								<th align="center">입실일</th>
								<th align="center">퇴실일</th>
								<th align="center">인원</th>
								<th align="center">금액</th>
								<th align="center">예약 취소</th>
								<th align="center">예약</th>
							</tr>
							<tr>
								<td><%=blist.get(i).getRoomname()%></td>
								<td><%=blist.get(i).getSdate()%></td>
								<td><%=blist.get(i).getEdate()%></td>
								<td><%=blist.get(i).getCountnum()%></td>
								<td><%=blist.get(i).getPrice()%></td>
								<td>
									<button type="button"
										onclick="location.href='BookCancel.do?seq='+ <%=blist.get(i).getSeq()%>"
										class="btn btn-default btn-block" style="width: 100%; height: 40px">취소</button>
								</td>
								<td><%=book.getChecknum()%></td>
							</tr>
							<%
								}
									} else {
							%><tr>
								<td>예약내용이 없습니다.</td>
							</tr>
							<%
								}
								}
							%>
						</table>
					</div>
					</c:if>
					
					<br><br>
					
					<%-- <button type="button" onclick="location.href='BookCancel.do?seq='+ <%=blist.get(0).getSeq()%>" class="btn btn-default btn-block" >
						예약 취소</button> --%>
					<button type="button" onclick="location.href='myup.do'"class="btn btn-default btn-block" >
						내 정보수정</button>
					<button type="button" onclick="location.href='pwdup.do'"class="btn btn-default btn-block" >
						비밀번호 변경</button>
					
					<c:if test="${login.auth eq 3 }">
					<button type="button" onclick="location.href='toDeletePage.do'"class="btn btn-default btn-block" >
						회원탈퇴</button>
					</c:if>

				</form>
			</div>
			<div class="modal-footer"></div>
		</div>

	</div>
</body>
</html>