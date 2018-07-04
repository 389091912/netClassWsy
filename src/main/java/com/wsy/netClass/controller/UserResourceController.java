package com.wsy.netClass.controller;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.entity.User;
import com.wsy.netClass.entity.UserResource;
import com.wsy.netClass.service.UserResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-27
 * Time: 3:59
 */
@Controller
@RequestMapping("/userResource")
public class UserResourceController {

    @Autowired
    private UserResourceService userResourceService;


    @RequestMapping("/front/findUserResourceByAjax")
    @ResponseBody
    public PageInfo<UserResource> findUserResourceByAjax(HttpServletRequest request, UserResource userResource) {
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = 1;
        try {
            pageNo = Integer.parseInt(pageNoStr);
        } catch (NumberFormatException e) {
            pageNo = 1;
        }
        User user = (User) request.getAttribute( "user" );

        PageInfo<UserResource> pageInfo = null;
        try {

            userResource.setUserId( 1);

            pageInfo = userResourceService.findUserResourceByAjax( pageNo, userResource );

            request.setAttribute( "userResourceList",pageInfo );

            System.out.println("    "+pageInfo.getPageNum());

            List<UserResource> list = pageInfo.getList();
         /*   for (UserResource resource1 : list) {
                System.out.println("id= "+ resource1.getId()+"   ,title: "+userResource.getResource().getTitle());
            }*/
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pageInfo;

    }






}
