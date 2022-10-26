<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
$(function(){
	$('#updateButton').click(function(){
		if($('#sample4_jibunAddress').val() == ''){
			$('#sample4_jibunAddress').val('-');
		}
		if(confirm('수정하시겠습니까?')==true){
			
		}else{
			return false;
		}
	});	
	$('#cancel').click(function(){
		if(confirm('해당 주문에 대하여 결제 취소를 진행하겠습니까?')==true){
			
		}else{
			return false;
		}
	});
	
	
	$('#payList').click(function(){
		$.get('http://localhost:3000/person', function(data){
			  console.log(data);
			});
	});

});
</script>
<style>
table{width:100%;}
.imgTD{width:10%;}
.img{width:100%;}
.clear{clear:both;}
</style>
</head>
<body>
<div class="row">
<div class="col-md-2"></div>
<div class="col-md-8">
<form action="/pay/admin/update/${payUpdateForm[0].merchant_uid }" method="post">
<h4>주문 번호 : ${payUpdateForm[0].merchant_uid}</h4>
	<h3>상품 목록</h3>
	<table class="table table-hover">
		<tr><td>이미지</td><td>상품명</td><td>가격</td><td>수량</td><td>총금액</td></tr>
		<c:forEach items="${payUpdateForm}" var="order">
		<tr><td class="imgTD"><img class="img" src="/resources/product/${order.thumbfile}" alt="${order.p_file}상품의 이미지" title="${order.p_file} 이미지"/></td><td>${order.p_name}</td><td>${order.price}</td><td>${order.qty}</td><td class="totalV">${order.total}</td></tr>
		</c:forEach>
	</table>
	<table>
	<tr><td><label for="uid" >주문자 ID</label></td><td><input type="text" id="uid" name="uid" value="${payUpdateForm[0].uid }"/></td></tr>
	<tr><td><label for="uname" >수신자명</label></td><td><input type="text" id="uname" name="uname" value="${payUpdateForm[0].uname }"/></td></tr>
	<tr><td><label for="uphone" >수신자 전화번호</label></td><td><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  id="uphone" name="uphone" value="${payUpdateForm[0].uphone }"/></td></tr>
	<tr><td><label for="postcode" >우편번호</label></td><td><input type="text" id="sample4_postcode" name="postcode" value="${payUpdateForm[0].postcode }"/><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br></td></tr>
	<tr><td><label for="roadaddr" >도로주소</label></td><td><input type="text" id="sample4_roadAddress" name="roadaddr" value="${payUpdateForm[0].roadaddr }"/><span id="guide" style="color:#999;display:none"></span></td></tr>
	<tr><td><label for="jibunaddr" >지번주소</label></td><td><input required type="text" id="sample4_jibunAddress" name="jibunaddr" value="${payUpdateForm[0].jibunaddr }"/></td></tr>
	<tr><td><label for="detailaddr" >상세주소</label></td><td><input type="text" id="detailaddr" name="detailaddr" value="${payUpdateForm[0].detailaddr }"/></td></tr>
	<tr><td><label for="extraaddr" >기타주소</label></td><td><input type="text" id="sample4_extraAddress" name="extraaddr" value="${payUpdateForm[0].extraaddr }"/></td></tr>
	<tr><td><label for="pay_date" >결제 날짜</label></td><td><input type="date" id="pay_date" name="pay_date" value="${payUpdateForm[0].pay_date }"/></td></tr>
	<tr><td><label for="state" >상태</label></td><td><c:choose><c:when test="${payUpdateForm[0].state eq 0}">결제 오류</c:when><c:when test="${payUpdateForm[0].state eq 1}">배송 준비(결제 완료)</c:when><c:when test="${payUpdateForm[0].state eq 2}">배송 중</c:when><c:when test="${payUpdateForm[0].state eq 3}">배송 완료</c:when><c:when test="${payUpdateForm[0].state eq 4}">환불 신청</c:when><c:when test="${payUpdateForm[0].state eq 5}">환불 완료</c:when></c:choose><select id="state" name="state"><option value="${payUpdateForm[0].state }">--상태 변경--</option><option value="1">배송 준비(결제 완료)</option><option value="2">배송중</option><option value="3">배송완료</option><option value="4">환불 신청</option><option value="5">환불 완료</option></select></td></tr>
	<tr><td><label for="merchant_uid" >주문 번호</label></td><td><input type="text" id="merchant_uid" name="merchant_uid" value="${payUpdateForm[0].merchant_uid }"/></td></tr>
	<tr><td>결제 내역</td><td><input type="button" id="payList" value="결제 내역"></td></tr>
	</table>
	<input type="submit" id="updateButton" value="수정"/>
	<input type="button" id="listButton" value="목록으로" onclick="location.href='/pay/admin/list'"/>
</form>
<form action="/pay/cancel"><input type="hidden" name="merchant_uid" value="${payUpdateForm[0].merchant_uid }"/><input type="submit" id="cancel" value="환불"></form>
</div>
<div class="col-md-2"></div>
</div>
<div class="clear"></div>
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
</body>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
</html>