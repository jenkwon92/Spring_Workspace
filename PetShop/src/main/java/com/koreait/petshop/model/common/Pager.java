//페이징 처리를 재사용성을 높인 클래스 정의
package com.koreait.petshop.model.common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
@Component
public class Pager {
	private List list;
	private int totalRecord ;//총 레코드 수 
	private int pageSize=10;//페이지당 보여질 레코드 수 
	private int totalPage;//총 레코드수를 페이지수로 나눠 무조건 올림
	private int blockSize=10;//플럭당 보여질 페이지 수
	private int currentPage = 1;//현재 페이지
	private int firstPage;//현재페이지와 가장 근접한 수(만약 보고있는 페이지가 18이라면 시작번호는 11부터)
	private int lastPage;//마지막 페이지 예를 들면 20, 30, 이런식 , blockSize가 10이니까
	private int curPos;//페이지당 List내에서 시작 index
	private int num ;//페이지당 시작 번호

	//선언된 변수 초기화
	public void init(HttpServletRequest request, List list) {
		this.list = list;
		totalRecord = list.size();//넘겨받은 list로 구해 온다
		totalPage = (int)Math.ceil((float)totalRecord/pageSize);
		
		//페이지를 선택한 경우엔, 그 선택된 페이지로 대체
		if(request.getParameter("currentPage")!=null) {
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}

		firstPage=currentPage-(currentPage-1)%blockSize;
		lastPage = firstPage+(blockSize-1);
		curPos=(currentPage-1)*pageSize;
		num = totalRecord-curPos;
	}
	
	public List getList() {
		return list;
	}
	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getCurPos() {
		return curPos;
	}

	public void setCurPos(int curPos) {
		this.curPos = curPos;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	
}
