package com.wsy.netClass.exception;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018-06-27
 * Time: 10:45
 */
public class ResourceTitleExistException extends Exception {
    public ResourceTitleExistException() {
    }

    public ResourceTitleExistException(String message) {
        super( message );
    }

    public ResourceTitleExistException(String message, Throwable cause) {
        super( message, cause );
    }

    public ResourceTitleExistException(Throwable cause) {
        super( cause );
    }

    public ResourceTitleExistException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super( message, cause, enableSuppression, writableStackTrace );
    }
}
