package com.ldu.util;

import java.util.List;

import com.ldu.pojo.Reply;

public class ReplyGrid {

	private int current;//当前页面号
    private int rowCount;//每页行数
    private int total;//总页数
    private int totalnum;//总评论数
    
    public int getCurrent() {
		return current;
	}

	@Override
	public String toString() {
		return "ReplyGrid [current=" + current + ", rowCount=" + rowCount + ", total=" + total + ", totalnum="
				+ totalnum + ", rows=" + rows + "]";
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

	public int getTotalnum() {
		return totalnum;
	}

	public void setTotalnum(int totalnum) {
		this.totalnum = totalnum;
	}

	public List<Reply> getRows() {
		return rows;
	}

	public void setRows(List<Reply> rows) {
		this.rows = rows;
	}

	private List<Reply> rows;
}
