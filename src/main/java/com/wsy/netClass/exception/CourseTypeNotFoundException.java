package com.wsy.netClass.exception;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-22
 * Time: 11:03
 */
public class CourseTypeNotFoundException extends Exception {
    public CourseTypeNotFoundException() {
    }

    public CourseTypeNotFoundException(String message) {
        super( message );
    }

    public CourseTypeNotFoundException(String message, Throwable cause) {
        super( message, cause );
    }

    public CourseTypeNotFoundException(Throwable cause) {
        super( cause );
    }

    public CourseTypeNotFoundException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super( message, cause, enableSuppression, writableStackTrace );
    }
}
