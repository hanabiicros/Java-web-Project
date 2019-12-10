package com.ldu.dao;

import java.util.List;

import com.ldu.pojo.Reply;

public interface ReplyMapper {
    int deleteByCommentId(Integer commentId);
    
    int insertSelective(Reply record);
    
    

    int insertInUserSelective(Reply record);

    List<Reply> getInUserReplyList();
    List<Reply> getInUserSpecialCommentReplyList(Integer commentId);

    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(Reply record);

    int updateByPrimaryKeyWithBLOBs(Reply record);

    int updateByPrimaryKey(Reply record);
}