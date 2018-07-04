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
    <title>评论管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>

    <script type="text/javascript" >
        $(function(){
            //返回章节列表
            $("#back").on('click', function(){
                $('#frame-id', window.parent.document).attr('src', 'back_courseReourceSet.html');
            });

            // 显示隐藏查询列表
            $('#show-comment-search').click(function() {
                $('#show-comment-search').hide();
                $('#upp-comment-search').show();
                $('.show-comment-search').slideDown(500);
            });
            $('#upp-comment-search').click(function() {
                $('#show-comment-search').show();
                $('#upp-comment-search').hide();
                $('.show-comment-search').slideUp(500);
            });

            //按钮的超链接设置函数
    //      myoptions.pageUrl = function(type, page, current) {
    //          return "${pageContext.request.contextPath }/findAll.do?pageNo="
    //                  + page;
    //      };
            //分页回调函数,点击按钮事件
            myoptions.onPageClicked = function(event, originalEvent, type, page) {
                //ajax回调接收数据成功时再重新初始化分页按钮
                console.log("pageNo=", page);
            };

            //分页,在bootstrap-mypaginator.js中
            myPaginatorFun("myPages", 1, 5);
        });

    </script>
</head>

<body>
    <div class="panel panel-default" id="userSet">
        <div class="panel-heading">
            <h3 class="panel-title">评论管理</h3>
        </div>
        <div>
            <!-- course-resource-id,没有时,移除此按钮 -->
            <input type="hidden" name="course_resource_id" value=""  />
            <input type="button" value="查询" class="btn btn-success" id="doSearch" style="margin: 5px 5px 5px 15px;" />
            <input type="button" class="btn btn-primary" id="show-comment-search" value="展开搜索" />
            <input type="button" value="收起搜索" class="btn btn-primary" id="upp-comment-search" style="display: none;" />
            <input type="button" value="返回章节列表" class="btn btn-success" id="back" style="margin: 5px 15px 5px 0px;float: right;" />
        </div>

        <div class="panel-body">
            <div class="show-comment-search" style="display: none;">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label for="user-name-search" class="col-xs-3 control-label">用户名：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" id="user-name-search" placeholder="请输入用户名" />
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label for="user-comment-search" class="col-xs-3 control-label">内容：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" id="user-comment-search" placeholder="请输入评论内容" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label class="col-xs-3 control-label">开始日期：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" placeholder="请输入开始时间:2017-10-10" />
                            </div>
                        </div>
                        <div class="form-group col-xs-6">
                            <label class="col-xs-3 control-label">结束日期：</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" placeholder="请输入结束时间:2017-10-12" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group col-xs-6">
                            <label for="course-resource-stauts-search" class="col-xs-3 control-label">状态：</label>
                            <div class="col-xs-8">
                                <select class="form-control" id="course-resource-stauts-search" name="course-resource-stauts-search" >
                                    <option value="-1" >全部</option>
                                    <option value="0" >启用</option>
                                    <option value="1" >禁用</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                </form>
            </div>

            <div class="show-list">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">评论内容</th>
                            <th class="text-center">用户名</th>
                            <th class="text-center">评论时间</th>
                            <th class="text-center">赞</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                        <tr>
                            <td>1</td>
                            <td>非常有用处</td>
                            <td>cc</td>
                            <td>2017-10-10 10:10:50</td>
                            <td>10</td>
                            <td>启用</td>
                            <td class="text-center">
                                <input type="button" class="btn btn-danger btn-sm" value="禁用" />
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>非常有用处</td>
                            <td>cc2</td>
                            <td>2017-10-13 12:30:30</td>
                            <td>200</td>
                            <td>禁用</td>
                            <td class="text-center">
                                <input type="button" class="btn btn-success btn-sm" value="启用" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 分页 -->
            <div style="text-align: center;" >
                <ul id="myPages" ></ul>
            </div>

        </div>
    </div>
</body>

</html>
