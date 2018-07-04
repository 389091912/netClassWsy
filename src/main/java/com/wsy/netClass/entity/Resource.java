package com.wsy.netClass.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 资源
 * @author soft01
 *
 */
public class Resource  implements Serializable{
		/**
	 * 
	 */
	private static final long serialVersionUID = -4179823606495462468L;
		private Integer id;		//资源主键
		private String title;		//资源标题
		private String path;	//资源相对路径
		private String coverImageUrl;	//资源封面图片地址
		private String originalName;		//文件原始名
		private long fileSize;			//文件大小(字节)
	private String fileSizeStr;			//文件大小String
		private String fileType;			//文件类型
		private Integer clickCount; 		//点击量
		private Date	createDate;		//上传时间
		private Integer costType;	//0积分  1金币
		private Integer costNumber;		// 需要扣除的积分/金币
		private Integer userId;		//上传用户ID
		private User user;
		private Integer chapterId;	//章节ID
		private Chapter chapter; 
		private Integer status;		//0启动 1禁用
	   private String createDateStr;   //文件上传时间

		private String  createEndDate;
		
		private String createStartDate;
		
		public Resource() {
			super();
			// TODO Auto-generated constructor stub
		}
		
		
		public Resource(Integer id, String title, String path, String coverImageUrl, String originalName,
				Integer fileSize, String fileType, Integer clickCount, Date createDate, Integer costType,
				Integer costNumber, Integer userId, Integer chapterId, Integer status) {
			super();
			this.id = id;
			this.title = title;
			this.path = path;
			this.coverImageUrl = coverImageUrl;
			this.originalName = originalName;
			this.fileSize = fileSize;
			this.fileType = fileType;
			this.clickCount = clickCount;
			this.createDate = createDate;
			this.costType = costType;
			this.costNumber = costNumber;
			this.userId = userId;
			this.chapterId = chapterId;
			this.status = status;
		}


		public String getCreateEndDate() {
			return createEndDate;
		}
		public void setCreateEndDate(String createEndDate) {
			this.createEndDate = createEndDate;
		}
		public String getCreateStartDate() {
			return createStartDate;
		}
		public void setCreateStartDate(String createStartDate) {
			this.createStartDate = createStartDate;
		}
	
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getPath() {
			return path;
		}
		public void setPath(String path) {
			this.path = path;
		}
		public String getCoverImageUrl() {
			return coverImageUrl;
		}
		public void setCoverImageUrl(String coverImageUrl) {
			this.coverImageUrl = coverImageUrl;
		}
		public String getOriginalName() {
			return originalName;
		}
		public void setOriginalName(String originalName) {
			this.originalName = originalName;
		}
		public long getFileSize() {
			return fileSize;
		}
		public void setFileSize(long fileSize) {
			this.fileSize = fileSize;
		}
		public String getFileType() {
			return fileType;
		}
		public void setFileType(String fileType) {
			this.fileType = fileType;
		}
		public Integer getClickCount() {
			return clickCount;
		}
		public void setClickCount(Integer clickCount) {
			this.clickCount = clickCount;
		}
		public Date getCreateDate() {
			return createDate;
		}
		public void setCreateDate(Date createDate) {
			this.createDate = createDate;
		}
		public Integer getCostType() {
			return costType;
		}
		public void setCostType(Integer costType) {
			this.costType = costType;
		}
		public Integer getCostNumber() {
			return costNumber;
		}
		public void setCostNumber(Integer costNumber) {
			this.costNumber = costNumber;
		}
		public Integer getUserId() {
			return userId;
		}
		public void setUserId(Integer userId) {
			this.userId = userId;
		}
		public User getUser() {
			return user;
		}
		public void setUser(User user) {
			this.user = user;
		}
		public Integer getChapterId() {
			return chapterId;
		}
		public void setChapterId(Integer chapterId) {
			this.chapterId = chapterId;
		}
		public Chapter getChapter() {
			return chapter;
		}
		public void setChapter(Chapter chapter) {
			this.chapter = chapter;
		}
		public Integer getStatus() {
			return status;
		}
		public void setStatus(Integer status) {
			this.status = status;
		}


	public String getCreateDateStr() {
		return createDateStr;
	}

	public void setCreateDateStr(String createDateStr) {
		this.createDateStr = createDateStr;
	}

	public String getFileSizeStr() {
		return fileSizeStr;
	}

	public void setFileSizeStr(String fileSizeStr) {
		this.fileSizeStr = fileSizeStr;
	}

	@Override
	public String toString() {
		return "Resource{" +
				"id=" + id +
				", title='" + title + '\'' +
				", path='" + path + '\'' +
				", coverImageUrl='" + coverImageUrl + '\'' +
				", originalName='" + originalName + '\'' +
				", fileSize=" + fileSize +
				", fileType='" + fileType + '\'' +
				", clickCount=" + clickCount +
				", createDate=" + createDate +
				", costType=" + costType +
				", costNumber=" + costNumber +
				", userId=" + userId +
				", user=" + user +
				", chapterId=" + chapterId +
				", chapter=" + chapter +
				", status=" + status +
				", createDateStr='" + createDateStr + '\'' +
				", createEndDate='" + createEndDate + '\'' +
				", createStartDate='" + createStartDate + '\'' +
				'}';
	}
}
