package com.wsy.netClass.exception;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-26
 * Time: 14:21
 */
public class UserExistException extends Exception {

    public UserExistException() {
    }

    public UserExistException(String message) {
        super( message );
    }

    public UserExistException(String message, Throwable cause) {
        super( message, cause );
    }

    public UserExistException(Throwable cause) {
        super( cause );
    }

    public UserExistException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super( message, cause, enableSuppression, writableStackTrace );
    }
}
