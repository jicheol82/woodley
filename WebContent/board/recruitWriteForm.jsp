<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/custom.css">

<meta charset="UTF-8">
<title>모집글 쓰기</title>
<%	// 아무 내용도 안넣을 경우의 유효성 검사 필요 %>
<script>
	function check(){
		var input = document.writeForm;
		if(input.bulletPoint.value==""){
			alert("말머리를 선택하여 주세요.");
			return false;
		}
		if(input.title.value==""){
			alert("제목을 입력하여 주세요.");
			return false;
		}
		
	}
</script>
</head>
<%	
	String pageNum = request.getParameter("pageNum");
	// url 접근 방지
	String referer = request.getHeader("referer");
	if(referer == null){
%>
		<script>
			alert("비정상적인 접근입니다.");
			history.go(-1);
		</script>
<%	
	}
%>
<body>
	<jsp:include page="../main/main.jsp"/>
	<br /><br />
	<div class="container">
		<form action="../board/recruitBoardWritePro.jsp" method="post" name="writeForm" enctype="multipart/form-data" onsubmit="return check()">
		
			<input type="hidden" name="pageNum" value="<%=pageNum%>" />
		
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2"><h4>모집게시판 글쓰기</h4></th>
					</tr>
				</thead>
				<tr>
					<td style="width: 110px;"><h5>제목</h5></td>
					<td><input class="form-control" type="text" name="title" ></td>
				<tr>	
					<td style="width: 110px;"><h5>모집유형</h5></td>
					<td align="left"> 
						<select class="form-control" name="bulletPoint">
							<option value="">말머리선택</option>
							<option value="[용병구함]">[용병구함]</option>
							<option value="[선수구함]">[선수구함]</option>
							<option value="[팀구함]">[팀구함]</option>
						</select>
					</td>	
				</tr>
				<tr>
					<td style="width: 110px;"><h5>사진</h5></td>
					<td><input class="form-control" type="file" name="img" ></td>
				</tr>
				<tr>
					<td> 내   용 </td>
					<td> <textarea id="content" style="width: 100%;" rows="25" name = "content"></textarea> </td>
				</tr>
				<tr>
					<td colspan="2">
						<input id="savebutton" class="btn btn-primary" type="submit" value="확인"/> 
						<input class="btn btn-primary" type="button" value="취소" onclick="location='../board/recruitBoard.jsp?event=football&category=comboard&pageNum=<%=pageNum%>'"/>
					</td>
				</tr>
			</table>
		</form>
	</div>		
</body>
</html>
<script type="text/javascript">

	$(document).ready(function() { var oEditors = []; // 개발되어 있는 소스에 맞추느라, 전역변수로 사용하였지만, 지역변수로 사용해도 전혀 무관 함. 
		// Editor Setting 
		nhn.husky.EZCreator.createInIFrame({ 
			oAppRef : oEditors, // 전역변수 명과 동일해야 함. 
			elPlaceHolder : "content", // 에디터가 그려질 textarea ID 값과 동일 해야 함. 
			sSkinURI : "../se2/SmartEditor2Skin.html", // Editor HTML 
			fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X 
			htParams : { // 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseVerticalResizer : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseModeChanger : true, 
			} 
		}); 
	
	// 전송버튼 클릭이벤트 
	$("#savebutton").click(function(){ 
		//if(confirm("저장하시겠습니까?")) { // id가 smarteditor인 textarea에 에디터에서 대입 
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 
		
		// 이부분에 에디터 validation 검증 
		if(validation()) { 
			$("#frm").submit(); 
		} 
		//} 
		}) 
	}); 
	// 필수값 Check 
	function validation(){
		var contents = $.trim(oEditors[0].getContents()); 
		if(contents === '<p>&bnsp;</p>' || contents === ''){ // 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
			alert("내용을 입력하세요.!!!"); oEditors.getById['content'].exec('FOCUS'); 
			return false; 
		} 
		
		return true; 
}

</script>