<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>优学堂精品课程管理系统</title>
    <!-- 网页图标icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logn.png">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(function () {
            $(".user-setting li").click(function() {
                $(".user-setting li").removeClass("active");
                $(this).addClass("active");
            });
            // 点击切换页面
            $(".sys-item").on('click', function(){
                var name = $(this).attr("name");
                console.log(name);
                $('#frame-id').attr('src', "${pageContext.request.contextPath}/"+name );
            });
        });

    </script>
</head>

<body>
    <div class="wrapper-cc clearfix">
        <div class="content-cc">
            <!-- header start -->
            <div class="clear-bottom head">
                <div class="container head-cc">
                    <p>优学堂精品课程<span>后台管理系统</span></p>
                    <div class="welcome">
                        <div class="left">欢迎您：</div>
                        <div class="right">${user.username}</div>
                        <div class="exit">
                        <a style="color: inherit;" href="${pageContext.request.contextPath}/user/loginOut" >退出</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- header end -->
            <!-- content start -->
            <div class="container-flude flude-cc" id="a">
                <div class="row user-setting">
                    <div class="col-xs-3 user-wrap">
                        <ul class="list-group">
                            <li class="list-group-item sys-item active" name="back_userSet" >
                                <i class="glyphicon glyphicon-user"></i> &nbsp;用户管理
                            </li>
                            <li class="list-group-item sys-item" name="back_courseSet" >
                                <i class="glyphicon glyphicon-facetime-video"></i> &nbsp;课程管理
                            </li>
                            <li class="list-group-item sys-item" name="courseType/findTopType" >
                                <i class="glyphicon glyphicon-list"></i> &nbsp;课程类别管理
                            </li>
                            <li class="list-group-item sys-item" name="back_resourceSet" >
                                <i class="glyphicon glyphicon-file"></i> &nbsp;资源管理
                            </li>
                            <li class="list-group-item sys-item" name="back_commentManageSet" >
                                <i class="glyphicon glyphicon-comment"></i> &nbsp;评论审核
                            </li>
                            
                        </ul>
                    </div>
                    <div class="col-xs-9" id="userPanel">
                        <iframe id="frame-id" src="${pageContext.request.contextPath}/back_userSet" width="100%" height="100%" frameborder="0" scrolling="yes"></iframe>
                    </div>
                </div>
            </div>
            <!-- content end-->
        </div>
    </div>
    <div class="footer">
        <!-- footers start -->
        版权所有：南京网博 &nbsp; &nbsp; BY:cc
        <!-- footers end -->
    </div>
</body>

</html>