package com.wsy.netClass.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.prism.shader.Solid_TextureYV12_AlphaTest_Loader;
import com.wsy.netClass.constant.Constant;
import com.wsy.netClass.dao.CourseTypeDao;
import com.wsy.netClass.entity.CourseType;
import com.wsy.netClass.exception.CourseTypeExistException;
import com.wsy.netClass.exception.CourseTypeNotFoundException;
import com.wsy.netClass.exception.CourseTypeProhibitException;
import com.wsy.netClass.service.CourseTypeService;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-21
 * Time: 22:12
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class CourseTypeServiceImpl implements CourseTypeService {

    @Autowired
    private CourseTypeDao courseTypeDao;


    @Override
    public List<CourseType> findTopType() {
        return courseTypeDao.selectTopParent();
    }

    @Override
    public List<CourseType> findNowChildCourseType(CourseType courseType) throws CourseTypeNotFoundException {
        List<CourseType> childrenLists = courseTypeDao.findNowChildCourseType( courseType );

        if (childrenLists.size() == 0) {
            System.out.println( "子类为空，请添加..." );

            throw new CourseTypeNotFoundException( "子类为空，请添加内容" );
        }
        return childrenLists;
    }

    @Override
    public List<CourseType> findChildCourseType(CourseType courseType) {
        return courseTypeDao.findNowChildCourseType( courseType );
    }

    @Override
    public List<CourseType> findCourseType(CourseType courseType) {
        List<CourseType> childrenLists = courseTypeDao.selectCourseType( courseType );
        if (childrenLists.size() == 0) {
            System.out.println( "子类为空，请添加...." );
            CourseType type = new CourseType();
            CourseType courseType1 = new CourseType();
            courseType1.setId( courseType.getParentId() );
            type.setParent( courseType1 );
            System.out.println( "type:" + type.toString() );
            childrenLists.add( type );
        }
        return childrenLists;
    }


    @Override
    public PageInfo<CourseType> findParentCourseType(CourseType courseType) {

        CourseType selectById = courseTypeDao.selectTypeParentId( courseType );
        System.out.println( selectById.toString() );



        PageHelper.startPage( Integer.parseInt( Constant.PAGE_NO_DEFAULT ), Constant.PAGE_SIZE );
        List<CourseType> courseTypes = courseTypeDao.selectParentTypeById( selectById );
        PageInfo<CourseType> pageCourseTypes = new PageInfo<CourseType>( courseTypes );

        return pageCourseTypes;
    }

    @Override
    public CourseType findCourseById(CourseType courseType) {
        return courseTypeDao.selectById( courseType );
    }


    @Override
    public void modifyStatus(CourseType courseType) throws CourseTypeNotFoundException, CourseTypeProhibitException {

        CourseType resultCourseType = courseTypeDao.selectById( courseType );
        Integer status = resultCourseType.getStatus();
        if (status == Constant.STATUS_ENABLE) {
            resultCourseType.setStatus( Constant.STATUS_DISABLE );
            courseTypeDao.updateStatus( resultCourseType );

            List<CourseType> sonCourseType = findSonCourseType( resultCourseType );
            for (CourseType courseType1 : sonCourseType) {
                courseType1.setStatus( Constant.STATUS_DISABLE );
                courseTypeDao.updateStatus( courseType1 );

            }

        } else {
            if (resultCourseType.getParentId() != null) {

                CourseType parentCourseType = courseTypeDao.selectParentCourseType( resultCourseType );
                if (parentCourseType.getStatus() == Constant.STATUS_DISABLE) {
                    throw new CourseTypeProhibitException("上级部门被禁用，无法启用子部门");
                }
            }
            resultCourseType.setStatus( Constant.STATUS_ENABLE );
            courseTypeDao.updateStatus( resultCourseType );
        }


    }

    @Override
    public void addCourseType(CourseType courseType) throws CourseTypeExistException {

        CourseType type = courseTypeDao.selectByTypeName( courseType );
        if (type != null) {
            throw new CourseTypeExistException( "课程类别已存在" );
        }
        courseType.setStatus( Constant.STATUS_ENABLE );
        courseTypeDao.insertCourseType( courseType );

    }

    @Override
    public void modifyCourseType(CourseType courseType) throws CourseTypeExistException {
        CourseType type = courseTypeDao.selectByTypeName( courseType );
        if (type != null) {
            throw new CourseTypeExistException( "课程类别已存在" );
        }
        courseTypeDao.update( courseType );
    }

    public List<CourseType> findSonCourseType(CourseType courseType) {

        List<CourseType> courseTypeList = new ArrayList<>();

        List<CourseType> type = courseTypeDao.findNowChildCourseType( courseType );
        if (type.size() != 0) {
            courseTypeList.addAll( type );
            for (CourseType course : type) {
                List<CourseType> sonCourseType = findChildCourseType( course );
                if (sonCourseType.size() != 0) {
                    courseTypeList.addAll( sonCourseType );
                }
            }
        }
        return courseTypeList;
    }
}
