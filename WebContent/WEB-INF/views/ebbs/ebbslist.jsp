<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<jsp:useBean id="ubbs" class="sh.util.PdsArrow"/>
<!-- <div align="center">
	공지사항
	<img alt="" src="image/ebbsm.png" border="0"  width="30%">
		
</div> -->
<div>
<!-- <table>

<tr>
<td>
<img alt="" src="image/coupon1.png" border="0"  style="width: 100%;">
</td>
<td>
<img alt="" src="image/coupon2.png" border="0"  style="width: 100%;">
</td>
</tr>
</table> -->
</div>
<table class="list_table" style="width: 1000px">

<tbody>

<%-- 
<c:if test="${empty Ebbslist }">
	<tr>
		<td colspan="3">업로드 된 파일이 없습니다</td> 
	</tr>	
</c:if> 
--%>

<tr>
	<td colspan="3"><b>아래의 쿠폰을 다운받으세요</b></td> 
</tr>


<tr style="width: 1000px">
	<td>
		<a href="image/coupon1.png">
			<img alt="" src="image/coupon1.png" border="0" style="width: 100%;">
		</a>
	</td>
	<td>
		<img alt="" src="image/coupon2.png" border="0" style="width: 100%;">
	</td>
</tr>


<c:forEach items="${Ebbslist }" var="Ebbs" varStatus="EbbsS">
<tr class="_hover_tr">

	<td align="center">
		<input type="button" class="ebbsbutton" name="btnDown" value="${Ebbs.title }" 
			onclick="filedowns('${Ebbs.filename}', '${Ebbs.seq }')">
	</td>

</tr>
</c:forEach>
</tbody>
</table>
<c:if test="${login.auth eq '1' }">
<!-- 추가 버튼 -->
<div id="buttons.wrap">
	<span class="button blue">
		<button type="button" id="_btnAdd">이벤트 등록</button>
	</span>
</div>
</c:if>
<c:if test="${login.auth eq '3' }">
</c:if>
<!-- 다운로드 버튼 클릭시 (get 절대안됨 무조건 post)-->
<form name="file_Down" action="EfileDownload.do" method="post">
	<input type="hidden" name="filename">
	<input type="hidden" name="seq">

</form>
<br><br><br><br><br><br>

<script type="text/javascript">
$("#_btnAdd").click(function () {
	location.href = "Ebbswrite.do";
});

function filedowns(filename, seq){
	var doc = document.file_Down;
	doc.filename.value = filename;
	doc.seq.value = seq;
	doc.submit();
	
	/* location.href = "flieDownload.do?" <get방식> */
			
$("<a>")
	.attr("href", "image/coupon1.png")
	.attr("download", "image/coupon1.png")
	.appendTo("body")
	.click()
	.remove();
}
</script>

<!-- <script type="text/javascript">
var a = document.createElement("a");
a.style = "display: none";
a.href = img.src;
a.download = ""
</script> -->
