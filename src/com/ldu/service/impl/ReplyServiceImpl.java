package com.ldu.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.ldu.dao.ReplyMapper;
import com.ldu.pojo.Reply;
import com.ldu.service.ReplyService;

@Service("ReplyService")
public class ReplyServiceImpl implements ReplyService {

	@Resource
	ReplyMapper replyMapper;

	@Override
	public List<Reply> getInUserReplyList() {
		
		return replyMapper.getInUserReplyList();
	}

	@Override
	public void insertInUserSelective(Reply reply) {
		replyMapper.insertInUserSelective(reply);
		
	}
	
	public void deleteMyReply(Integer id) {
		replyMapper.deleteByPrimaryKey(id);
	}
	
	public void deleteUnderUserReply(Integer commentId) {
		replyMapper.deleteByCommentId(commentId);
	}

	public List<Reply> getPageInUserReply(int pageNum, int pageSize) {
       PageHelper.startPage(pageNum,pageSize);//分页核心代码
       List<Reply> list= replyMapper.getInUserReplyList();
       return list;
   }
	
	public int getInUserReplyNum() {
       List<Reply> reply =replyMapper.getInUserReplyList();
       return reply.size();
   }
}
