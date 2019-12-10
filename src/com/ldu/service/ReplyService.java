package com.ldu.service;

import java.util.List;

import com.ldu.pojo.Reply;

public interface ReplyService {
	
	List<Reply> getInUserReplyList(); 
	
	public void insertInUserSelective(Reply reply);
	
	public void deleteUnderUserReply(Integer commentId);
	
	public int getInUserReplyNum();
	
	public void deleteMyReply(Integer id);
	
	public List<Reply> getPageInUserReply(int pageNum, int pageSize);
}
