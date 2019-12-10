package com.ldu.util;

import java.util.List;

import com.ldu.pojo.Notice;


public class NoticeGrid {
	
	private int current;//当前页面号
    private int rowCount;//每页行数
    private int total;//总页数
    private int totalnum;//总评论数
    
    private List<Notice> rows;
    
    public int getTotalnum() {
		return totalnum;
	}
	public void setTotalnum(int totalnum) {
		this.totalnum = totalnum;
	}
	
    
    
	public int getCurrent() {
		return current;
	}
	public void setCurrent(int current) {
		this.current = current;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List<Notice> getRows() {
		return rows;
	}
	public void setRows(List<Notice> rows) {
		this.rows = rows;
	}
	@Override
	public String toString() {
		return "NoticeGrid [current=" + current + ", rowCount=" + rowCount + ", total=" + total + ", totalnum="
				+ totalnum + ", rows=" + rows + "]";
	}
	
    
}
