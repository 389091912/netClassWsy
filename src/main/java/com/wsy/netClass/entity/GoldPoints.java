package com.wsy.netClass.entity;

import java.sql.Date;

public class GoldPoints {
	private Integer id;
	private Integer userId;
	private User user;
	private Integer pointCount;
	private Integer goldCount;
	private String info;
	private Date createDate;
	public GoldPoints() {
		super();
		// TODO Auto-generated constructor stub
	}
	public GoldPoints(Integer id, Integer userId, Integer pointCount, Integer goldCount, String info, Date createDate) {
		super();
		this.id = id;
		this.userId = userId;
		this.pointCount = pointCount;
		this.goldCount = goldCount;
		this.info = info;
		this.createDate = createDate;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getPointCount() {
		return pointCount;
	}
	public void setPointCount(Integer pointCount) {
		this.pointCount = pointCount;
	}
	public Integer getGoldCount() {
		return goldCount;
	}
	public void setGoldCount(Integer goldCount) {
		this.goldCount = goldCount;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "GoldPoints [id=" + id + ", userId=" + userId + ", pointCount=" + pointCount + ", goldCount=" + goldCount
				+ ", info=" + info + ", createDate=" + createDate + "]";
	}
	
	
	
}
