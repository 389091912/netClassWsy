package com.wsy.netClass.dao;

import com.wsy.netClass.entity.CourseType;
import com.wsy.netClass.entity.User;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-21
 * Time: 9:29
 */
public interface UserDao {
    /**
     * 根据用户名查询一个用户
     * @param username 用户名
     * @return 封装了用户的信息的用户对象，如果没找到记录，返回null
     */
    public User selectByUsername(String username);



    public User selectByIdAndUsername(User user);

    /**
     * 保存一个用户
     * @param user 封装了用户的信息的用户对象
     */
    public void insertOracle(User user);

    /**
     * 保存一个用户
     * @param user 封装了用户的信息的用户对象
     */
    public void insertMysql(User user);

    public User selectByUsernameAndPassword(User user);

    public List<User> selectAll(User user);

    public List<User> selectByFuzzy(User user);

    public List<CourseType> selectTypes();


    public void updateUserLoginDate(User user);

    public void updateUserStatus(User user);

    public void updateUser(User user);

    public void updateByName(String username);

    public void insert(User user);

    public User selectById(Integer id);

    public void updateByUserName(String username);

}
