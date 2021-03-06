package com.study.springfinal.domain;

import java.util.List;
/*
 * 부서와 사원간의 관계가 1:多 이므로, 다수의 자식을 보유한 관계를 
 * Mybatis에서는 Collection 이라고 한다
 * */
public class Dept {
	private int deptno;
	private String dname;
	private String loc;
	List<Emp> empList; //즉, 하나의 부서는 여러 가원을 소속시킬 수 있다.
	
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public List<Emp> getEmpList() {
		return empList;
	}
	public void setEmpList(List<Emp> empList) {
		this.empList = empList;
	}
}
