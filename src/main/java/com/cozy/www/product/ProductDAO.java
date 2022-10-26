package com.cozy.www.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int getDivCount(Paging paging) {
		return mybatis.selectOne("ProductDAO.getDivCount",paging);
	}
	public int getDiv2Count(Paging paging) {
		return mybatis.selectOne("ProductDAO.getDiv2Count",paging);
	}
	public int getSearchCount(Paging paging) {
		return mybatis.selectOne("ProductDAO.getSearchCount",paging);
	}
	public List<ProductVO> getProductListPage(Paging paging) {
		return mybatis.selectList("ProductDAO.getProductListPage",paging);
	}
	public List<ProductVO> getBoardListDiv2(Paging paging) {
		return mybatis.selectList("ProductDAO.getBoardListDiv2",paging);
	}
	public List<ProductVO> getSearchList(Paging paging) {
		return mybatis.selectList("ProductDAO.getSearchList",paging);
	}
	public List<ProductVO> getPayHot(ProductVO vo) {
		return mybatis.selectList("ProductDAO.getPayHot",vo);
	}
	public List<ProductVO> getHealthy(ProductVO vo) {
		return mybatis.selectList("ProductDAO.getHealthy",vo);
	}
	public List<ProductVO> getLowPrice(ProductVO vo) {
		return mybatis.selectList("ProductDAO.getLowPrice",vo);
	}

	
	public ProductVO detail(int no) {
		return mybatis.selectOne("ProductDAO.detail", no);
	}
	
	
	
	public List<ProductVO> getAdminProductListPage(Paging paging) {
		return mybatis.selectList("ProductDAO.getAdminProductListPage",paging);
	}
	public int getListCount(Paging paging) {
		return mybatis.selectOne("ProductDAO.getListCount",paging);
	}
	public int getAdminSearchCount(Paging paging) {
		return mybatis.selectOne("ProductDAO.getAdminSearchCount",paging);
	}
	public List<ProductVO> getAdminSearchList(Paging paging) {
		return mybatis.selectList("ProductDAO.getAdminSearchList",paging);
	}
	public ProductVO adminproductdetail(int no) {
		return mybatis.selectOne("ProductDAO.adminproductdetail", no);
	}
	public int adminproductinsert(ProductVO vo) {
		  return mybatis.insert("ProductDAO.adminproductinsert", vo);
		}
	public int adminproductdelete(int no) {
		  return mybatis.delete("ProductDAO.adminproductdelete", no);
		}
	public int adminproductcheckdelete(List<String> items) {
		  return mybatis.delete("ProductDAO.admincheckDelete", items);
		}
	public int adminproductupdate(ProductVO vo) {
		  return mybatis.update("ProductDAO.adminproductupdate", vo);
		}
	
	
	
	
}
