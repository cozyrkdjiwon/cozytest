package com.cozy.www.pay;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cozy.www.user.UserVO;

@Repository
public class PayDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<PayVO> getOrderInfoUID(Map<String, Object> map){
		return mybatis.selectList("PayDAO.getOrderInfoUID",map);
	}
	public List<PayVO> getOrderInfoFID(Map<String, Object> map){
		return mybatis.selectList("PayDAO.getOrderInfoFID",map);
	}
	public int insertOrderUID(Map<String, Object> map){
		return mybatis.insert("PayDAO.insertOrderUID",map);
	}
	public int insertOrderFID(Map<String, Object> map){
		return mybatis.insert("PayDAO.insertOrderFID",map);
	}
	public void deleteCart(List<String> items) {
		mybatis.delete("PayDAO.deleteCart", items);
	}
	public List<PayVO> getComplete(PayVO vo) {
		return mybatis.selectList("PayDAO.getComplete", vo);
	}
	public int getPayCount(Paging paging) {
		return mybatis.selectOne("PayDAO.getPayCount",paging);
	}
	public List<PayVO> getPayListPage(Paging paging) {
		return mybatis.selectList("PayDAO.getPayListPage",paging);
	}
	public void adminPayDelete(List<String> items) {
		mybatis.delete("PayDAO.adminPayDelete", items);
	}
	public PayVO adminPayUpdateForm(PayVO vo) {
		return mybatis.selectOne("PayDAO.adminPayUpdateForm", vo);
	}
	public void adminPayUpdate(PayVO vo) {
		mybatis.update("PayDAO.adminPayUpdate", vo);
	}
	public void adminUpdateCancel(PayVO vo) {
		mybatis.update("PayDAO.adminUpdateCancel", vo);
	}
	
	
	public void directInsert(PayVO vo) {
		mybatis.insert("PayDAO.directInsert", vo);
	}
	public UserVO userselect(String uid) {
		return mybatis.selectOne("PayDAO.userselect", uid);
	}
	public void paysuccess(PayVO vo) {
		mybatis.insert("PayDAO.paysuccess", vo);
	}
	public List<PayVO> payMyList(PayVO vo){
		return mybatis.selectList("PayDAO.payMyList", vo);
	}
	public List<PayVO> payNoList(PayVO vo) {
		return mybatis.selectList("PayDAO.payNoList", vo); 
	}
	public int payDelete(PayVO vo) {
		return mybatis.delete("PayDAO.payDelete", vo);
	}
	public void addrUpdate(PayVO vo) {
		mybatis.update("PayDAO.addrUpdate", vo);
	}
	public List<PayVO> infiniteScrollDown(PayVO vo) {
		return mybatis.selectList("PayDAO.infiniteScrollDown", vo);
	}
	public List<PayVO> infiniteScrollUp(PayVO vo) {
		return mybatis.selectList("PayDAO.infiniteScrollUp", vo);
	}
	public void stateUpdate(PayVO vo) {
		mybatis.update("PayDAO.stateUpdate", vo);
	} 

}
