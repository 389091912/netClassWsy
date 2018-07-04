package com.wsy.netClass.service.impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wsy.netClass.constant.Constant;
import com.wsy.netClass.dao.ResourceDao;
import com.wsy.netClass.entity.Resource;
import com.wsy.netClass.entity.User;
import com.wsy.netClass.exception.ResourceTitleExistException;
import com.wsy.netClass.service.ResourceService;
import com.wsy.netClass.until.CommonUtil;
import com.wsy.netClass.until.ParameterUtil;
import com.wsy.netClass.until.StringUntil;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;
import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-25
 * Time: 10:40
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    private ResourceDao resourceDao;


    @Override
    public PageInfo<Resource> findAllByAjax(int pageNo, Resource resource) {

        PageHelper.startPage( pageNo, Constant.PAGE_SIZE );

        List<Resource> resourceList = resourceDao.selectAllByParameter( resource );
        for (Resource resource1 : resourceList) {
                resource1.setFileSizeStr( CommonUtil.FormetFileSize(resource1.getFileSize()) );
                String[] s1 = resource1.getFileType().split( "/" );
                resource1.setFileType( s1[1]);
        }
        PageInfo<Resource> pageInfo = new PageInfo<>( resourceList );

        return pageInfo;
    }

    @Override
    public PageInfo<Resource> findUserResourceByAjax(int pageNo, Resource resource) {

        PageHelper.startPage( pageNo, Constant.PAGE_SIZE );

        resource.setStatus( Constant.STATUS_ENABLE );

        List<Resource> resourceList = resourceDao.selectFrontByParameter( resource );

        for (Resource resource1 : resourceList) {
            resource1.setFileSizeStr( CommonUtil.FormetFileSize(resource1.getFileSize()) );
            String[] s1 = resource1.getFileType().split( "/" );
            resource1.setFileType( s1[1]);

        }
        PageInfo<Resource> pageInfo = new PageInfo<>( resourceList );

        return pageInfo;

    }

    @Override
    public void addResource(Resource resource, CommonsMultipartFile file, HttpSession session) throws FileUploadException, ResourceTitleExistException {
        String fileName = file.getName();
        String path = CommonUtil.getUploadPath();

        //         String cp = session.getServletContext().getRealPath(path);
       //  String cp =  session.getServletContext().getRealPath(path);

        resource.setPath(path+StringUntil.renameFileName( file.getOriginalFilename() ));
        User user = (User) session.getAttribute( "user" );
        if (ParameterUtil.isNull( resource.getTitle() )) {
            throw new ResourceTitleExistException( "标题不能为空" );
        }
        resource.setOriginalName( file.getOriginalFilename() );

        resource.setFileType(file.getContentType() );
        resource.setUserId( 1 );
        resource.setFileSize( file.getSize() );
        resource.setCreateDate(new java.sql.Date(new Date().getTime()) );
        resource.setClickCount( 0 );
        resource.setStatus( Constant.STATUS_ENABLE );
        if (fileName.endsWith( ".pdf" ) || fileName.endsWith( ".mp4" )) {
            throw new FileUploadException("文件上传出错");
        }
        try {
            //		file.transferTo(new File("E:/ax.png"));
            file.transferTo(new File(path, StringUntil.renameFileName(file.getOriginalFilename())));
        } catch (Exception e) {
            throw new FileUploadException("文件上传出错",e);
        }
        resourceDao.insertResource( resource );
    }


    @Override
    public void modifyResource(Resource resource, @RequestParam CommonsMultipartFile file, HttpSession session) throws FileUploadException, ResourceTitleExistException {
        Resource resource1 = resourceDao.selectResourceByTitle( resource );

        if (resource1 != null) {
            throw new ResourceTitleExistException( "标题已存在" );
        }

        String fileName = file.getName();
        String path = CommonUtil.getUploadPath();
        //         String cp = session.getServletContext().getRealPath(path);
        //  String cp =  session.getServletContext().getRealPath(path);

        resource.setPath(path+StringUntil.renameFileName( file.getOriginalFilename() ));
        User user = (User) session.getAttribute( "user" );

        resource.setOriginalName( file.getOriginalFilename() );

        resource.setFileType(file.getContentType() );
        resource.setUserId( 1 );
        resource.setFileSize( file.getSize() );
        resource.setCreateDate(new java.sql.Date(new Date().getTime()) );
        resource.setStatus( Constant.STATUS_ENABLE );
        if (fileName.endsWith( ".pdf" ) || fileName.endsWith( ".mp4" )) {
            throw new FileUploadException("文件上传出错");
        }
        try {
            //		file.transferTo(new File("E:/ax.png"));
            file.transferTo(new File(path, StringUntil.renameFileName(file.getOriginalFilename())));
        } catch (Exception e) {
            throw new FileUploadException("文件上传出错",e);
        }
        resourceDao.updateResource( resource );




    }

    @Override
    public void modifyStatus(Resource resource) {
        Resource selectResource = resourceDao.selectResourceById( resource.getId() );
        Integer status = selectResource.getStatus();
        if (status == Constant.STATUS_ENABLE) {
            selectResource.setStatus( Constant.STATUS_DISABLE );
            resourceDao.updateStatus( selectResource );
        } else {
            selectResource.setStatus( Constant.STATUS_ENABLE );
            resourceDao.updateStatus( selectResource );
        }
    }

    @Override
    public Resource findResourceById(Resource resource) {

        return resourceDao.selectResourceById( resource.getId() );
    }


}
