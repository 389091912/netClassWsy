package com.wsy.netClass.until;

public class AjaxResult {
	/**
	 * 响应状态 是否成功
	 */
	private boolean success;
	/**
	 * 响应信息
	 */
	private String msg;
	private Object obj;
	public AjaxResult(boolean success, String msg, Object obj) {
		this.success = success;
		this.msg = msg;
		this.obj = obj;
	}
	public AjaxResult() {
	}
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	
}
