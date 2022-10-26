package com.cozy.www.product;

import java.util.List;

public interface ProductService {
	int getDivCount(Paging paging);
	int getDiv2Count(Paging paging);
	int getSearchCount(Paging paging);
	List<ProductVO> getProductListPage(Paging paging);
	List<ProductVO> getBoardListDiv2(Paging paging);
	List<ProductVO> getSearchList(Paging paging);
	List<ProductVO> getPayHot(ProductVO vo);
	List<ProductVO> getHealthy(ProductVO vo);
	List<ProductVO> getLowPrice(ProductVO vo);
	
	
	ProductVO detail(int no);
	

	List<ProductVO> getAdminProductListPage(Paging paging); // 어드민 상품 리스트 
	public int getListCount(Paging paging); // 어드민 상품 글 수 카운트
    	ProductVO adminproductdetail(int no); // 어드민 상품 1개 정보
	public int adminproductinsert(ProductVO vo); // 어드민 상품 등록
	public int adminproductdelete(int no);  // 어드민 상품 삭제
	public int admincheckdelete(List<String> items); // 어드민 상품 선택 삭제
    	public int adminproductupdate(ProductVO vo);  // 어드민 상품 상세수정
    	public int getAdminSearchCount(Paging paging); //검색 갯수
    	List<ProductVO> getAdminSearchList(Paging paging); // 검색 리스트

}
