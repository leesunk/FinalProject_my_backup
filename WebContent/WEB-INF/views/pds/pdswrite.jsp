<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 코어 테그 사용 -->    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>    
    

<form name="frmForm" id="_frmForm" action="pdsupload.do" method="post" enctype="multipart/form-data">

<table class="list_table">

<tr>
	<th>아이디</th>
	<td style="text-align: left;">
		<input type="text" name="id" readonly="readonly" value="${login.id }" size="50">	
	</td>
</tr>

<tr>
	<th>제목</th>
	<td style="text-align: left;">
		<input type="text" name="title" size="50">
	</td>
</tr>

<tr>
	<th>파일 업로드</th>
	<td style="text-align: left;">
		<input type="file" name="fileload" style="width: 400px">
	</td>
</tr>

<tr>
	<th>내용</th>
	<td style="text-align: left;">
		<textarea rows="10" cols="50" name="content"></textarea>
	</td>
</tr>

<tr>
	<td colspan="2" style="height: 50px; text-align: center;">
<!-- 		<a href="pdswriteAf.do" id="_btnPds" title="자료올리기">
			<img alt="" src="image/bwrite.png">
		</a> -->
		<input type="submit" value="자료 올리기" onclick="location.href='pdswriteAf.do'">
	</td>
</tr>



</table>

</form>

<script type="text/javascript">		//자료를 클릭하면 폼이 올라간다고 생각하면 될까?
$("#_btnPds").click(function () {
	$("#_frmForm").submit();
});



</script>


