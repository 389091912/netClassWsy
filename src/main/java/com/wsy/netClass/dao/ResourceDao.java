package com.wsy.netClass.dao;


import com.wsy.netClass.entity.Resource;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-25
 * Time: 10:29
 */
public interface ResourceDao {

    public List<Resource> selectAllByParameter(Resource resource);

    public List<Resource> selectFrontByParameter(Resource resource);

    public void insertResource(Resource resource);

    public void updateResource(Resource resource);

    public void updateStatus(Resource resource);

    public Resource selectResourceById (@Param( "id" ) Integer id);

    public Resource selectResourceByTitle (Resource resource);

    public Resource selectUserIdAndTitle(Integer userId,String title);




}
