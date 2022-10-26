package com.cozy.www.pay;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cozy.www.user.UserVO;
@Service("payService")
public class PayServiceImpl implements PayService{
	@Autowired
	private PayDAO payDAO;

	@Override
	public List<PayVO> getOrderInfoUID(Map<String, Object> map) {
		return payDAO.getOrderInfoUID(map);
	}
	@Override
	public List<PayVO> getOrderInfoFID(Map<String, Object> map) {
		return payDAO.getOrderInfoFID(map);
	}
	@Override
	public int insertOrderUID(Map<String, Object> map) {
		return payDAO.insertOrderUID(map);
	}
	@Override
	public int insertOrderFID(Map<String, Object> map) {
		return payDAO.insertOrderFID(map);
	}
	@Override
	public void deleteCart(List<String> items) {
		payDAO.deleteCart(items);
	}
	@Override
	public List<PayVO> getComplete(PayVO vo) {
		return payDAO.getComplete(vo);
	}
	@Override
	public int getPayCount(Paging paging) {
		return payDAO.getPayCount(paging);
	}
	@Override
	public List<PayVO> getPayListPage(Paging paging) {
		return payDAO.getPayListPage(paging);
	}
	@Override
	public void adminPayDelete(List<String> items) {
		payDAO.adminPayDelete(items);
	}

	@Override
	public PayVO adminPayUpdateForm(PayVO vo) {
		return  payDAO.adminPayUpdateForm(vo);
	}
	@Override
	public void adminPayUpdate(PayVO vo) {
		payDAO.adminPayUpdate(vo);
	}
	@Override
	public void adminUpdateCancel(PayVO vo) {
		payDAO.adminUpdateCancel(vo);
	}
	
	
	@Override
	public UserVO userselect(String uid) {
		return payDAO.userselect(uid);
	}
	@Override
	public void paysuccess(PayVO vo) {
		payDAO.paysuccess(vo);
	}
	@Override
	public List<PayVO> PayMyList(PayVO vo){
		return payDAO.payMyList(vo);
	}
	@Override
	public List<PayVO> PayNoList(PayVO vo) {
		return payDAO.payNoList(vo);
	}
	@Override
	public int payDelete(PayVO vo) {
		return payDAO.payDelete(vo);
	}
	@Override
	public void addrUpdate(PayVO vo) {
		payDAO.addrUpdate(vo);
	}
	@Override
	public List<PayVO> infiniteScrollDown(PayVO vo){
		return payDAO.infiniteScrollDown(vo);
	}
	@Override
	public List<PayVO> infiniteScrollUp(PayVO vo){
		return payDAO.infiniteScrollUp(vo);
	}
	@Override
	public String getToken(HttpServletRequest request ,JSONObject json)throws Exception {
		String _token = "";
		try{
		String requestString = "";
		URL url = new URL("https://api.iamport.kr/users/getToken");
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setDoOutput(true);
		connection.setInstanceFollowRedirects(false);
		connection.setRequestMethod("POST");
		connection.setRequestProperty("Content-Type", "application/json");
		OutputStream os= connection.getOutputStream();
		os.write(json.toString().getBytes());
		connection.connect();
		StringBuilder sb = new StringBuilder();
		if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
		BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
		String line = null;
		while ((line = br.readLine()) != null) {
		sb.append(line + "\n");
		}
		br.close();
		requestString = sb.toString();
		}
		os.flush();
		connection.disconnect();
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
		if((Long)jsonObj.get("code") == 0){
		JSONObject getToken = (JSONObject) jsonObj.get("response");

		System.out.println("getToken==>>"+getToken.get("access_token") );
		_token = (String)getToken.get("access_token");
		}
		}catch(Exception e){
		e.printStackTrace();
		_token = "";
		}
		return _token;

		}

	@Override
	public String payCancle(String parameter, String token) {
		try {
			URL url = new URL("https://api.iamport.kr/payments/cancel"); //주소	
			HttpURLConnection connection = (HttpURLConnection) url.openConnection(); //서버 연결
			connection.setRequestMethod("POST");
			connection.setDoOutput(true);
			connection.setRequestProperty("Content-Type", "application/json;");
			connection.setRequestProperty("Authorization", token);
			OutputStream os= connection.getOutputStream(); //주는 애
			DataOutputStream dos = new DataOutputStream(os); //데이터 주는 애
			dos.write(parameter.getBytes());
			System.out.println(parameter);
			dos.close();//닫으면서 넘겨줌
			
			int resultCode = connection.getResponseCode(); //연결결과
			InputStream ips; // 받는 애
			if(resultCode == 200) {ips = connection.getInputStream();}
			else {ips = connection.getErrorStream();}
			InputStreamReader isr = new InputStreamReader(ips); //읽어주는 애
			BufferedReader bfr = new BufferedReader(isr); // 형 변환하는 애
			System.out.println(bfr.readLine());
			return bfr.readLine();
			}
			catch(Exception e) {e.printStackTrace();
			return "데이터 없음";}
		}
	@Override
	public void stateUpdate(PayVO vo) {
		payDAO.stateUpdate(vo);
	}
	
}
