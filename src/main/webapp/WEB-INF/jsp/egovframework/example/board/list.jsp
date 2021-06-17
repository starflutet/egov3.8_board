<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>준현이 연습장</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/css/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
$( document ).ready(function() {
	<c:if test="${!empty msg}">
		alert("${msg}");
	</c:if>
});

function add(){
	location.href = "<c:url value='/mgmt.do'/>";
}
function view(idx){
	location.href = "<c:url value='/view.do'/>?idx="+idx;
}
function setPwd(user_id){
	if( user_id == "admin" ){
		$('#password').val('manager');
	}else if( user_id == "guest" ){
		$('#password').val('guest');
	}else if( user_id == "guest2" ){
		$('#password').val('guest2');
	}
}
function check(){
	//alert('1');
	if( $('#user_id').val() == '' ){
		alert("아이디를 입력하세요");
		return false;
	}
	if( $('#password').val() == '' ){
		alert("비밀번호를 입력하세요");
		return false;
	}
	return true;
}
function out(){
	location.href = "<c:url value='/logout.do'/>";
}
function page(pageNo){
	location.href = "<c:url value='/list.do'/>?pageIndex="+pageNo;
}
</script>
</head>
<body>
<div class="container">
  <h1>준현이 전자정부 연습장</h1>
<pre>
**현재 연습한것**
디비 CRUD연습(게시판)
검색 연습
전자정부 전용 페이징 연습 
첨부파일 올리기 내려받기 연습
css는 부트스트랩 사용중
</pre>
<pre>
**앞으로 해볼거**
공장마냥 2시간에 하나는 찍어낼수있도록 연습해야함(게시판 기본 기능들)
디비 커넥션풀 적용
로그인체크 인터셉터 적용
애니메이션 공부 및 적용
Vue.js적용
PWA(반응형 웹 상위호완)연습 13일까지
https://www.inflearn.com/course/pwa# 이거 결제해야함
pre태그 엔터키 알아서 적용해주니 생각보다 편하네
뭔가 가면갈수록 프론트쪽으로 공부하게되네 이상하다..
</pre>
  <div class="panel panel-default">
    <div class="panel-heading">
    <c:if test="${sessionScope == null || sessionScope.userId == null || sessionScope.userId == '' }">
      <form class="form-inline" method="post" action="<c:url value='/login.do'/>">
	  <div class="form-group">
	     <label for="user_id">ID:</label>
	     <select class="form-control" id="user_id" name="user_id" onchange="setPwd(this.value);">
	     	<option value="">선택하세요</option>
		    <option value="admin">관리자</option>
		    <option value="guest">사용자</option>
		    <option value="guest2">사용자2</option>
		 </select>
	  </div>
	  <div class="form-group">
	    <label for="password">Password:</label>
	    <input type="password" class="form-control" id="password" name="password">
	  </div>
	  <button type="submit" class="btn btn-default" onclick="return check()">로그인</button>
	  </form>
	</c:if>
	<c:if test="${sessionScope != null && sessionScope.userId != null && sessionScope.userId != '' }">
	  ${sessionScope.userName}님 환영합니다.
	  <button type="button" class="btn btn-default" onclick="out();">로그아웃</button>
	</c:if>
    </div>
    <div class="panel-body">
      <form class="form-inline" method="post" action="<c:url value='/list.do'/>">
	  <div class="form-group">
	     <label for="searchKeyword">제목(내용):</label>
	     <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${searchKeyword }">
	  </div>
	  	<button type="submit" class="btn btn-default">검색</button>
	  </form>
	  <br>
	  <div>
	  <label>전체 게시글 수 : <span class="badge"> ${paginationInfo.totalRecordCount}</span></label>
	  </div>
      <div class="table-responsive">
	  <table class="table table-hover">
	    <thead>
	      <tr>
	        <th>게시물번호</th>
	        <th>제목</th>
	        <th>조회수</th>
	        <th>댓글수</th>
	        <th>파일</th>
	        <th>등록자</th>
	        <th>등록일</th>
	      </tr>
	    </thead>
	    <tbody>
	    <c:forEach var="result" items="${resultList}" varStatus="status">
	      <tr>
	        <td><a href="javascript:view('${result.idx}');"><c:out value="${result.idx}"/></a></td>
	        <td><a href="javascript:view('${result.idx}');"><c:out value="${result.title}"/></a></td>
	        <td><c:out value="${result.count}"/></td>
	        <td><c:out value="${result.reply}"/></td>
	        <td>
	        	<c:if test="${result.filename != null && result.filename != ''}">
	        	<span class="glyphicon glyphicon-file"></span>
	        	</c:if>
	        </td>
	        <td><c:out value="${result.writerNm}"/></td>
	        <%-- <td><c:out value="${result.indate}"/></td> --%>
	        <td><fmt:formatDate value="${result.indate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	      </tr>
	    </c:forEach>
	    </tbody>
	  </table>
	  </div>
	  <div id="paging">
		  <ul class="pagination">
	      	<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="page" />
	      </ul>
      	<%-- <form:hidden path="pageIndex" /> --%>
      </div>
    </div>
    <div class="panel-footer">
    <c:if test="${!empty sessionScope.userId }">
      <button type="button" class="btn btn-default" onclick="add();">등록</button>
    </c:if>
    </div>
  </div>
</div>

</body>
</html>