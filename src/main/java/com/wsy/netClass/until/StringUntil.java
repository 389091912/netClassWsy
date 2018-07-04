package com.wsy.netClass.until;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: wsy
 * Date: 2018/6/8
 * Time: 22:34
 */
public class StringUntil {
    public static String  renameFileName(String fileName){
        int dotIndex = fileName.lastIndexOf( "." );
        String stuffix = fileName.substring( dotIndex );
        String name = new SimpleDateFormat( "yyyyMMddhhmmss" ).format( new Date() );
        return name+stuffix;
    }
}
