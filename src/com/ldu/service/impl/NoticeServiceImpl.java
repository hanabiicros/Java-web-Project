package com.ldu.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.ldu.dao.NoticeMapper;
import com.ldu.pojo.Notice;
import com.ldu.pojo.NoticeExtend;
import com.ldu.pojo.User;
import com.ldu.service.NoticeService;

@Service("NoticeService")
public class NoticeServiceImpl implements NoticeService{
	 @Resource
	 private NoticeMapper noticeMapper;

	@Override
	public List<Notice> getNoticeList() {
		
		return noticeMapper.getNoticeList();
	}

	@Override
	public void insertSelective(Notice notice) {
		noticeMapper.insertSelective(notice);
		
	}
	
	public void deleteReply(Integer id) {
		noticeMapper.deleteByPrimaryKey(id);
	}
	
	public Notice getSpecialNotice(Integer id) {
		return noticeMapper.getNoticeByPrimaryKey(id);
	}
	
	public void updateSpecialNotice(Notice notice) {
		noticeMapper.updateReplyNumByPrimaryKey(notice);
	}

	public List<Notice> getPageNotice(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum,pageSize);//分页核心代码
        List<Notice> list= noticeMapper.getNoticeList();
        return list;
    }
	
	public int getNoticeNum() {
        List<Notice> notice =noticeMapper.getNoticeList();
        return notice.size();
    }

	
}
