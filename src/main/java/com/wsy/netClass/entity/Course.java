package com.wsy.netClass.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 课程
 * @author soft01
 *
 */
public class Course  implements Serializable{
		/**
	 * 
	 */
	private static final long serialVersionUID = -28113261177785757L;
		private Integer id;		//课程主键
		private String courseName;		//课程名称
		private String courseInfo;		//课程简介
		private String author;		//课程作者
		private String coverImageUrl;	//课程封面图片 相对路径
		private Date	createDate;		//k课程发布时间
		private Integer clickNumber;		//课程点击量
		private Integer status;		//课程状态
		private Integer recommendationGrade;		//课程推荐等级  0普通 1 推荐
		private Integer courseTypeId;		//所属的课程类别 id
		private CourseType courseType;		//课程类别
		public Course() {
			super();
			// TODO Auto-generated constructor stub
		}
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getCourseName() {
			return courseName;
		}
		public void setCourseName(String courseName) {
			this.courseName = courseName;
		}
		public String getCourseInfo() {
			return courseInfo;
		}
		public void setCourseInfo(String courseInfo) {
			this.courseInfo = courseInfo;
		}
		public String getAuthor() {
			return author;
		}
		public void setAuthor(String author) {
			this.author = author;
		}
		public String getCoverImageUrl() {
			return coverImageUrl;
		}
		public void setCoverImageUrl(String coverImageUrl) {
			this.coverImageUrl = coverImageUrl;
		}
		public Date getCreateDate() {
			return createDate;
		}
		public void setCreateDate(Date createDate) {
			this.createDate = createDate;
		}
		public Integer getClickNumber() {
			return clickNumber;
		}
		public void setClickNumber(Integer clickNumber) {
			this.clickNumber = clickNumber;
		}
		public Integer getStatus() {
			return status;
		}
		public void setStatus(Integer status) {
			this.status = status;
		}
		public Integer getRecommendationGrade() {
			return recommendationGrade;
		}
		public void setRecommendationGrade(Integer recommendationGrade) {
			this.recommendationGrade = recommendationGrade;
		}
		public Integer getCourseTypeId() {
			return courseTypeId;
		}
		public void setCourseTypeId(Integer courseTypeId) {
			this.courseTypeId = courseTypeId;
		}
		public CourseType getCourseType() {
			return courseType;
		}
		public void setCourseType(CourseType courseType) {
			this.courseType = courseType;
		}
		@Override
		public String toString() {
			return "Course [id=" + id + ", courseName=" + courseName
					+ ", courseInfo=" + courseInfo + ", author=" + author
					+ ", coverImageUrl=" + coverImageUrl + ", createDate="
					+ createDate + ", clickNumber=" + clickNumber + ", status="
					+ status + ", recommendationGrade=" + recommendationGrade
					+ ", courseTypeId=" + courseTypeId + ", courseType="
					+ courseType + "]";
		}
		
		
		
		
}
