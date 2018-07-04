package com.wsy.netClass.controller;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.constant.ResponseCodeConstant;
import com.wsy.netClass.entity.Resource;
import com.wsy.netClass.entity.User;
import com.wsy.netClass.exception.ResourceTitleExistException;
import com.wsy.netClass.service.ResourceService;
import com.wsy.netClass.until.ParameterUtil;
import com.wsy.netClass.until.ResponseResult;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import sun.java2d.pipe.SpanIterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-25
 * Time: 10:46
 */
@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;

    @RequestMapping("/back/findAllResourceByAjax")
    @ResponseBody
    public PageInfo<Resource> findAllResourceByAjax(HttpServletRequest request, Resource resource) {
        String pageNoStr = request.getParameter("pageNo");
        String username = request.getParameter( "username" );
        int pageNo = 1;
        try {
            pageNo = Integer.parseInt(pageNoStr);
        } catch (NumberFormatException e) {
            pageNo = 1;
        }
        if ("-1".equals( resource.getFileType() )) {
            resource.setFileType( "" );
        }

        PageInfo<Resource> pageInfo = null;
        try {
            System.out.println("。。。"+resource.toString());
            User user = new User();
            user.setUsername( username );
            resource.setUser( user );
                pageInfo = resourceService.findAllByAjax( pageNo, resource );

            request.setAttribute( "resourceList",pageInfo );

            System.out.println("    "+pageInfo.getPageNum());

            List<Resource> list = pageInfo.getList();
            for (Resource resource1 : list) {
                System.out.println("id= "+ resource1.getId()+"   ,title: "+resource1.getTitle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pageInfo;

    }



    @RequestMapping("/front/findUserResourceByAjax")
    @ResponseBody
    public PageInfo<Resource> findUserResourceByAjax(HttpServletRequest request, Resource resource) {
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = 1;
        try {
            pageNo = Integer.parseInt(pageNoStr);
        } catch (NumberFormatException e) {
            pageNo = 1;
        }



        User user = (User) request.getAttribute( "user" );

        PageInfo<Resource> pageInfo = null;
        try {


            resource.setUserId( 1);

            pageInfo = resourceService.findUserResourceByAjax( pageNo, resource );

            request.setAttribute( "resourceList",pageInfo );

            System.out.println("    "+pageInfo.getPageNum());

            List<Resource> list = pageInfo.getList();
            for (Resource resource1 : list) {
                System.out.println("id= "+ resource1.getId()+"   ,title: "+resource1.getTitle());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pageInfo;

    }


    @RequestMapping("/back/updateResource")
    public String addResource(HttpServletRequest request, @RequestParam CommonsMultipartFile file,Resource resource) {
        System.out.println( resource );
        if (resource.getId() == null) {
            try {

                System.out.println( resource );
                resourceService.addResource( resource, file, request.getSession() );
            } catch (FileUploadException | ResourceTitleExistException e) {
                request.setAttribute( "errorMsg", e.getMessage() );
                e.printStackTrace();
            }
        }else{
            try {
                resourceService.modifyResource( resource, file, request.getSession() );
            } catch (FileUploadException | ResourceTitleExistException e) {
                e.printStackTrace();
            }

        }


        return "/front_mycourse";
    }

    @RequestMapping("/download")
    public ResponseEntity<byte[]> downResource(HttpServletRequest request, HttpServletResponse response, Resource resource) throws IOException {
        Resource resourceById = resourceService.findResourceById( resource );
        String path = resourceById.getPath();
/*
        String path = request.getServletContext().getRealPath("/upload/");
*/
        System.out.println("path    "+ path );
//       FileInputStream fis = new FileInputStream( path );
        File file = new File(path);
        String downloadFileName=new String(resourceById.getTitle().getBytes("UTF-8"),"ISO-8859-1");
        byte[] bytes = FileUtils.readFileToByteArray( file );
        HttpHeaders headers = new HttpHeaders();
/*
           byte[] bytes = new byte[fis.available()];
*/
          /*  fis.read( bytes );*/
/*
          headers.add( "content-disposition", "attachment;filename="+resourceById.getTitle() +".pdf");
*/
            headers.setContentType( MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData( "attachment",downloadFileName+".pdf" );

            return new ResponseEntity<>(bytes,headers, HttpStatus.CREATED);

    }


    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(HttpServletRequest request, Resource resource ) {

        ResponseResult result = new ResponseResult();

        resourceService.modifyStatus(resource);

        System.out.println( "执行修改状态：" + resource );

        result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );

        return result;
    }

    @RequestMapping("/findResourceById")
    @ResponseBody
    public ResponseResult findResourceById(HttpServletRequest request, Resource resource ) {

        ResponseResult result = new ResponseResult();

        System.out.println( resource );

        Resource resultResource = resourceService.findResourceById( resource );

        System.out.println( resultResource );


        result.setReturnObject( resultResource );

        result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );

        return result;
    }


    @RequestMapping("/findResource")
    public String findResource(HttpServletRequest request, Resource resource ) {
        System.out.println( resource );

        Resource resultResource = resourceService.findResourceById( resource );

        String path = resultResource.getPath();

        String[] split = path.split( "upload" );
        System.out.println(split[1]);
        String relativePath = split[1];
        relativePath = "upload" + relativePath;

        request.setAttribute( "path", relativePath );


        return "front_courseDetail";
    }


    @RequestMapping("/back/showResource")
    public String showResource(HttpServletRequest request, Resource resource ) {
        System.out.println( resource );

        Resource resultResource = resourceService.findResourceById( resource );
        String path = resultResource.getPath();

        String[] split = path.split( "upload" );
        System.out.println(split[1]);
        String relativePath = split[1];
        relativePath = "upload" + relativePath;

        request.setAttribute( "path", relativePath );


        return "back_resourceDetailSet";
    }

}

