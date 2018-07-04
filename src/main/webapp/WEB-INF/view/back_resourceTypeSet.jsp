<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>课程类别管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js" type="text/javascript" charset="utf-8"></script>
</head>

<body>




    <!-- 课程类别管理 -->
    <div class="panel panel-default" id="resourceTypeSet">
        <div class="panel-heading">
            <h3 class="panel-title">课程类别管理</h3>
        </div>
        <div class="panel-body">
            <input type="button" value="添加课程类别" class="btn btn-primary" id="doAddDept">
            <br>
            <br>
            <div class="modal fade" tabindex="-1" id="Dept">
                <!-- 窗口声明 -->
                <div class="modal-dialog modal-lg">
                    <!-- 内容声明 -->
                    <div class="modal-content">
                        <!-- 头部、主体、脚注 -->
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">添加类别</h4>
                        </div>
                        <div class="modal-body text-center">
                            <div class="row text-right">
                                <label for="dept-duty" class="col-sm-4 control-label">名称：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="dept-duty">
                                </div>
                            </div>
                            <br>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary addDept">添加</button>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="show-list">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">名称</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <tr>
                            <td>1</td>
                            <td>Java</td>
                            <td>
                                <input type="button" class="btn btn-warning btn-sm doProModify" value="修改">
                                <input type="button" class="btn btn-danger btn-sm doProDelete" value="删除">
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>IOS</td>
                            <td>
                                <input type="button" class="btn btn-warning btn-sm doProModify" value="修改">
                                <input type="button" class="btn btn-danger btn-sm doProDelete" value="删除">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>

</html>