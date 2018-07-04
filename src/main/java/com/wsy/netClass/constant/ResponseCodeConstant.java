package com.wsy.netClass.constant;

/**
 * json对象处理时的响应状态码
 * 0:成功
 * 1:失败
 * 2:登录失效
 * 3:请求参数有误
 * 4:权限不足
 * @author User
 *
 */
public interface ResponseCodeConstant {
	
	/**
	 * 响应状态码为成功，值为：0
	 */
	public static final int RESPONSE_CODE_SUCCESS = 0;
	
	
	/**
	 * 响应状态码为失败，值为：1
	 */
	public static final int RESPONSE_CODE_FAIL = 1;
	
	
	/**
	 * 响应状态码为登录失效，值为：2
	 */
	public static final int RESPONSE_CODE_LOGIN_DISBALE = 2;
	
	
	/**
	 * 响应状态码为请求参数有误，值为：3
	 */
	public static final int RESPONSE_CODE_REQUEST_PARAMTER_ERROR = 3;
	
	
	/**
	 * 响应状态码为权限不足，值为：4
	 */
	public static final int RESPONSE_CODE_NO_PROMISSION = 4;
	
	
	
	

}
