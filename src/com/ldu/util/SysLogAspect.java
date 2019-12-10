package com.ldu.util;

import java.lang.reflect.Method;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ldu.service.LoggerService;

@Aspect
@Component
public class SysLogAspect {

	@Autowired
	private LoggerService loggerService;
	
	//声明一个日志对象
	private static final Logger logger = Logger.getLogger(SysLogAspect.class);
	
	@Pointcut("@annotation(com.ldu.util.OperationLogger")
	public void controllerAspect() {
		System.out.println("我是一个切入点");
	}
	
	//前置通知
	@Before("controllerAspect()")
	public void doBefore(JoinPoint joinPoint)
	{
		System.out.println("=====SysLogAspect前置通知开始=====");
		handleLog(joinPoint,null);
	}
	
	//后置通知
	@AfterReturning(pointcut="controllerAspect()")
	public void doAfter(JoinPoint joinPoint)
	{
		System.out.println("=====SysLogAspect后置通知开始=====");
		handleLog(joinPoint,null);
		
	}
	
	@AfterThrowing(value = "controllerAspect()",throwing = "e")
	public void doAfter(JoinPoint joinPoint,Exception e)
	{
		System.out.println("=====SysLogAspect异常通知开始=====");
		handleLog(joinPoint,null);
	}
	
	
	@Around("controllerAspect()")
	public Object daAround(ProceedingJoinPoint joinPoint)
	{
		Object proceed = null;
		System.out.println("=====SysLogAspect环绕通知开始=====");
		
		handleLog(joinPoint,null);
		
		try {
			proceed = joinPoint.proceed();
			return proceed;
		}catch(Throwable throwable) {
			throwable.printStackTrace();
		}
		return null;
	}
	
	//日志处理方法
	private void handleLog(JoinPoint joinPoint,Exception e)
	{
		try {
			OperationLogger logger = giveController(joinPoint);
			
			if(logger == null) {
				return;
			}
			//获取目标方法的签名
			String signature = joinPoint.getSignature().toString();
			//根据签名去截取方法名
			String methodName = signature.substring(signature.lastIndexOf(".")+1,signature.indexOf("("));
			//StaticPart getStaticPart();
			String longTemp = joinPoint.getStaticPart().toLongString();
			
			//再通过得到调用方法的目标对象，从而获取它的类名
			String classType = joinPoint.getTarget().getClass().getName();
			//再通过反射来得到这个类对象
			Class<?> clazz = Class.forName(classType);
			//得到它内部所有的方法
			Method[] methods = clazz.getDeclaredMethods();
			System.out.println("methodName: " + methodName);
			//对得到的方法集合进行变脸
			for (Method method : methods)
			{

			//如果以这个方法上面的注解值日志注解并且方法的名称是之前截取到的方法名
			if (method.isAnnotationPresent(OperationLogger.class)&& method.getName().equals(methodName))
			{

			//这个时候就可以通过这个方法去获取其上面的注解
		//我们将获取主借注解的功能封装成一个方法，将之前反射得到的类对象当作参数传递过去
		 String clazzName = clazz.getName();
			System.out.println("clazzName: " + clazzName + ", methodName: "+ methodName);

			//调用方法，在这里实现的就是对方法的遍历
			String process = SysLogAspect.process(clazz);

			//这里就调用我们的服务层去将得到的数据写入数据库
			loggerService.addLogger(process,methodName);
			}
			}
		} catch (Exception exp)
			{
			 logger.error("异常信息:{}", exp);
			 exp.printStackTrace();
			}
		}
	
	private static OperationLogger giveController(JoinPoint joinPoint) throws Exception
	{
		Signature signature = joinPoint.getSignature();
		
		MethodSignature methodSignature = (MethodSignature) signature;
		Method method = methodSignature.getMethod();
		
		if(method!=null) {
			return method.getAnnotation(OperationLogger.class);
		}
		return null;
	}
	
	public static String process(Class clazz) {
		String modelName = null;
		Method[] methods = clazz.getMethods();
		
		for(Method method:methods) {
			OperationLogger annotation = method.getAnnotation(OperationLogger.class);//获取指定类型的注解
			
			if(annotation!=null) {
				modelName = annotation.modelName();
				String user = annotation.user();
			}
		}
		return modelName;
	}

}
	

