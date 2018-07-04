package com.wsy.netClass.service;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.entity.UserResource;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-27
 * Time: 4:01
 */
public interface UserResourceService {

    public PageInfo<UserResource> findUserResourceByAjax(int pageNo, UserResource userResource);
}
