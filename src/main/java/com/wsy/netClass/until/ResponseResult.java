package com.wsy.netClass.until;

import java.io.Serializable;

public class ResponseResult implements Serializable{
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 7320063418296581888L;

	//响应状态码
	private int responseCode;
	
	//响应信息
	private String message;
	
	//响应的返回对象
	private Object returnObject;

	public int getResponseCode() {
		return responseCode;
	}

	public void setResponseCode(int responseCode) {
		this.responseCode = responseCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getReturnObject() {
		return returnObject;
	}

	public void setReturnObject(Object returnObject) {
		this.returnObject = returnObject;
	}
	
}
