package com.wsy.netClass.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wsy.netClass.constant.Constant;
import com.wsy.netClass.dao.UserDao;
import com.wsy.netClass.entity.User;
import com.wsy.netClass.exception.UserExistException;
import com.wsy.netClass.exception.UserNotFoundException;
import com.wsy.netClass.exception.UserRoleException;
import com.wsy.netClass.exception.UserStatusException;
import com.wsy.netClass.service.UserService;
import com.wsy.netClass.until.CommonUtil;
import com.wsy.netClass.until.ParameterUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-21
 * Time: 9:36
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {


    @Autowired
    private UserDao userDao;

    @Override
    @Transactional(readOnly=true)
    public User backLogin(String loginName, String password) throws UserNotFoundException, UserRoleException, UserStatusException {

        User user = new User();
        user.setUsername(loginName );
        user.setPassword( CommonUtil.md5(password));
        User resultUser = userDao.selectByUsernameAndPassword( user );
        if (resultUser == null) {
            throw new UserNotFoundException( "用户名和密码错误" );
        }
        if (!Constant.USER_ROLE_ADMIN.equals( resultUser.getRole() ) ) {
            throw new UserRoleException( "用户权限不足" );
        }
        if (Constant.STATUS_ENABLE != resultUser.getFlag()) {

            throw new UserStatusException( "用户已被禁用" );
        }
        return resultUser;
    }

    @Override
    public User frontLogin(String loginName, String password) throws UserNotFoundException, UserRoleException, UserStatusException {
        User user = new User();
        user.setUsername(loginName );
        user.setPassword( CommonUtil.md5(password));
        User resultUser = userDao.selectByUsernameAndPassword( user );
        if (resultUser == null) {
            throw new UserNotFoundException( "用户名和密码错误" );
        }

        if (Constant.STATUS_ENABLE != resultUser.getFlag()) {

            throw new UserStatusException( "用户已被禁用" );
        }
        return resultUser;
    }

    @Override
    @Transactional(readOnly=true)
    public PageInfo<User> findAllUserByAjax(int pageNo,User user) throws UserNotFoundException {

        PageHelper.startPage( pageNo, Constant.PAGE_SIZE );
        if(!ParameterUtil.isNull( user.getCreateStartDate() )){
            user.setCreateStartDate( user.getCreateStartDate()+" 00:00:00" );
        }
        if (!ParameterUtil.isNull( user.getCreateEndDate() )) {
            user.setCreateEndDate( user.getCreateEndDate()+" 23:59:59" );
        }
        if(!ParameterUtil.isNull( user.getLoginStartDate() )){
            user.setLoginStartDate( user.getLoginStartDate()+" 00:00:00" );
        }
        if (!ParameterUtil.isNull( user.getOutStartDate() )) {
            user.setOutStartDate( user.getOutStartDate()+" 23:59:59" );
        }

        List<User> userList = userDao.selectByFuzzy( user );
        PageInfo<User> page = new PageInfo<>( userList );

        if (userList.isEmpty()) {
            throw new UserNotFoundException("没有用户存在");
        }

        return page;
    }

    @Override
    @Transactional(readOnly=true)
    public User findByUserId(Integer userId) throws UserNotFoundException {
        User user = userDao.selectById( userId );
        if (user == null) {
            throw new UserNotFoundException("没有用户存在");
        }
        return user;
    }

    @Override
    public void findByUsername(String username) throws UserExistException {

        User user = userDao.selectByUsername( username );
        if (user != null) {
            throw new UserExistException( "用户名已存在" );
        }

    }

    @Override
    public void addUser(User user) throws UserExistException {

        User selectByUsername = userDao.selectByUsername( user.getUsername() );

        if (selectByUsername != null) {
            throw new UserExistException( "用户名已存在" );
        }
        user.setLoginDate( new Date() );
        String password = user.getPassword();
        user.setRole( Constant.USER_ROLE_NORMAL );
        user.setPassword( CommonUtil.md5(password ));
        user.setFlag( Constant.STATUS_ENABLE );
        userDao.insertMysql( user );

    }

    @Override
    public void modifyUser(User user) throws UserExistException {
        User selectByUsername = userDao.selectByUsername( user.getUsername() );
        if (selectByUsername != null) {
            if (!user.getId().equals(selectByUsername.getId()  ) ) {
                throw new UserExistException( "用户名已存在" );
            }
        }
        if (!ParameterUtil.isNull( user.getPassword() )) {
            String password = CommonUtil.md5(user.getPassword()  );
            user.setPassword( password );
        }

        userDao.updateUser( user );
    }

    @Override
    public void modifyUserStatus(User user) {

        if (Constant.STATUS_ENABLE == user.getFlag()) {
            user.setFlag( Constant.STATUS_DISABLE );
        } else {
            user.setFlag( Constant.STATUS_ENABLE );
        }
        userDao.updateUserStatus( user );
    }



}
