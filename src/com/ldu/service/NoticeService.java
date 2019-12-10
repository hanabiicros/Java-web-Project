package com.ldu.service;

import java.util.List;

import com.ldu.pojo.Notice;
import com.ldu.pojo.NoticeExtend;
import com.ldu.pojo.User;

public interface NoticeService {

	public List<Notice> getNoticeList();
	
	public void insertSelective(Notice notice);
	
	public int getNoticeNum();
	
	public List<Notice> getPageNotice(int pageNum, int pageSize);
	
	public void deleteReply(Integer id);
	
	public Notice getSpecialNotice(Integer id);
	
	public void updateSpecialNotice(Notice notice);



}
