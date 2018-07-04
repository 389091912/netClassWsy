package com.wsy.netClass.service;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.entity.Resource;
import com.wsy.netClass.exception.ResourceTitleExistException;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpSession;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-25
 * Time: 10:36
 */
public interface ResourceService {

    public PageInfo<Resource> findAllByAjax(int pageNo, Resource resource);

    public PageInfo<Resource> findUserResourceByAjax(int pageNo, Resource resource);


    public void addResource(Resource resource, @RequestParam CommonsMultipartFile file, HttpSession session) throws FileUploadException, ResourceTitleExistException;

    public void modifyResource(Resource resource, @RequestParam CommonsMultipartFile file, HttpSession session) throws FileUploadException, ResourceTitleExistException;

    public void modifyStatus(Resource resource);

    public Resource findResourceById(Resource resource);



}
