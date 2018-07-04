package com.wsy.netClass.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wsy.netClass.constant.Constant;
import com.wsy.netClass.dao.UserResourceDao;
import com.wsy.netClass.entity.Resource;
import com.wsy.netClass.entity.UserResource;
import com.wsy.netClass.service.UserResourceService;
import com.wsy.netClass.until.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-27
 * Time: 4:01
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class UserResourceServiceImpl implements UserResourceService {

    @Autowired
    private UserResourceDao userResourceDao;

    @Override
    public PageInfo<UserResource> findUserResourceByAjax(int pageNo, UserResource userResource) {

        PageHelper.startPage( pageNo, Constant.PAGE_SIZE );


        List<UserResource> resourceList = userResourceDao.selectUserResource( userResource );


        PageInfo<UserResource> pageInfo = new PageInfo<>( resourceList );

        return pageInfo;


    }
}
