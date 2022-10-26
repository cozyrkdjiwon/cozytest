<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.h2Title{padding-left:5%; margin-top:42px; margin-bottom:56px; font-size:28px; text-align: center; font-weight:bold;}
.h4Title{padding-left:5%; padding-top:28px; margin-top:28px; margin-bottom:22px; font-weight:bold;}
#productTable{width:90%; margin:0 5% 34px 5%;}
#productTable tr{border:1px solid #f2f2f2;}
#productTableHead td{background-color:#fcaa06; color:white; font-weight:bold; border:1px solid #fcaa06; text-align:center;}
#imageTD{width:17%;}
#productTD{width:40%;}
.qtyTD{width:15%; text-align:center;}
.totalTD{width:28%; text-align:center;}
.totalRight{text-align:right;}
#totalSPAN{color:#fcaa06; font-size:20px;}
#productTable img{width:100%;}
#userTable{width:90%; margin:0 5%;}
#userTable td{width: 150px; padding:10px 0;}
#userTable .left{width:30%;}
.leftBox{padding:0 2.5%;}
.leftBox p{padding-left:5%; margin-top:12px; font-size:14px;}
.rightBox{padding:0 2.5%;}
.rightBox p{padding-left:5%; margin-top:12px; font-size:17px;}
.rightBox span{font-size:14px;}
#tp{font-size:32px; color: #fcaa06;}
#payList{background-color:#fcaa06; border:1px solid #fcaa06; border-radius:8px; color: white; width:95%; margin:36px 0 2% 0; height:52px; font-size:23px;}
#payList:hover{background-color: #ff9900;  border:1px solid #ff9900;}

.clear{clear:both;}
</style>
<script>
$(function(){
	let totalPrice = parseInt(document.getElementById('totalPrice').value);
	if(totalPrice < 30000){
		totalPrice = totalPrice + 3000;
	}
	$('#tp').text(totalPrice.toLocaleString('ko-KR')+"원");
});
</script>
</head>
<body>
	<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-8">
	<h2 class="h2Title">주문 완료</h2>

	<h4 class="h4Title">주문 번호 : ${orderInfo[0].merchant_uid}</h4>
	<table id="productTable" class="table">
		<tr id="productTableHead"><td id="imageTD">상품</td><td id="productTD">상품명</td><td class="qtyTD">수량</td><td class="totalTD">상품 금액</td></tr>
		<c:set var="total" value="0"/>
		<c:forEach items="${orderInfo}" var="order">
		<tr><td><img src="/resources/product/${order.thumbfile}" alt="${order.p_name}상품의 이미지" title="${order.p_name} 이미지"/></td><td>${order.p_name}<br/>개당 가격: ${order.price}원</td><td class="qtyTD">${order.qty}개</td><td class="totalTD">${order.price*order.qty}원</td></tr>
		<c:set var="total" value="${total+ order.price*order.qty}"/>
		</c:forEach>
		<tr><td class="totalRight" colspan="5">상품 총 금액 : <span id="totalSPAN">${total}원</span></td></tr>
	</table>
	<input type="hidden" id="totalPrice" name="totalPrice" value="${total}">
	
	</div>
	<div class="col-md-2"></div>
	</div>
	<div class="clear"></div>
	
		<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-4 col-sm-6 leftBox">
	<h4 class="h4Title">배송지 정보</h4>
	<table id="userTable">
		<tr><td class="left">이름</td><td>${orderInfo[0].uname}</td></tr>
		<tr><td>전화번호</td><td>${orderInfo[0].uphone}</td></tr>
		<tr><td>우편번호</td><td>${orderInfo[0].postcode}</td></tr>
		<tr><td>도로명주소</td><td>${orderInfo[0].roadaddr}</td></tr>
		<tr><td>지번주소</td><td>${orderInfo[0].jibunaddr}</td></tr>
		<tr><td>상세주소</td><td>${orderInfo[0].detailaddr}</td></tr>
		<tr><td>기타주소</td><td>${orderInfo[0].extraaddr}</td></tr>
	</table>
	</div>
	<div class="col-md-4 col-sm-6 rightBox">
	<h4 class="h4Title">주문자 정보</h4>
	<p>
		<c:if test="${ !(empty orderInfo[0].uid)}">ID : ${orderInfo[0].uid}</c:if><br/><c:if test="${ !(empty orderInfo[0].uname)}">이름 : ${orderInfo[0].uname}</c:if><br/>
	</p>
	<h4 class="h4Title">주문 금액</h4>
	<p id = "tp">총가격 자리<p>
	<p>
	<input type="button" id="payList" value="결제 내역으로 가기" onclick="location.href='/pay/MyList'"/>
	</p>
	</div>
	<div class="col-md-2"></div>
	</div>
	<div class="clear"></div>
	
	
</body>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
</html>