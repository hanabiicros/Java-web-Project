package com.ldu.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ldu.dao.LoggerMapper;
import com.ldu.pojo.Logger;
import com.ldu.service.LoggerService;

@Service("loggerService")
public class LoggerServiceImpl implements LoggerService{

	@Autowired
	private LoggerMapper loggerMapper;
	
	@Override
	public void addLogger(String clazzName, String methodName) {
		// TODO Auto-generated method stub
		Logger logger = new Logger();
		logger.setMethod(methodName);
		logger.setUrl(clazzName);
		loggerMapper.insertSelective(logger);
	}

	
}
