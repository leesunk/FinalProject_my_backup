<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>regi</title>

<!-- datepicker -->
<link rel="stylesheet"  href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

</head>
<body>
	<div class="modal-dialog">

		<div style="margin-top: 12px" align="center">
		<!-- 홈페이지 로고 -->
		<img alt="" src="image/nlogo_w.png" border="0" id="logo" width="300px">
		
		</div>
		<!-- Modal content-->
		<div class="modal-content">

			<div class="modal-header" style="padding: 35px 50px;">
				<h4>회원가입</h4>
				<label>소호 회원이 아니신가요? 회원가입 해주세요!</label>
			</div>
			<div class="modal-body" style="padding: 40px 50px;">
				<!-- <form role="form" method="post" action="j_spring_security_check"> -->
				<form action="" id="_frmForm" name="frmForm" method="post">
					<input type="text" name="sid" id="_id"  class="form-control" placeholder="사용할 아이디를 입력하세요"><br>
							<input type="button" class="btn btn-default btn-block" id="_btnGetId" value="아이디 체크">
					<br>
					<div id="_rgetid"></div>
					<div class="form-group">	
						<label for="id"> 아이디 :</label> <input type="text" data-msg="아이디를"
							class="form-control" name="id" id="_userid" placeholder="" readonly="readonly"
							required="required">
					</div>
					
					<div class="form-group">
						<label for="pw"> 비밀번호 :</label> <input type="password" data-msg="비밀번호를"
							class="form-control" id="_pwd" name="pwd" 
							placeholder="" required="required">
					</div>
					
					<div class="form-group">
						<label for="pw"> 이름 :</label> <input type="text" data-msg="이름을"
							class="form-control" id="_name" name="name" 
							placeholder="" required="required">
					</div>
					
					<div class="form-group">
						<label for="pw">성별</label>&nbsp;&nbsp;&nbsp;
							<input type="radio" name="gender" id="_gender" size="50" value="남자" required="required" data-msg="성별을">  남자&nbsp;&nbsp;&nbsp;
      						<input type="radio" name="gender" id="_gender" size="50" value="여자" required="required" data-msg="성별을">  여자
					</div>
					
					<div class="form-group">
						<label for="pw"> 생년월일 :</label> <input type="text" data-msg="생년월일을"
							class="form-control" id="_rdate" name="rdate" 
							placeholder="ex) 20190101" required="required">
					</div>
					<div class="form-group">
						<label for="pw"> 이메일 :</label> <input type="text" data-msg="E-mail을"
							class="form-control" id="_email" name="email" 
							placeholder="" required="required">
					</div>
					<div class="form-group">
						<label for="pw"> 연락처 :</label> <input type="text" data-msg="연락처를"
							class="form-control" id="_pnum" name="pnum" 
							placeholder="'-' 없이 입력해 주십시오" required="required">
					</div>
					<br>
					<button type="submit" class="btn btn-default btn-block" id="_btnRegi">
						회원가입</button>
					
					
				</form>		
				
			</div>
			<div class="modal-footer"></div>
		</div>

	</div>

<script type="text/javascript">

$("#_btnRegi").click(function() {
	if($("#_userid").val() == ""){
		alert("아이디를 입력해 주십시오" );
		$("#_userid").focus();
	} 
	
	else if($("#_pwd").val() == ""){
		alert($("#_pwd").attr("data-msg") + " 입력해 주십시오" );
		$("#_pwd").focus();
	}
	else if($("#_name").val() == ""){
		alert($("#_name").attr("data-msg") + " 입력해 주십시오" );
		$("#_name").focus();
	}
 	else if($("#_gender").val() == ""){
		alert($("#_gender").attr("data-msg") + " 입력해 주십시오" );
		$("#_gender").focus();
	
    }
	else if($("#_rdate").val() == ""){
		alert($("#_rdate").attr("data-msg") + " 입력해 주십시오" );
		$("#_rdate").focus();
	}
	else if($("#_email").val() == ""){
		alert($("#_email").attr("data-msg") + " 입력해 주십시오" );
		$("#_email").focus();
	}
	else if($("#_pnum").val() == ""){
		alert($("#_pnum").attr("data-msg") + " 입력해 주십시오" );
		$("#_pnum").focus();
	}
	else{
		alert("회원가입이 완료되었습니다. 로그인 해주십시오" );
		$("#_frmForm").attr("action", "regiAf.do").submit();
	}	
});

$("#_btnGetId").click(function () {
//	alert("click");
	
	// id확인용 ajax	
	// 메시지 #_rgetid
	
	// _id 값	-> _userid 값
	
	$.ajax({
		type:"post",
		url:"getId.do",		
		data:{ id:$("#_id").val() },
		async:true,
		success:function(msg){		
			if(msg == 'YES'){
				$("#_rgetid").html("<b>사용중이거나 사용할 수 없는 아이디입니다</b><br><br>");	
				$("#_rgetid").css("color", "#ff0000");
				$("#_userid").val("");
			}else{
				$("#_rgetid").html("이 아이디는 사용할 수 있습니다<br><br>");
				$("#_rgetid").css("color", "#0000ff");
				
				$("#_userid").val( $("#_id").val() );
			}		
		},
		error:function(){
			alert("error");	
		}		
	});
	
});

$(function() {
	   $("#_rdate").datepicker(
	         {
	            dateFormat : "yymmdd",
	            prevText : '이전 달',
	            nextText : '다음 달',
	            dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	            monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월",
	                  "7월", "8월", "9월", "10월", "11월", "12월" ],
	            monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월",
	                  "7월", "8월", "9월", "10월", "11월", "12월" ],
	            showMonthAfterYear : true,
	            changeMonth : true,
	            changeYear : true,
	            yearRange : "1919:2019"
	         });
	});
</script>




</body>
</html>





