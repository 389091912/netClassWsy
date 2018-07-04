package com.wsy.netClass.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wsy.netClass.constant.Constant;
import com.wsy.netClass.constant.ResponseCodeConstant;
import com.wsy.netClass.entity.CourseType;
import com.wsy.netClass.exception.CourseTypeExistException;
import com.wsy.netClass.exception.CourseTypeNotFoundException;
import com.wsy.netClass.exception.CourseTypeProhibitException;
import com.wsy.netClass.service.CourseTypeService;
import com.wsy.netClass.until.ParameterUtil;
import com.wsy.netClass.until.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sound.midi.Soundbank;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-21
 * Time: 22:49
 */
@RequestMapping("/courseType")
@Controller
public class CourseTypeController {

    @Autowired
    private CourseTypeService courseTypeService;

    @RequestMapping("/findTopType")
    public String findAllCourseType(HttpServletRequest request, HttpServletResponse response) {
        String pageNo = request.getParameter( "pageNo" );
        String pageSize = request.getParameter( "pageSize" );
        if (ParameterUtil.isNull( pageNo )) {
            pageNo = Constant.PAGE_NO_DEFAULT;
        }
        if (ParameterUtil.isNull( pageSize )) {
            pageSize = Constant.PAGE_SIZE_DEFAULT;
        }
        PageHelper.startPage( Integer.parseInt( pageNo ), Integer.parseInt( pageSize ) );
        List<CourseType> courseTypes = courseTypeService.findTopType();

        PageInfo<CourseType> pageCourseTypes = new PageInfo<CourseType>( courseTypes );
        System.out.println( courseTypes.toString() );
        request.setAttribute( "pageTypes", pageCourseTypes );

        return "back_courseTypeSet";
    }

    @RequestMapping("/findNowChildCourseType")
    public String findNowChildCourseType(HttpServletRequest request, CourseType courseType) {
        String pageNo = request.getParameter( "pageNo" );
        String pageSize = request.getParameter( "pageSize" );
        if (ParameterUtil.isNull( pageNo )) {
            pageNo = Constant.PAGE_NO_DEFAULT;
        }
        if (ParameterUtil.isNull( pageSize )) {
            pageSize = Constant.PAGE_SIZE_DEFAULT;
        }
        PageHelper.startPage( Integer.parseInt( pageNo ), Integer.parseInt( pageSize ) );
        List<CourseType> courseTypes = null;
        PageInfo<CourseType> pageCourseTypes = null;
        try {
            courseTypes = courseTypeService.findNowChildCourseType( courseType );
            pageCourseTypes = new PageInfo<CourseType>( courseTypes );
            request.setAttribute( "pageTypes", pageCourseTypes );
            System.out.println( courseTypes.get( 0 ).toString() );
            return "back_courseTypeSet";
        } catch (CourseTypeNotFoundException e) {
            CourseType courseType1 = new CourseType();
            courseType1.setParent( courseType );
            courseTypes = new ArrayList<>();
            courseTypes.add( courseType1 );
            pageCourseTypes = new PageInfo<CourseType>( courseTypes );
            request.setAttribute( "pageTypes", pageCourseTypes );
            request.setAttribute( "parent", courseType );
            return "back_courseTypeSet";
        }
    }

    @RequestMapping("/findCourseType")
    public String findCourseType(HttpServletRequest request, CourseType courseType) {
        String pageNo = request.getParameter( "pageNo" );
        String pageSize = request.getParameter( "pageSize" );

        if (ParameterUtil.isNull( pageNo )) {
            pageNo = Constant.PAGE_NO_DEFAULT;
        }
        if (ParameterUtil.isNull( pageSize )) {
            pageSize = Constant.PAGE_SIZE_DEFAULT;
        }
        System.out.println( "courseType  :" + courseType.toString() );

        PageHelper.startPage( Integer.parseInt( pageNo ), Integer.parseInt( pageSize ) );

        List<CourseType> courseTypes = courseTypeService.findCourseType( courseType );

        PageInfo<CourseType> pageCourseTypes = new PageInfo<CourseType>( courseTypes );

        request.setAttribute( "pageTypes", pageCourseTypes );

        return "back_courseTypeSet";
    }

    @RequestMapping("/addOrModifyCourseType")
    @ResponseBody
    public ResponseResult addOrModifyCourseType(HttpServletRequest request, CourseType courseType) {
        ResponseResult result = new ResponseResult();
        System.out.println( "123   .." + courseType.toString() );
        if (courseType.getId() == null) {
            try {
                courseTypeService.addCourseType( courseType );
                result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );
                return result;
            } catch (CourseTypeExistException e) {
                e.printStackTrace();
                result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
                result.setMessage( e.getMessage() );
                return result;
            }
        }

        try {
            courseTypeService.modifyCourseType( courseType );
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );
            return result;
        } catch (CourseTypeExistException e) {
            e.printStackTrace();
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
            result.setMessage( e.getMessage() );
            return result;
        }

    }

    @RequestMapping("/findCourseTypeById")
    @ResponseBody
    public ResponseResult findCourseTypeById(HttpServletRequest request, CourseType courseType) {
        ResponseResult result = new ResponseResult();
        CourseType type = courseTypeService.findCourseById( courseType );
        result.setReturnObject( type );
        result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );

        return result;
    }
    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(HttpServletRequest request, CourseType courseType) {
        ResponseResult result = new ResponseResult();
      try {
         courseTypeService.modifyStatus( courseType );
          result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );
      } catch (CourseTypeNotFoundException e) {
          e.printStackTrace();
          result.setMessage( e.getMessage() );
          result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
      } catch (CourseTypeExistException | CourseTypeProhibitException e) {
          result.setMessage( e.getMessage() );
          result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
          e.printStackTrace();
      }
      return result;
    }

    @RequestMapping("/findParentCourseType")
    public String findParentCourseType(HttpServletRequest request, CourseType courseType) {
        PageInfo<CourseType> pageCourseTypes = courseTypeService.findParentCourseType( courseType );


        request.setAttribute( "pageTypes", pageCourseTypes );

        return "back_courseTypeSet";
    }

}
