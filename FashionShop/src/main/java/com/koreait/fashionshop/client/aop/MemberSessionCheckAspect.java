package com.koreait.fashionshop.client.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * 앞으로 로그인이 필요한 서비스 여부를 처리하기 위한 코드는 , 컨트롤러에 두지않고,
 * 지금 이 객체로 공통화시켜 AOP를 적용하겠다.
 * */

public class MemberSessionCheckAspect {
	private static final Logger logger = LoggerFactory.getLogger(MemberSessionCheckAspect.class);
	public Object sessionCheck(ProceedingJoinPoint joinPoint) {
		Object target = joinPoint.getTarget(); //원래호출하려고했던 객체
		logger.debug("원래 호출하려고했던 객체"+target);
		return null;
	}
}
