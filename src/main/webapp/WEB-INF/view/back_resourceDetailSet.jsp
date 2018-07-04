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
    <title>资源详情</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
    <style type="text/css">
        .my-video {
            margin: 30px auto auto auto;

        }
        .bgColor {
            background: black;
        }
        .padding-0 {
            padding: 0 0 !important;
        }

    </style>

    <script type="text/javascript" >
        $(function(){
            //返回资源列表
            $("#back").on('click', function(){
                $('#frame-id', window.parent.document).attr('src', 'back_resourceSet');
            });

        });

    </script>
</head>

<body>
    <div class="panel panel-default" id="userSet">
        <div class="panel-heading">
            <h3 class="panel-title">资源详情</h3>
        </div>
        <div>
            <input type="button" value="返回资源列表" class="btn btn-success" id="back" style="margin: 5px 15px 5px 0px;float: right;" />
        </div>
        <div style="margin-top: 40px;">
            <div class="container-fluid padding-0 bgColor">
                <video style="width: 100%; height:470px;" controls="controls">
                    <source src="${pageContext.request.contextPath}/${path}">
                </video>
            </div>
        </div>
    </div>

</body>

</html>