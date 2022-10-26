<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
$(function(){
	let totalPrice = parseInt(document.getElementById('totalPrice').value);
	if(totalPrice < 30000){
		totalPrice = totalPrice + 3000;
	}
	$('#tp').text(totalPrice.toLocaleString('ko-KR')+"원");

	
	$('#orderButton').click(function(){
		if($('#unameF').val() == ''){
			$('#userRequired').text('이름을 입력해주세요.');
			return false;
		}
		if($('#uphoneF').val() == ''){
			$('#uphoneRequired').text('전화번호를 입력해주세요.');
			return false;
		}
		if($('#sample4_postcode').val() == ''){
			$('#postRequired').text('우편번호를 입력해주세요.');
			return false;
		}
		if($('#sample4_roadAddress').val() == ''){
			$('#roadRequired').text('도로주소를 입력해주세요.');
			return false;
		}
		if($('#sample4_jibunAddress').val() == ''){
			$('#jibunRequired').text('지번주소를 입력해주세요.');
			return false;
		}
		if($('#detailaddrF').val() == ''){
			$('#detailRequired').text('상세주소를 입력해주세요.');
			return false;
		}
		if($('#sample4_extraAddress').val() == ''){
			$('#sample4_extraAddress').val('기타주소를 입력해주세요.');
			return false;
		}
		
		if($("input[name='payRadio']:checked").val() == 'card'){
			if(confirm('결제하시겠습니까?')==true){
				iamport();
			}else{
				return false;
			}
		}else if($("input[name='payRadio']:checked").val() == 'kakao'){
			if(confirm('결제하시겠습니까?')==true){
				$("#paybtn").click();
			}else{
				return false;
			}
		}else if($("input[name='payRadio']:checked").val() == 'toss'){
			if(confirm('결제하시겠습니까?')==true){
				iamtoss();
			}else{
				return false;
			}
			
		}
	});
	
});
</script>

<script>
$(function(){
	$('#tossButton').click(function(){

		
	});	
});
</script>
<style>
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
.h2Title{padding-left:5%; margin-top:42px; margin-bottom:56px; font-size:28px; text-align: center; font-weight:bold;}
.h4Title{padding-left:5%; padding-top:28px; margin-top:28px; margin-bottom:22px; font-weight:bold;}
#userTable{width:90%; margin:0 5%;}
#userTable td{width: 150px; padding:18px 0;}
#userTable .left{width:30%;}
#userTable input{border:1px solid #999; height: 32px; border-radius:5px; width:100%;}
#userTable .postForm{width:50%;}
#userTable input[type=button]{
background-color:#fcaa06; border:1px solid #fcaa06; border-radius:8px; color: white; width:50%; height: 28px;
}
#userTable input[type=button]:hover{
background-color: #ff9900;  border:1px solid #ff9900;
}
.leftBox{padding:0 2.5%;}
.leftBox p{padding-left:5%; margin-top:12px; font-size:14px;}
.rightBox{padding:0 2.5%;}
.rightBox p{padding-left:5%; margin-top:12px; font-size:17px;}
.rightBox span{font-size:14px;}
.rightBox img{width:48px;}
.rightBox input[type=radio]{
    accent-color:#777;
}
#tp{font-size:32px; color: #fcaa06;}
#orderButton{background-color:#fcaa06; border:1px solid #fcaa06; border-radius:8px; color: white; width:95%; margin:36px 0 2% 0; height:52px; font-size:23px;}
#orderButton:hover{background-color: #ff9900;  border:1px solid #ff9900;}

.clear{clear:both;}
</style>
</head>
<body>
<div class="row">
<div class="col-md-2"></div>
<div class="col-md-8">
	<h2 class="h2Title">주문/결제</h2>
	<table id="productTable" class="table">
		<tr id="productTableHead"><td id="imageTD">상품</td><td id="productTD">상품명</td><td class="qtyTD">수량</td><td class="totalTD">상품 금액</td></tr>
		<c:set var="total" value="0"/>
		<c:forEach items="${orderInfo}" var="order">
		<tr><td><img src="/resources/product/${order.p_file}" alt="${order.p_name}상품의 이미지" title="${order.p_name} 이미지"/></td><td>${order.p_name}<br/>개당 가격: ${order.price}원</td><td class="qtyTD">${order.qty}개</td><td class="totalTD">${order.price*order.qty}원</td></tr>
		<c:set var="total" value="${total+ order.price*order.qty}"/>
		</c:forEach>
		<tr><td class="totalRight" colspan="5">상품 총 금액 : <span id="totalSPAN">${total}원</span></td></tr>
	</table>
	</div>
<div class="col-md-2"></div>
</div>
	<div class="clear"></div>
	<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-4 col-sm-6 leftBox">

	<h4 class="h4Title">배송지 정보</h4>
	<!-- <form action="/pay/complete" method="post" id="payform" name = payform> -->
	<form name = payform>
	<table id="userTable">
	<tr><td class="left"><label for="uname">이름</label></td><td><input type="text" id="unameF" value="${orderInfo[0].uname}" required/><span id="userRequired"></span></td></tr>
	<tr><td><label for="uphone">전화번호</label></td><td><input type="text" id="uphoneF" value="${orderInfo[0].uphone}" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" /><span id="uphoneRequired"></span></td></tr>
	<tr><td><label for="postcode" >우편번호</label></td><td><input type="text" id="sample4_postcode" class="postForm"  name="postcode" value="${orderInfo[0].postcode}"/><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><span id="postRequired"></span><br></td></tr>
	<tr><td><label for="roadaddr" >도로주소</label></td><td><input type="text" id="sample4_roadAddress" name="roadaddr" value="${orderInfo[0].roadaddr}"/><span id="guide" style="color:#999;display:none"></span><span id="roadRequired"></span></td></tr>
	<tr><td><label for="jibunaddr" >지번주소</label></td><td><input required type="text" id="sample4_jibunAddress" name="jibunaddr" value="${orderInfo[0].jibunaddr}"/><span id="jibunRequired"></span></td></tr>
	<tr><td><label for="detailaddr" >상세주소</label></td><td><input type="text" id="detailaddrF" name="detailaddr" value="${orderInfo[0].detailaddr}"/><span id="detailRequired"></span></td></tr>
	<tr><td><label for="extraaddr" >기타주소</label></td><td><input type="text" id="sample4_extraAddress" name="extraaddr" value="${orderInfo[0].extraaddr}"/><span id="extraRequired"></span></td></tr>
	</table>
	<p>정확한 정보를 기입해주세요.<br/>잘못된 정보를 기입할 시 오배송이 발생할 수 있습니다.</p>
	
	<input type="hidden" id="checkList" name="checkList" value="${checkList}"/>
	<input type="hidden" id="totalPrice" name="totalPrice" value="${total}">
	<input type="hidden" id="uid" name="uid" value="${orderInfo[0].uid}">
	<input type="hidden" id="uphone" name="uphone" value="${orderInfo[0].uphone}">
	<input type="hidden" id="total" name="total" value=#tp.text id=prototal>
	<input type="hidden" id="postcode" name="postcode" value="${orderInfo[0].postcode}">
	<input type="hidden" id="roadaddr" name="roadaddr" value="${orderInfo[0].roadaddr}">
	<input type="hidden" id="jibunaddr" name="jibunaddr" value="${orderInfo[0].jibunaddr}">
	<input type="hidden" id="detailaddr" name="detailaddr" value="${orderInfo[0].detailaddr}">
	<input type="hidden" id="extraaddr" name="extraaddr" value="${orderInfo[0].extraaddr}">
	</form>
	</div>
	<div class="col-md-4 col-sm-6 rightBox">
	<h4 class="h4Title">주문자 정보</h4>
	<p>
		<c:if test="${ !(empty orderInfo[0].uid)}">ID : ${orderInfo[0].uid}</c:if><br/><c:if test="${ !(empty orderInfo[0].uname)}">이름 : ${orderInfo[0].uname}</c:if><br/>
	</p>
	<h4 class="h4Title">주문 금액</h4>
	<p id = "tp">총가격 자리<p>
	<span>구매 금액에 따라 배송비 변경<br/>30,000원 미만 : 3,000원<br/>30,000원 이상 : 무료<br/></span>
	
	<input type="hidden" src="/resources/kakako_pay_icon.png" id="paybtn"/>

	<h4 class="h4Title">결제 방식 선택</h4>
	<p>
	<input type="radio" id="cardRadio" name="payRadio" value="card" checked/><label for="cardRadio">&nbsp;신용카드 결제</label><br/>
	<input type="radio" id="kakaoRadio" name="payRadio" value="kakao"/><label for="kakaoRadio">&nbsp;카카오페이<img src="/resources/kakako_pay_icon.png"/></label><br/>
	<input type="radio" id="tossRadio" name="payRadio" value="toss"/><label for="tossRadio">&nbsp;토스페이</label><br/>
	<input type="button" id="orderButton" value="주문하기"/>
	</p>
	
	
	</div>
	
	
	
	<div class="col-md-2">
	</div>
	<div class="clear"></div>
	
	
	</div>
</body>
<script>
function iamport(){
		let uname = document.getElementById('unameF').value;
		let uphone = document.getElementById('uphoneF').value;
		let postcode = document.getElementById('sample4_postcode').value;
		let roadaddr = document.getElementById('sample4_roadAddress').value;
		let jibunaddr = document.getElementById('sample4_jibunAddress').value;
		let detailaddr = document.getElementById('detailaddrF').value;
		let extraaddr = document.getElementById('sample4_extraAddress').value;
		let checkList = document.getElementById('checkList').value;
		let totalPrice = parseInt(document.getElementById('totalPrice').value);
		if(totalPrice < 30000){
			totalPrice = totalPrice + 3000;
		}
		
		
		//가맹점 식별코드
		IMP.init('imp17363174');
		IMP.request_pay({
		    pg : 'html5_inicis',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '${orderInfo[0].p_name}' , //결제창에서 보여질 이름
		    //amount : totalPrice,
		    amount : 100, //실제 결제되는 가격 테스트라 100원 해놓음
		    buyer_email : 'vkstkwldnjs@naver.com',//테스트용 이메일이라 나중에 사용자 이메일로 바꿔야 함
		    buyer_name : '${orderInfo[0].uname}',
		    buyer_tel : '${orderInfo[0].uphone}',
		    buyer_addr : '${orderInfo[0].roadaddr}',
		    buyer_postcode : '${orderInfo[0].postcode}'
		}, function(rsp) {
			console.log(rsp);
			// 결제검증
			if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
				 var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			        doFormRequest('/pay/complete', 'post', {'checkList':checkList, 'merchant_uid':rsp.merchant_uid,'uname':uname, 'uphone':uphone, 'postcode':postcode, 'roadaddr':roadaddr, 'jibunaddr':jibunaddr, 'detailaddr':detailaddr, 'extraaddr':extraaddr});
     	 	} else {
    	 	 	var msg = '결제에 실패하였습니다.';
         	 	msg += '에러내용 : ' + rsp.error_msg;
      		}
				alert(msg);
			});
}
function doFormRequest(url, action, json)
{
    var form = document.createElement("form");
    form.action = url;
    form.method = action;
    for (var key in json)
    {
        if (json.hasOwnProperty(key))
        {
            var val = json[key];
            input = document.createElement("input");
            input.type = "hidden";
            input.name = key;
            input.value = val;
            form.appendChild(input)
        }
    }

    document.body.appendChild(form);
    form.submit();

    document.body.removeChild(form);
}

</script>
<script>
function iamtoss(){
		let uname = document.getElementById('unameF').value;
		let uphone = document.getElementById('uphoneF').value;
		let postcode = document.getElementById('sample4_postcode').value;
		let roadaddr = document.getElementById('sample4_roadAddress').value;
		let jibunaddr = document.getElementById('sample4_jibunAddress').value;
		let detailaddr = document.getElementById('detailaddrF').value;
		let extraaddr = document.getElementById('sample4_extraAddress').value;
		let checkList = document.getElementById('checkList').value;
		
		//가맹점 식별코드
		IMP.init('imp17363174');
		IMP.request_pay({
		    pg : 'uplus',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '${orderInfo[0].p_name}' , //결제창에서 보여질 이름
		    amount : 100, //실제 결제되는 가격 테스트라 100원 해놓음
		    buyer_email : 'ghdwnsdn128@naver.com',//테스트용 이메일이라 나중에 사용자 이메일로 바꿔야 함
		    buyer_name : '${orderInfo[0].uname}',
		    buyer_tel : '${orderInfo[0].uphone}',
		    buyer_addr : '${orderInfo[0].roadaddr}',
		    buyer_postcode : '${orderInfo[0].postcode}'
		}, function(rsp) {
			console.log(rsp);
			// 결제검증
			if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
				 var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			        doFormRequest('/pay/complete', 'post', {'checkList':checkList, 'merchant_uid':rsp.merchant_uid,'uname':uname, 'uphone':uphone, 'postcode':postcode, 'roadaddr':roadaddr, 'jibunaddr':jibunaddr, 'detailaddr':detailaddr, 'extraaddr':extraaddr});
     	 	} else {
    	 	 	var msg = '결제에 실패하였습니다.';
         	 	msg += '에러내용 : ' + rsp.error_msg;
      		}
				alert(msg);
			});
}
function doFormRequest(url, action, json)
{
    var form = document.createElement("form");
    form.action = url;
    form.method = action;
    for (var key in json)
    {
        if (json.hasOwnProperty(key))
        {
            var val = json[key];
            input = document.createElement("input");
            input.type = "hidden";
            input.name = key;
            input.value = val;
            form.appendChild(input)
        }
    }

    document.body.appendChild(form);
    form.submit();

    document.body.removeChild(form);
}

</script>
<script>
$().ready(function(){
	let fee = 3000;
	let price = parseInt(document.getElementById('totalPrice').value);
	if (price > 30000){
		fee = 0;}else{price = price + fee;}
	let prototal = price.toLocaleString('ko-KR');
	let delfee = fee.toLocaleString('ko-KR');
	$('.delFee').text(delfee);
	$('#prototal').val(price);
	});
$("#paybtn").click(function () {
	var IMP = window.IMP;
	let procnt = 
	IMP.init('imp42484742');
	IMP.request_pay({
		pg: 'kakaopay',
		pay_method: 'card',
		merchant_uid: 'merchant_' + new Date().getTime(),
		name: '${orderInfo[0].p_name}',
		amount: $("#tp").text(),
		buyer_name: '${orderInfo[0].uname}',
		buyer_postcode: ('${orderInfo[0].postcode}'),
		}, function (rsp) {
			console.log(rsp);
		if (rsp.success) {
			var msg = '결제가 완료되었습니다.';
			msg += '빠르게 고객님께 전달드리겠습니다.';
			let payform = document.payform;
			payform.method = "post";
			payform.target ="_self";
			payform.action = "/pay/paySuccess"
			payform.submit();
			success.submit();
		} else {
			var msg = '결제에 실패하였습니다.';
			msg += '에러내용 : ' + rsp.error_msg;
		}
		alert(msg);
	});
});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            },
	        onclose: function(state) {
	            //state는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수 이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
	            if(state === 'FORCE_CLOSE'){
	                //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.
	
	            } else if(state === 'COMPLETE_CLOSE'){
	                //사용자가 검색결과를 선택하여 팝업창이 닫혔을 경우, 실행될 코드를 작성하는 부분입니다.
	                //oncomplete 콜백 함수가 실행 완료된 후에 실행됩니다.
	            }
	        }
        }).open();
    }
</script>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
</html>