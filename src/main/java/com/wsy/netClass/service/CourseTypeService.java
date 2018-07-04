package com.wsy.netClass.service;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.entity.CourseType;
import com.wsy.netClass.exception.CourseTypeExistException;
import com.wsy.netClass.exception.CourseTypeNotFoundException;
import com.wsy.netClass.exception.CourseTypeProhibitException;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-21
 * Time: 22:08
 */
public interface CourseTypeService {

    public List<CourseType> findTopType();

    public List<CourseType> findNowChildCourseType(CourseType courseType) throws  CourseTypeNotFoundException;

    public List<CourseType> findChildCourseType(CourseType courseType);

    public List<CourseType> findCourseType(CourseType courseType);

    public PageInfo<CourseType> findParentCourseType(CourseType courseType);

    public CourseType findCourseById(CourseType courseType);

    public void modifyStatus(CourseType courseType) throws CourseTypeNotFoundException, CourseTypeExistException, CourseTypeProhibitException;

    public void addCourseType(CourseType courseType) throws CourseTypeExistException;

    public void modifyCourseType(CourseType courseType) throws CourseTypeExistException;

}
