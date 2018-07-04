package com.wsy.netClass.service;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.entity.User;
import com.wsy.netClass.exception.UserExistException;
import com.wsy.netClass.exception.UserNotFoundException;
import com.wsy.netClass.exception.UserRoleException;
import com.wsy.netClass.exception.UserStatusException;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-21
 * Time: 9:31
 */
public interface UserService {
    /**
     * 后台用户登陆
     * @param loginName
     * @param password
     * @return
     * @throws UserNotFoundException
     * @throws UserRoleException
     * @throws UserStatusException
     */
    public User backLogin(String loginName, String password) throws UserNotFoundException, UserRoleException, UserStatusException;

    public User frontLogin(String loginName, String password) throws UserNotFoundException, UserRoleException, UserStatusException;

    public PageInfo<User> findAllUserByAjax(int pageNo, User user) throws UserNotFoundException;

    public User findByUserId(Integer userId) throws UserNotFoundException;


    public void findByUsername(String username) throws UserExistException;

    public void addUser(User user) throws UserExistException;

    public void modifyUser(User user) throws UserExistException;

    public void modifyUserStatus(User user);



}
