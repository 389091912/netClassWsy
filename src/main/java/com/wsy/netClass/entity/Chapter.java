	package com.wsy.netClass.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 课程章节
 * @author soft01
 *
 */
public class Chapter implements Serializable{
		private Integer id;		//课程章节表主键
		private Integer courseId;		//课程id
		private Course course;		//课程
		private String title;		//课程章节标题
		private String info;		//课程章节简介
		private Date	createDate;		//课程章节创建时间
		private Integer status;		//0启动  1禁用
		private Resource resource; //资源
		public Chapter() {
			super();
			// TODO Auto-generated constructor stub
		}
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public Integer getCourseId() {
			return courseId;
		}
		public void setCourseId(Integer courseId) {
			this.courseId = courseId;
		}
		public Course getCourse() {
			return course;
		}
		public void setCourse(Course course) {
			this.course = course;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
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
		public Integer getStatus() {
			return status;
		}
		public void setStatus(Integer status) {
			this.status = status;
		}
		public Resource getResource() {
			return resource;
		}
		public void setResource(Resource resource) {
			this.resource = resource;
		}
		
}
