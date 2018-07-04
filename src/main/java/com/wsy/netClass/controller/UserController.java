package com.wsy.netClass.controller;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.constant.ResponseCodeConstant;
import com.wsy.netClass.entity.GoldPoints;
import com.wsy.netClass.entity.User;
import com.wsy.netClass.exception.UserExistException;
import com.wsy.netClass.exception.UserNotFoundException;
import com.wsy.netClass.exception.UserRoleException;
import com.wsy.netClass.exception.UserStatusException;
import com.wsy.netClass.service.GoldPointsService;
import com.wsy.netClass.service.UserService;
import com.wsy.netClass.until.CommonUtil;
import com.wsy.netClass.until.ResponseResult;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-21
 * Time: 9:33
 */
@Controller
@RequestMapping("/user")
public class UserController {


    @Autowired
    private UserService userService;

    @Autowired
    private GoldPointsService goldPointsService;

    @RequestMapping("/back/backLogin")
    public String backLogin(HttpServletRequest request, User user) {
        try {
            BeanUtils.populate( user, request.getParameterMap() );
            System.out.println("User  对象"+user);

            User resultUser = userService.backLogin( user.getUsername(), user.getPassword() );

            request.getSession().setAttribute( "user", resultUser );

            System.out.println("结果："+resultUser);
            return "redirect:/backMain";

        } catch (IllegalAccessException e) {
            request.setAttribute( "loginMsg", e.getMessage() );
        } catch (InvocationTargetException | UserStatusException | UserNotFoundException | UserRoleException e) {
            e.printStackTrace();
            request.setAttribute( "loginMsg", e.getMessage() );
        }
        return "back_login";
    }

    @RequestMapping("/frontLogin")
    public String frontLogin(HttpServletRequest request, User user) {
        try {
            BeanUtils.populate( user, request.getParameterMap() );

            System.out.println("............User  对象"+user);

            User resultUser = userService.frontLogin( user.getUsername(), user.getPassword() );

            GoldPoints goldPoints = new GoldPoints();

            goldPoints.setUserId( resultUser.getId() );

            GoldPoints pointAndGold = goldPointsService.findPointAndGold( goldPoints );

            request.getSession().setAttribute( "user", resultUser );

            request.getSession().setAttribute( "goldPoint", pointAndGold );

            System.out.println("结果："+resultUser);
            return "front_index";

        } catch (IllegalAccessException e) {
            request.setAttribute( "loginMsg", e.getMessage() );
        } catch (InvocationTargetException | UserStatusException | UserNotFoundException | UserRoleException e) {
            e.printStackTrace();
            request.setAttribute( "loginMsg", e.getMessage() );
        }
        return "front_index";
    }

    @RequestMapping("/loginOut")
    public String loginOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(null != user){
            session.removeAttribute("user");
        }
        session.invalidate();//使session无效
        return "redirect:/backLogin";//(相对路径重定向)
    }

    @RequestMapping("/register")
    @ResponseBody
    public ResponseResult register(HttpServletRequest request, User user) {

        ResponseResult result = new ResponseResult();

        System.out.println( user.toString() );

        try {
            userService.addUser( user );
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );
        } catch (UserExistException e) {
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
             result.setMessage( e.getMessage() );
            e.printStackTrace();
        }

        return result;
}


    @RequestMapping("/front/loginOut")
    public String frontLoginOut(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(null != user){
            session.removeAttribute("user");
        }
        session.invalidate();//使session无效
        return "redirect:/front_index";//(相对路径重定向)
    }


    @RequestMapping("/back/findAllUserByAjax")
    @ResponseBody
    public PageInfo<User> findAllUserByAjax(HttpServletRequest request, User user) {
        String pageNoStr = request.getParameter("pageNo");

        int pageNo = 1;
        try {
            pageNo = Integer.parseInt(pageNoStr);
        } catch (NumberFormatException e) {
            pageNo = 1;
        }

        System.out.println("当前页："+pageNo);
        PageInfo<User> pageInfo = null;
        try {

            pageInfo = userService.findAllUserByAjax(pageNo, user);

            request.setAttribute( "userList",pageInfo );

            System.out.println(pageInfo.getPageNum());

            List<User> list = pageInfo.getList();
            for (User user1 : list) {
                System.out.println("id= "+ user1.getId()+"   ,username= "+user1.getUsername(  ));
            }

        } catch (UserNotFoundException e) {
            e.printStackTrace();
        }
        return pageInfo;
    }

    @RequestMapping("/findByUser")
    @ResponseBody
    public ResponseResult findByUser(HttpServletRequest request, HttpServletResponse response ) {

        ResponseResult result = new ResponseResult();
        String id = request.getParameter("id");
        User user = null;
        try {
            user = userService.findByUserId( Integer.parseInt( id ) );
            System.out.println("打印结果为.: "+user);
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );
            result.setReturnObject( user );
        } catch (UserNotFoundException e) {
            e.printStackTrace();
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
            result.setMessage( e.getMessage() );

        }
        return result;
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(HttpServletRequest request, User user ) {

        ResponseResult result = new ResponseResult();
        try {
            BeanUtils.populate( user, request.getParameterMap() );
            userService.modifyUserStatus( user );


            System.out.println("打印结果为..: "+user);
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
        }

        return result;
    }


    @RequestMapping("/modifyUser")
    @ResponseBody
    public ResponseResult modifyUser(HttpServletRequest request, User user ) {
        ResponseResult result = new ResponseResult();
        try {
            BeanUtils.populate( user, request.getParameterMap() );
            System.out.println("前台获取的结果....: "+user);
            userService.modifyUser( user );
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            result.setMessage( e.getMessage() );
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
        } catch (UserExistException e) {
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
            result.setMessage( e.getMessage() );
            e.printStackTrace();
        }
        return result;
    }



    @RequestMapping("/findByUsername")
    @ResponseBody
    public ResponseResult findByUsername(HttpServletRequest request, HttpServletResponse response ) {
        ResponseResult result = new ResponseResult();
        String username = request.getParameter("username");
        try {
            userService.findByUsername( username);
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );
            result.setMessage( "用户名可以使用" );

        }  catch (UserExistException e) {
            e.printStackTrace();
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
            result.setMessage( e.getMessage() );
        }
        return result;
    }

}
