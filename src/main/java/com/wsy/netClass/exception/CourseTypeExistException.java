package com.wsy.netClass.exception;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-22
 * Time: 13:50
 */
public class CourseTypeExistException extends Exception {
    public CourseTypeExistException() {
    }

    public CourseTypeExistException(String message) {
        super( message );
    }

    public CourseTypeExistException(String message, Throwable cause) {
        super( message, cause );
    }

    public CourseTypeExistException(Throwable cause) {
        super( cause );
    }

    public CourseTypeExistException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super( message, cause, enableSuppression, writableStackTrace );
    }
}
