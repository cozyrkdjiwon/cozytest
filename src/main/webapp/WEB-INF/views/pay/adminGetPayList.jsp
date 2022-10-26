<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(function(){
	let offset = 1;
	let maxPage = '${maxPage}';
	document.getElementsByClassName('numberPage')[0].style.backgroundColor = "#eee";
	let firstnumber = 1;
	for (let i = 0; i <5; i++){
		if(parseInt(document.getElementsByClassName('numberPage')[i].text) == offset){
			document.getElementsByClassName('numberPage')[i].style.backgroundColor = "#eee";
		}else{
			document.getElementsByClassName('numberPage')[i].style.backgroundColor = "#fff";
		}
		if(parseInt(document.getElementsByClassName('numberPage')[i].text) > maxPage){
			document.getElementsByClassName('numberPage')[i].style.color = "#ccc";
		}else{
			document.getElementsByClassName('numberPage')[i].style.color = "#444";
		}
	}
	
	$('#fisrtPage').click(function(){
		let offV;
		let search = $('#searchKeyword').val();
		if((firstnumber-5) < 1){
			offV = 1;
			firstnumber = 1;
		}else{
			offV = firstnumber-5;
			firstnumber = firstnumber-5;
		}
		$.ajax({
			url:"/pay/admin/list",
			type:"post",
			data:{"offset":offV, "searchKeyword":search},
			success:function(data){
				html = '<table class="table table-hover">';
				html += '<tr><th><input type="checkbox" id="totalCheck"/></th><th>주문번호</th><th>주문자 ID</th><th>수신자 정보</th><th>주문 상품 정보</th><th>배송지 정보</th><th>결제날짜</th><th>상태</th></tr>';
				$.each(data,function(key,value) {
					let state = '';
					if(value.state == 0){state = '결제 오류';}else if(value.state == 1){state = '배송 준비(결제 완료)';}else if(value.state == 2){state = '배송 중';}else if(value.state == 3){state = '배송 완료';}else if(value.state == 4){state = '환불 신청';}else if(value.state == 5){state = '환불 완료';}
					html += '<tr><td><input type="checkbox" name="check" class="check" value="'+value.merchant_uid+'"/></td><td><a href="/pay/admin/update/'+value.merchant_uid+'">'+value.merchant_uid+'</a></td><td>'+value.uid+'</td><td>이름 : '+value.uname+'<br/>전화번호 : '+value.uphone+'</td><td>상품 번호 : '+value.no+'<br/>상품명 : '+value.p_name+'<br/>수량 : '+value.qty+'<br/>상품 총 금액 : '+value.total+'</td><td>우편 번호 : '+value.postcode+'<br/>도로명 주소 : '+value.roadaddr+'<br/>지번 주소 : '+value.jibunaddr+'<br/>상세 주소 : '+value.detailaddr+'<br/>'+value.extraaddr+'</td><td>'+value.pay_date+'</td>';
					html += '<td>'+state+'</td></tr>';
				});
				html += '</table>';
				$("#ajaxDiv").html(html);
			}
		});
		for (let i = 0; i <5; i++){
			document.getElementsByClassName('numberPage')[i].text = offV + i;
			if(parseInt(document.getElementsByClassName('numberPage')[i].text) == offV){
				document.getElementsByClassName('numberPage')[i].style.backgroundColor = "#eee";
			}else{
				document.getElementsByClassName('numberPage')[i].style.backgroundColor = "#fff";
			}
			if(parseInt(document.getElementsByClassName('numberPage')[i].text) > maxPage){
				document.getElementsByClassName('numberPage')[i].style.color = "#eee";
			}else{
				document.getElementsByClassName('numberPage')[i].style.color = "#444";
			}
		}		
	});
	$('#lastPage').click(function(){
		let offV;
		let search = $('#searchKeyword').val();
		offV = firstnumber+5;
		if(offV > maxPage){
			return false;
		}

		$.ajax({
			url:"/pay/admin/list",
			type:"post",
			data:{"offset":offV, "searchKeyword":search},
			success:function(data){
				html = '<table class="table table-hover">';
				html += '<tr><th><input type="checkbox" id="totalCheck"/></th><th>주문번호</th><th>주문자 ID</th><th>수신자 정보</th><th>주문 상품 정보</th><th>배송지 정보</th><th>결제날짜</th><th>상태</th></tr>';
				$.each(data,function(key,value) {
					let state = '';
					if(value.state == 0){state = '결제 오류';}else if(value.state == 1){state = '배송 준비(결제 완료)';}else if(value.state == 2){state = '배송 중';}else if(value.state == 3){state = '배송 완료';}else if(value.state == 4){state = '환불 신청';}else if(value.state == 5){state = '환불 완료';}
					html += '<tr><td><input type="checkbox" name="check" class="check" value="'+value.merchant_uid+'"/></td><td><a href="/pay/admin/update/'+value.merchant_uid+'">'+value.merchant_uid+'</a></td><td>'+value.uid+'</td><td>이름 : '+value.uname+'<br/>전화번호 : '+value.uphone+'</td><td>상품 번호 : '+value.no+'<br/>상품명 : '+value.p_name+'<br/>수량 : '+value.qty+'<br/>상품 총 금액 : '+value.total+'</td><td>우편 번호 : '+value.postcode+'<br/>도로명 주소 : '+value.roadaddr+'<br/>지번 주소 : '+value.jibunaddr+'<br/>상세 주소 : '+value.detailaddr+'<br/>'+value.extraaddr+'</td><td>'+value.pay_date+'</td>';
					html += '<td>'+state+'</td></tr>';
				});
				html += '</table>';
				$("#ajaxDiv").html(html);
				firstnumber = firstnumber+5;
			}
		});
		for (let i = 0; i <5; i++){
			document.getElementsByClassName('numberPage')[i].text = offV + i;
			if(parseInt(document.getElementsByClassName('numberPage')[i].text) == offV){
				document.getElementsByClassName('numberPage')[i].style.backgroundColor = "#eee";
			}else{
				document.getElementsByClassName('numberPage')[i].style.backgroundColor = "#fff";
			}
			if(parseInt(document.getElementsByClassName('numberPage')[i].text) > maxPage){
				document.getElementsByClassName('numberPage')[i].style.color = "#eee";
			}else{
				document.getElementsByClassName('numberPage')[i].style.color = "#444";
			}
		}	
	});
		
	
	$(document).on('click', '#totalCheck', function(e) {
		if($('#totalCheck').prop("checked")==true){
			$('.check').prop("checked",true).change();
		}else{
			$('.check').prop("checked",false).change();
		}
	});
	
	$(document).on('click', '.check', function(e) {

	});
	
	
	$('.numberPage').click(function(){
		offset = parseInt(this.text);
		if(offset > maxPage){
			return false;
		}
		let search = $('#searchKeyword').val();
		$.ajax({
			url:"/pay/admin/list",
			type:"post",
			data:{"offset":offset, "searchKeyword":search},
			success:function(data){
				html = '<table class="table table-hover">';
				html += '<tr><th><input type="checkbox" id="totalCheck"/></th><th>주문번호</th><th>주문자 ID</th><th>수신자 정보</th><th>주문 상품 정보</th><th>배송지 정보</th><th>결제날짜</th><th>상태</th></tr>';
				$.each(data,function(key,value) {
					let state = '';
					if(value.state == 0){state = '결제 오류';}else if(value.state == 1){state = '배송 준비(결제 완료)';}else if(value.state == 2){state = '배송 중';}else if(value.state == 3){state = '배송 완료';}else if(value.state == 4){state = '환불 신청';}else if(value.state == 5){state = '환불 완료';}
					html += '<tr><td><input type="checkbox" name="check" class="check" value="'+value.merchant_uid+'"/></td><td><a href="/pay/admin/update/'+value.merchant_uid+'">'+value.merchant_uid+'</a></td><td>'+value.uid+'</td><td>이름 : '+value.uname+'<br/>전화번호 : '+value.uphone+'</td><td>상품 번호 : '+value.no+'<br/>상품명 : '+value.p_name+'<br/>수량 : '+value.qty+'<br/>상품 총 금액 : '+value.total+'</td><td>우편 번호 : '+value.postcode+'<br/>도로명 주소 : '+value.roadaddr+'<br/>지번 주소 : '+value.jibunaddr+'<br/>상세 주소 : '+value.detailaddr+'<br/>'+value.extraaddr+'</td><td>'+value.pay_date+'</td>';
					html += '<td>'+state+'</td></tr>';
				});
				html += '</table>';
				$("#ajaxDiv").html(html);
			}
		});
		for (let i = 0; i <5; i++){
			if(parseInt(document.getElementsByClassName('numberPage')[i].text) == offset){
				document.getElementsByClassName('numberPage')[i].style.backgroundColor = "#eee";
			}else{
				document.getElementsByClassName('numberPage')[i].style.backgroundColor = "#fff";
			}
			if(parseInt(document.getElementsByClassName('numberPage')[i].text) > maxPage){
				document.getElementsByClassName('numberPage')[i].style.color = "#ccc";
			}else{
				document.getElementsByClassName('numberPage')[i].style.color = "#444";
			}
		}
	});
	
	$('#deleteButton').click(function(){
		if(confirm('삭제하시겠습니까?')==true){
			
		}else{
			return false;
		}
	});
});		
</script><style>
.pagination li .numberPage{color:#444;}
td{}
.muid{}
.clear{clear:both;}
</style>
</head>
<body>

<div class="row">

<div class="col-md-1"></div>
<div class="col-md-10">
<form name="payListForm" action="/pay/admin/delete" method="post">

<h1>결제/주문 관리</h1>
<div id="ajaxDiv">
<table class="table table-hover">
<tr><th><input type="checkbox" id="totalCheck"/></th><th>주문번호</th><th>주문자 ID</th><th>수신자 정보</th><th>주문 상품 정보</th><th>배송지 정보</th><th>결제날짜</th><th>상태</th></tr>
<c:forEach items="${payList}" var="pay">
<tr><td><input type="checkbox" name="check" class="check" value="${pay.merchant_uid}"/></td><td class="muid"><a href="/pay/admin/update/${pay.merchant_uid }">${pay.merchant_uid}</a></td><td class="test${i}">${pay.uid}</td><td class="test${i}">이름 : ${pay.uname}<br/>전화번호 : ${pay.uphone}</td><td>상품 번호 : ${pay.no}<br/>상품명 : ${pay.p_name}<br/>수량 : ${pay.qty}<br/>상품 총 금액 : ${pay.total}</td><td>우편 번호 : ${pay.postcode}<br/>도로명 주소 : ${pay.roadaddr}<br/>지번 주소 : ${pay.jibunaddr}<br/>상세 주소 : ${pay.detailaddr}<br/>${pay.extraaddr}</td><td>${pay.pay_date}</td>
<td><c:choose><c:when test="${pay.state eq 0}">결제 오류</c:when><c:when test="${pay.state eq 1}">배송 준비(결제 완료)</c:when><c:when test="${pay.state eq 2}">배송 중</c:when><c:when test="${pay.state eq 3}">배송 완료</c:when><c:when test="${pay.state eq 4}">환불 신청</c:when><c:when test="${pay.state eq 5}">환불 완료</c:when></c:choose></td></tr>	
	</c:forEach>
</table>
</div>
<input id="deleteButton" type="submit" value="삭제"/>
</form>
	<div class="clear"></div>
	<div id="pageBox">
	<ul class="pagination">
	<li><a id="fisrtPage">&lt;</a></li>
	<li><a class="numberPage">1</a></li>
	<li><a class="numberPage">2</a></li>
	<li><a class="numberPage">3</a></li>
	<li><a class="numberPage">4</a></li>
	<li><a class="numberPage">5</a></li>
	<li><a id="lastPage">&gt;</a></li>
	</ul>
	</div>
	<form action="/pay/admin/list" method="get">
	<input type="text" id="searchKeyword" name="searchKeyword" value="${paging.searchKeyword }" /><input type="submit" id="searchButton" value="검색"/>
	</form>
</div>
<div class="col-md-1"></div>
</div>	
<div class="clear"></div>
</body>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
</html>
