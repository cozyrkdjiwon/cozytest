package com.cozy.www.pay;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("pay")
public class PayController {
	@Autowired
	private PayService payService;
	
	@RequestMapping(value="admin/list",method=RequestMethod.POST)
	public @ResponseBody List<PayVO> AjaxView(@RequestParam(required=false, defaultValue="") String searchKeyword, @RequestParam(required=false, defaultValue="1") int offset, Paging paging) {
		System.out.println("admin/list post방식 이동 때 offset : "+offset);
		int page = 0;
		if(offset == 1) {
			paging.setOffset(1);
		}
		if(offset % 5 == 0) {
			page = (int)Math.floor((offset/6));
		}else {
			page = (int)Math.floor((offset/5));
		}
		paging.setPage(page);
		paging.setNowPage(offset);
		paging.setOffset(6*(paging.getOffset()-1));
		int count = payService.getPayCount(paging);
		int maxPage = 0;
		if(count % 6 == 0) {
			maxPage = count / 6; 
		}else {
			maxPage = count / 6 + 1; 
		}
		paging.setMaxPage(maxPage);
		System.out.println("페이징 VO 안에 offset 잘 담겼는지 확인 : "+paging.getOffset());
		List<PayVO> vo = payService.getPayListPage(paging);
		System.out.println("ajax 타고 잘 들어오는지 확인");
		return vo;
	}
	
	@RequestMapping("order")
	public String order(@RequestParam(value="check", required=false)int[] checks, PayVO vo, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("uid") != null) {
			vo.setUid((String) session.getAttribute("uid"));
		}else if(session.getAttribute("uid") == null && session.getAttribute("fid") != null){
			vo.setUid((String) session.getAttribute("fid"));
		}
		String checkList = "";
		for(int check : checks) {
			if(checkList.equals("")) {checkList += check;}else {checkList += ","+check;	}
		}
		List<String> items = Arrays.asList(checkList.split(","));
		List<Integer> itemList = new ArrayList<Integer>();
		for(String i : items) {
			itemList.add(Integer.parseInt(i));
		}
		System.out.println("/pay/order 안 체크 잘 들어오고 있는지"+itemList);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("itemList", itemList);
		map.put("uid", vo.getUid());
		model.addAttribute("checkList",checkList);
		System.out.println(vo.getUid());
		System.out.println(checkList.toString());
		
		if(session.getAttribute("uid") != null) {
			model.addAttribute("orderInfo", payService.getOrderInfoUID(map));
		}else if(session.getAttribute("uid") == null && session.getAttribute("fid") != null){
			model.addAttribute("orderInfo", payService.getOrderInfoFID(map));
		}
		
		return "pay/orderPage";
	}
	@RequestMapping(value="admin/list",method=RequestMethod.GET)
	public String getPayListPage(@RequestParam(required=false, defaultValue="") String searchKeyword, @RequestParam(required=false, defaultValue="1") int offset, Paging paging,  Model model) {
		System.out.println("admin/list get방식 이동 때 offset : "+offset);
		int page = 0;
		if(offset == 1) {
			paging.setOffset(1);
		}
		if(offset % 5 == 0) {
			page = (int)Math.floor((offset/6));
		}else {
			page = (int)Math.floor((offset/5));
		}
		paging.setPage(page);
		paging.setNowPage(offset);
		paging.setOffset(6*(paging.getOffset()-1));
		int count = payService.getPayCount(paging);
		int maxPage = 0;
		if(count % 6 == 0) {
			maxPage = count / 6; 
		}else {
			maxPage = count / 6 + 1; 
		}
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("payList", payService.getPayListPage(paging));
		return "pay/adminGetPayList";
	}
	@RequestMapping("/complete")
	public String payComplete(@RequestParam String checkList, HttpServletRequest request, PayVO vo, Model model) {
		HttpSession session = request.getSession();
		if(session.getAttribute("uid") != null) {
			vo.setUid((String) session.getAttribute("uid"));
		}else if(session.getAttribute("uid") == null && session.getAttribute("fid") != null){
			vo.setUid((String) session.getAttribute("fid"));
		}
		List<String> items = Arrays.asList(checkList.split(","));
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("itemList", items);
		map.put("uid", vo.getUid());
		map.put("vo", vo);
		
		if(session.getAttribute("uid") != null) {
			model.addAttribute("order", payService.insertOrderUID(map));
		}else if(session.getAttribute("uid") == null && session.getAttribute("fid") != null){
			model.addAttribute("order", payService.insertOrderFID(map));
		}
		System.out.println("insertOrder 하고 돌아옴");
		model.addAttribute("orderInfo", payService.getComplete(vo));
		payService.deleteCart(items);
		return "pay/complete";
	}
	
//	@RequestMapping("/toss")
//	public String payToss(@RequestParam String checkList, HttpServletRequest request, PayVO vo, Model model) {
//		HttpSession session = request.getSession();
//		vo.setUid((String) session.getAttribute("uid"));
//		List<String> items = Arrays.asList(checkList.split(","));
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("itemList", items);
//		map.put("uid", vo.getUid());
//		map.put("vo", vo);
//		model.addAttribute("order", payService.insertOrder(map));
//		System.out.println("insertOrder 하고 돌아옴");
//		model.addAttribute("orderInfo", payService.getComplete(vo));
//		payService.deleteCart(items);
//		return "pay/complete";
//	}
	
	@RequestMapping("/admin/delete")
	public String adminPayDelete(@RequestParam("check") String[] checks, PayVO vo, Model model) {
		System.out.println("/admin/delete 들어오는지 : " + checks);
		String checkList = "";
		for(String check : checks) {
			if(checkList.equals("")) {checkList += check;}else {checkList += ","+check;	}
		}
		List<String> items = Arrays.asList(checkList.split(","));
		payService.adminPayDelete(items);
		return "redirect:/pay/admin/list";
	}
	@RequestMapping(value="/admin/update/{merchant_uid}", method = RequestMethod.GET)
	public String adminPayUpdateForm(@PathVariable String merchant_uid, PayVO vo, Model model) {
		vo.setMerchant_uid(merchant_uid);
		model.addAttribute("payUpdateForm",payService.getComplete(vo));
		return "/pay/updateForm";
	}
	@RequestMapping(value="/admin/update/{merchant_uid}", method = RequestMethod.POST)
	public String adminPayUpdate(@PathVariable String merchant_uid, PayVO vo, Model model) {
		payService.adminPayUpdate(vo);
		model.addAttribute("payUpdateForm",payService.getComplete(vo));
		return "/pay/updateForm";
	}
	
	@RequestMapping(value = "/cancel")
	public String cancel(@RequestParam String merchant_uid, PayVO vo, Model model) {
		PaymentCheck obj = new PaymentCheck();
		String token = obj.getImportToken();
		System.out.println("token : " + token);
		vo.setMerchant_uid(merchant_uid);
		System.out.println("merchant_uid :" + vo.getMerchant_uid());
		int res = obj.cancelPayment(token, vo.getMerchant_uid());
		System.out.println("res : "+res);
		if(res == 1) {
			payService.adminUpdateCancel(vo);
		}
		model.addAttribute("payUpdateForm",payService.getComplete(vo));
		return "/pay/updateForm";
	}
	
	
}
