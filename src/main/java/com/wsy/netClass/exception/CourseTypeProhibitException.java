package com.wsy.netClass.exception;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-26
 * Time: 16:55
 */
public class CourseTypeProhibitException extends Exception {
    public CourseTypeProhibitException() {
    }

    public CourseTypeProhibitException(String message) {
        super( message );
    }

    public CourseTypeProhibitException(String message, Throwable cause) {
        super( message, cause );
    }

    public CourseTypeProhibitException(Throwable cause) {
        super( cause );
    }

    public CourseTypeProhibitException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super( message, cause, enableSuppression, writableStackTrace );
    }
}
