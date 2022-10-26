<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "/WEB-INF/views/include/header.jsp" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<title>상품 목록</title>
<style>
#productTitle{margin: 42px 0; font-size:32px; text-align: center; font-weight:bold;}
.radioDiv{text-align:right; margin-bottom:22px;}
.div2Button{padding: 8px 13px; margin:6px; border:1px solid #ccc; border-radius:12px; background-color:white;}
.productBox{border: 1px solid #ccc; padding: 2%; border-radius: 5%;}
.productBox img{width:100%; border-radius: 10%;}
.leftMenu{border-bottom:1px solid #ccc;}
#pageBox{text-align:center;}
.clear{clear:both;}


.productImage{width:100%; padding:13%;}
.productName{font-size: 20px;  text-align:center;}
.productPrice{font-size: 17px;  text-align:center;}
.clear{clear:both;}
#p_nameBox{padding:0 8%; margin-top:8px; height:58px; overflow: hidden; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp: 2 !important; -webkit-box-orient: vertical;}
.center{text-align:center;}
.cartButton{background-color: #fcaa06; border:1px solid #fcaa06; color:white; padding:2.5px 8px; border-radius:8px; font-family: 'Sunflower', sans-serif; font-size:16px;}
.cartButton:hover{background-color: #ff9900;}
.detailButton{background-color: white; border:1px solid #ccc; color:#777; padding:2.5px 8px; margin-bottom:9px; border-radius:8px; font-family: 'Sunflower', sans-serif; font-size:16px;}
#numberValue{width:40px; height:30px; border:1px solid #ccc; border-radius:5px;}
input[type=number]::-webkit-inner-spin-button {opacity: 0.7;}
.productDiv{margin-bottom:32px;}
#searchKeyword{border:1px solid #777; border-radius:12px; height: 32px;}
#searchButton{border:1px solid #777; border-radius:12px; height: 34px; width: 55px; margin-left:10px;}
#searchBox{margin-top:12px;}
input[type=checkbox], input[type=radio] {
    accent-color:#777;
}

</style>
</head>
<body>
<input type="hidden" id="offsetValue" value="${paging.nowPage }"/>
<input type="hidden" id="firstnumber" value="${5*paging.page+1}"/>
	<div class="col-md-2"></div>
	<div class="col-md-8">
	
	
	<div class="row">
	<div id="productTitle"></div>
	
	<div class="col-md-6"><input type="button" id="totalButton" class="div2Button" onclick="location.href='/product/list/${paging.div1}'" value="전체" /><input type="button" id="catButton" class="div2Button" onclick="location.href='/product/list/${paging.div1}/cat'" value="고양이" /><input type="button" id="dogButton" class="div2Button" onclick="location.href='/product/list/${paging.div1}/dog'" value="강아지" /><input type="button" id="friendsButton" class="div2Button" onclick="location.href='/product/list/${paging.div1}/friends'" value="그 외 친구들" />
	
	</div>
	<div class="radioDiv col-md-6">
	<div id="radioBox">
	<input type="radio" id="new" class="radioB" name="orderRadio" value="new" checked/><label for="new">&nbsp;신상품순</label>
	<input type="radio" id="low" class="radioB" name="orderRadio" value="low" /><label for="low">&nbsp;낮은가격순</label>
	<input type="radio" id="high" class="radioB" name="orderRadio" value="high" /><label for="high">&nbsp;높은가격순</label></div>
	<div id="searchBox">
	<form action="/product/search/1">
	<input type="text" id="searchKeyword" name="searchKeyword"/><button id="searchButton">검색</button></form>
	</div>
	
	</div>
	</div>
	
	<div class="clear"></div>

	
	<div class="row">

  	<div id="ajaxDiv" class="row">		
  	<c:forEach items="${productList}" var="product">
	<div class="col-md-4 col-sm-6 productDiv">
	<a href="/product/productDetail/${product.no}"><img class="productImage" src="/resources/product/${product.thumbfile}" alt="${product.p_file}상품의 이미지" title="${product.p_file} 이미지"/></a>
	<p class="productName" id="p_nameBox">${product.p_name}</p>
	<p class="productPrice">${product.price}원</p>
	<div class="center">
	<form action="/cart/${product.no}" method="post">
	<div><button type="button" class="detailButton" onclick="location.href='/product/productDetail/${product.no}'">자세히 보기</button></div>
	<input type="hidden" id="productNoValue" value="${product.no}"/><input type="number" id="numberValue" name="qty" value="1" min="1" max="200" />개&nbsp;<input type="submit" class="cartButton" value="장바구니"/>
	</form>
	</div>
	</div>
	</c:forEach>
	</div>


<div class="clear"></div>

	<c:if test="${empty productList }">
		<p>상품이 없습니다.</p>
	</c:if>
	</div>
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
		

</div>
<div class="clear"></div>
<br>

</body>
<script>
$(function(){
	let offset = 1;
	let maxPage = '${maxPage}';
	let div1 = '${paging.div1}';
	let div2 = '${paging.div2}';
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
	
	if(div1 != ""){
		if(div1 == 'feed'){
			$('#productTitle').html('코지사료');
		}else if(div1 == 'snack'){
			$('#productTitle').html('코지간식');
		}else if(div1 == 'clean'){
			$('#productTitle').html('위생용품');
		}else if(div1 == 'living'){
			$('#productTitle').html('생활용품');
		} if(div1 == 'healthy'){
			$('#productTitle').html('건강');
		}
	}
	if(div2 != ""){
		if(div2 == 'cat'){
			$('#catButton').css("background-color","#eee");
		}else if(div2 == 'dog'){
			$('#dogButton').css("background-color","#eee");
		}else if(div2 == 'friends'){
			$('#friendsButton').css("background-color","#eee");
		}
	}else{
		$('#totalButton').css("background-color","#eee");
	}
	
	$('#fisrtPage').click(function(){
		let offV;
		let search = $('#searchKeyword').val();
		let urlString = '';
		if(div2 != ""){
			urlString = "/product/list/"+div1+"/"+div2;
		}else{
			urlString = "/product/list/"+div1;
		}
		if((firstnumber-5) < 1){
			offV = 1;
			firstnumber = 1;
		}else{
			offV = firstnumber-5;
			firstnumber = firstnumber-5;
		}
		$.ajax({
			url:urlString,
			type:"post",
			data:{"offset":offV, "searchKeyword":search},
			success:function(data){
				html='';
				$.each(data,function(key,value) {
					html+='<div class="col-md-4 col-sm-6 productDiv">';
					html+='<a href="/product/productDetail/'+value.no+'"><img class="productImage" src="/resources/product/'+value.thumbfile+'" alt="'+value.p_file+'상품의 이미지" title="'+value.p_file+' 이미지"/></a>';
					html+='<p class="productName" id="p_nameBox">'+value.p_name+'</p><p class="productPrice">'+value.price+'원</p>';
					html+='<div class="center"><form action="/cart/'+value.no+'" method="post">';
					href = "location.href='/product/productDetail/"+value.no+"'";
					html+='<div><button type="button" class="detailButton" onclick="'+href+'">자세히 보기</button></div>';
					html+='<input type="hidden" id="productNoValue" value="'+value.no+'"/><input type="number" id="numberValue" name="qty" value="1" min="1" max="200" />개&nbsp;<input type="submit" class="cartButton" value="장바구니"/>';
					html+='</form></div></div>';
				});
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
				document.getElementsByClassName('numberPage')[i].style.color = "#ccc";
			}else{
				document.getElementsByClassName('numberPage')[i].style.color = "#444";
			}
		}		
	});
	$('#lastPage').click(function(){
		let offV;
		let search = $('#searchKeyword').val();
		let urlString = '';
		if(div2 != ""){
			urlString = "/product/list/"+div1+"/"+div2;
		}else{
			urlString = "/product/list/"+div1;
		}
		offV = firstnumber+5;
		if(offV > maxPage){
			return false;
		}
		$.ajax({
			url:urlString,
			type:"post",
			data:{"offset":offV, "searchKeyword":search},
			success:function(data){
				html='';
				$.each(data,function(key,value) {
					html+='<div class="col-md-4 col-sm-6 productDiv">';
					html+='<a href="/product/productDetail/'+value.no+'"><img class="productImage" src="/resources/product/'+value.thumbfile+'" alt="'+value.p_file+'상품의 이미지" title="'+value.p_file+' 이미지"/></a>';
					html+='<p class="productName" id="p_nameBox">'+value.p_name+'</p><p class="productPrice">'+value.price+'원</p>';
					html+='<div class="center"><form action="/cart/'+value.no+'" method="post">';
					href = "location.href='/product/productDetail/"+value.no+"'";
					html+='<div><button type="button" class="detailButton" onclick="'+href+'">자세히 보기</button></div>';
					html+='<input type="hidden" id="productNoValue" value="'+value.no+'"/><input type="number" id="numberValue" name="qty" value="1" min="1" max="200" />개&nbsp;<input type="submit" class="cartButton" value="장바구니"/>';
					html+='</form></div></div>';
				});
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
				document.getElementsByClassName('numberPage')[i].style.color = "#ccc";
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
	
	$(document).on('click', '.cartButton', function(e) {
		if (confirm("장바구니에 담으시겠습니까?") == true && qty>0){
		 }else{
		     return false;
		 }
	});
	
	$('.numberPage').click(function(){
		offset = parseInt(this.text);
		if(offset > maxPage){
			return false;
		}
		let search = $('#searchKeyword').val();
		let urlString = '';
		if(div2 != ""){
			urlString = "/product/list/"+div1+"/"+div2;
		}else{
			urlString = "/product/list/"+div1;
		}
		$.ajax({
			url:urlString,
			type:"post",
			data:{"offset":offset, "searchKeyword":search},
			success:function(data){
				html='';
				$.each(data,function(key,value) {
					html+='<div class="col-md-4 col-sm-6 productDiv">';
					html+='<a href="/product/productDetail/'+value.no+'"><img class="productImage" src="/resources/product/'+value.thumbfile+'" alt="'+value.p_file+'상품의 이미지" title="'+value.p_file+' 이미지"/></a>';
					html+='<p class="productName" id="p_nameBox">'+value.p_name+'</p><p class="productPrice">'+value.price+'원</p>';
					html+='<div class="center"><form action="/cart/'+value.no+'" method="post">';
					href = "location.href='/product/productDetail/"+value.no+"'";
					html+='<div><button type="button" class="detailButton" onclick="'+href+'">자세히 보기</button></div>';
					html+='<input type="hidden" id="productNoValue" value="'+value.no+'"/><input type="number" id="numberValue" name="qty" value="1" min="1" max="200" />개&nbsp;<input type="submit" class="cartButton" value="장바구니"/>';
					html+='</form></div></div>';
				});
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
	
//	$('#searchButton').click(function(){
//		$('#fisrtPage').click();
//	});
	
});	
</script>
<%@ include file = "/WEB-INF/views/include/footer.jsp" %>
</html>