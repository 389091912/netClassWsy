package com.wsy.netClass.entity;

import java.io.Serializable;
import java.util.Date;

public class UserResource implements Serializable{
		/**
	 * 
	 */
	private static final long serialVersionUID = 8900523870939334188L;
		private Integer id;
		private Integer userId;
		private Integer resourceId;
    private Resource resource;
		private Date createDate;
		private Date updateDate;
		private String updateDateStr;
		public UserResource() {
			super();
			// TODO Auto-generated constructor stub
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
		public Integer getResourceId() {
			return resourceId;
		}
		public void setResourceId(Integer resourceId) {
			this.resourceId = resourceId;
		}
		public Date getCreateDate() {
			return createDate;
		}
		public void setCreateDate(Date createDate) {
			this.createDate = createDate;
		}
		public Date getUpdateDate() {
			return updateDate;
		}
		public void setUpdateDate(Date updateDate) {
			this.updateDate = updateDate;
		}

    public Resource getResource() {
        return resource;
    }

    public void setResource(Resource resource) {
        this.resource = resource;
    }


	public String getUpdateDateStr() {
		return updateDateStr;
	}

	public void setUpdateDateStr(String updateDateStr) {
		this.updateDateStr = updateDateStr;
	}

	@Override
	public String toString() {
		return "UserResource{" +
				"id=" + id +
				", userId=" + userId +
				", resourceId=" + resourceId +
				", createDate=" + createDate +
				", updateDate=" + updateDate +
				'}';
	}
}
