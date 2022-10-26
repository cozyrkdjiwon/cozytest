package com.cozy.www.pay;

public class Paging {
	private int limit;
	private int offset;
	private int page;
	private int nowPage;
	private int maxPage;
	private String searchKeyword;
	
	
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	
	
	
}
