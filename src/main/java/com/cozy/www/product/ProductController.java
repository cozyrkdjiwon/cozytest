package com.cozy.www.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("product")
public class ProductController {
	@Autowired
	private ProductService productService;

	@RequestMapping(value="list/{div1}",method=RequestMethod.POST)
	public @ResponseBody List<ProductVO> AjaxView(@PathVariable String div1,@RequestParam(required=false, defaultValue="") String searchKeyword, @RequestParam(required=false, defaultValue="1") int offset, Paging paging) {
		System.out.println("list/{div1}");
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
		paging.setSearchKeyword(searchKeyword);
		System.out.println(paging.getSearchKeyword());
		int count = productService.getDivCount(paging);
		int maxPage = 0;
		if(count % 6 == 0) {
			maxPage = count / 6; 
		}else {
			maxPage = count / 6 + 1; 
		}
		paging.setMaxPage(maxPage);
		System.out.println("페이징 VO 안에 offset 잘 담겼는지 확인 : "+paging.getOffset());
		System.out.println("페이징 div1 잘 담겼는지 확인 : "+paging.getDiv1());
		System.out.println("페이징 div2 잘 담겼는지 확인 : "+paging.getDiv2());
		List<ProductVO> vo = productService.getProductListPage(paging);
		System.out.println("ajax 타고 잘 들어오는지 확인");
		return vo;
	}
	
	
	@RequestMapping(value="list/{div1}",method=RequestMethod.GET)
	public String getBoardList(@PathVariable String div1, @RequestParam(required=false, defaultValue="1") int offset, Paging paging,  Model model) {
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
		int count = productService.getDivCount(paging);
		int maxPage = 0;
		if(count % 6 == 0) {
			maxPage = count / 6; 
		}else {
			maxPage = count / 6 + 1; 
		}
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("productList", productService.getProductListPage(paging));
		return "product/getProductList";
	}
	@RequestMapping(value="list/{div1}/{div2}",method=RequestMethod.POST)
	public @ResponseBody List<ProductVO> AjaxViewDiv2(@PathVariable String div1,@RequestParam(required=false, defaultValue="") String searchKeyword, @RequestParam(required=false, defaultValue="1") int offset, Paging paging) {
		System.out.println("list/{div1}/{div2}");
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
		int count = productService.getDiv2Count(paging);
		int maxPage = 0;
		if(count % 6 == 0) {
			maxPage = count / 6; 
		}else {
			maxPage = count / 6 + 1; 
		}
		paging.setMaxPage(maxPage);
		System.out.println("페이징 VO 안에 offset 잘 담겼는지 확인 : "+paging.getOffset());
		System.out.println("페이징 div1 잘 담겼는지 확인 : "+paging.getDiv1());
		System.out.println("페이징 div2 잘 담겼는지 확인 : "+paging.getDiv2());
		List<ProductVO> vo = productService.getBoardListDiv2(paging);
		System.out.println("ajax 타고 잘 들어오는지 확인");
		return vo;
	}
	@RequestMapping(value="list/{div1}/{div2}",method=RequestMethod.GET)
	public String getBoardListDiv2(@PathVariable String div1, @PathVariable String div2, @RequestParam(required=false, defaultValue="1") int offset, Paging paging,  Model model) {
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
		int count = productService.getDiv2Count(paging);
		int maxPage = 0;
		if(count % 6 == 0) {
			maxPage = count / 6; 
		}else {
			maxPage = count / 6 + 1; 
		}
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("productList", productService.getBoardListDiv2(paging));
		return "product/getProductList";
	}
	@RequestMapping("search/{offset}")
	public String getSearchList(@RequestParam(required=false, defaultValue="") String searchKeyword, @PathVariable int offset, Paging paging, Model model) {
		int page = 0;
		if(offset % 5 == 0) {
			page = (int)Math.floor((offset/6));
		}else {
			page = (int)Math.floor((offset/5));
		}
		paging.setPage(page);
		paging.setNowPage(offset);
		paging.setOffset(6*(paging.getOffset()-1));
		int count = productService.getSearchCount(paging);
		int maxPage = 0;
		if(count % 6 == 0) {
			maxPage = count / 6; 
		}else {
			maxPage = count / 6 + 1; 
		}
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("productList", productService.getSearchList(paging));
		return "product/getProductList";
	}
		
}
