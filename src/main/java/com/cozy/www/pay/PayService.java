package com.cozy.www.pay;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;

import com.cozy.www.user.UserVO;

public interface PayService {
	List<PayVO> getOrderInfoUID(Map<String, Object> map);
	List<PayVO> getOrderInfoFID(Map<String, Object> map);
	int insertOrderUID(Map<String, Object> map);
	int insertOrderFID(Map<String, Object> map);
	void deleteCart(List<String> items);
	List<PayVO> getComplete(PayVO vo);
	int getPayCount(Paging paging);
	List<PayVO> getPayListPage(Paging paging);
	void adminPayDelete(List<String> items);
	PayVO adminPayUpdateForm(PayVO vo);
	void adminPayUpdate(PayVO vo);
	void adminUpdateCancel(PayVO vo); 
	
	UserVO userselect(String uid);
	void paysuccess(PayVO vo);
	List<PayVO> PayMyList(PayVO vo);
	List<PayVO> PayNoList(PayVO vo);
	int payDelete(PayVO vo);
	void addrUpdate(PayVO vo);
	List<PayVO> infiniteScrollDown(PayVO vo);
	List<PayVO> infiniteScrollUp(PayVO vo);
	String getToken(HttpServletRequest request ,JSONObject json) throws Exception; 
	String payCancle(String parameter, String token);
	void stateUpdate(PayVO vo);
}
