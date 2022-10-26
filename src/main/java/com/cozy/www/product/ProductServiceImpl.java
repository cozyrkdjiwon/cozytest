package com.cozy.www.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("productService")
public class ProductServiceImpl implements ProductService{
	@Autowired
	private ProductDAO productDAO;

	@Override
	public int getDivCount(Paging paging) {
		return productDAO.getDivCount(paging);
	}
	@Override
	public int getDiv2Count(Paging paging) {
		return productDAO.getDiv2Count(paging);
	}
	@Override
	public int getSearchCount(Paging paging) {
		return productDAO.getSearchCount(paging);
	}
	@Override
	public List<ProductVO> getProductListPage(Paging paging) {
		return productDAO.getProductListPage(paging);
	}
	
	@Override
	public List<ProductVO> getBoardListDiv2(Paging paging) {
		return productDAO.getBoardListDiv2(paging);
	}
	@Override
	public List<ProductVO> getSearchList(Paging paging) {
		return productDAO.getSearchList(paging);
	}
	@Override
	public List<ProductVO> getPayHot(ProductVO vo) {
		return productDAO.getPayHot(vo);
	}
	@Override
	public List<ProductVO> getHealthy(ProductVO vo) {
		return productDAO.getHealthy(vo);
	}
	@Override
	public List<ProductVO> getLowPrice(ProductVO vo) {
		return productDAO.getLowPrice(vo);
	}
	
	
	
	@Override
	public ProductVO detail(int no) {
		return productDAO.detail(no);
	}
	
	
	
	
	
	
	@Override
	public List<ProductVO> getAdminProductListPage(Paging paging) {
		return productDAO.getAdminProductListPage(paging);
	}
	
	@Override
	public int getListCount(Paging paging) {
		return productDAO.getListCount(paging);
	}
	
	@Override
	public int getAdminSearchCount(Paging paging) {
		return productDAO.getAdminSearchCount(paging);
	}
	
	@Override
	public List<ProductVO> getAdminSearchList(Paging paging) {
		return productDAO.getAdminSearchList(paging);
	}
	
	@Override
	public ProductVO adminproductdetail(int no) {
		return productDAO.adminproductdetail(no);
	}
	
	@Override
	public int adminproductinsert(ProductVO vo) {
		return productDAO.adminproductinsert(vo);
	}
	
	@Override
	public int adminproductdelete(int no) {
		return productDAO.adminproductdelete(no);
	}
	
	@Override
	public int admincheckdelete(List<String> items) {
		return productDAO.adminproductcheckdelete(items);
	}
	
	@Override
	public int adminproductupdate(ProductVO vo) {
		return productDAO.adminproductupdate(vo);
	}
	
	
	
}
