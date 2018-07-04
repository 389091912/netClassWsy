package com.wsy.netClass.dao;

import java.util.List;

import javax.swing.ListModel;

import com.wsy.netClass.entity.CourseType;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

public interface CourseTypeDao {

	public void insertCourseType(CourseType courseType);

	public List<CourseType> selectTopParent();

	public List<CourseType> findNowChildCourseType(CourseType courseType);

	public List<CourseType> selectCourseType(CourseType courseType);

	public CourseType selectByTypeName(CourseType courseType);

	public CourseType selectById(CourseType courseType);

	public CourseType selectTypeParentId(CourseType courseType);

	public CourseType selectParentCourseType(CourseType courseType);

	public void update(CourseType courseType);

	public void updateStatus(CourseType courseType);

	/**
	 * 根据 当前 id 查询 此节点的所有父类们
	 * @param
	 * @return
	 */

	public List<CourseType> selectParentTypeById(CourseType courseType);




}
