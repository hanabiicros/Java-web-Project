package com.ldu.service;

import javax.mail.MessagingException;

import org.springframework.transaction.annotation.Transactional;

public interface MailSenderSrvService {

	/*普通格式发送
	    * @recipient 收件人地址
	    * @subject 主题
	    * @content 正文
	    * */
	    @Transactional
	    void sendEmail(String recipient,String subject,String content);
	 
	    /*带抄送
	    * */
	    void sendHtmlEmail(String recipient,String subject,String content) throws MessagingException, Exception;
}
