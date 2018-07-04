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
    <meta charset="UTF-8">
    <title>我的课程</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/iconfont/font_0/iconfont.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath }/js/bootstrap-mypaginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js" charset="utf-8"></script>
    <style type="text/css">
    .file {
        position: relative;
        display: inline-block;
        background: #D0EEFF;
        border: 1px solid #99D3F5;
        border-radius: 4px;
        padding: 4px 12px;
        overflow: hidden;
        color: #1E88C7;
        text-decoration: none;
        text-indent: 0;
        line-height: 20px;
        width: 100%;
        text-align: center;
    }

    .file:hover {
        background: #AADFFD;
        border-color: #78C3F3;
        color: #004974;
        text-decoration: none;
    }

    .file:focus {
        background: #AADFFD;
        border-color: #78C3F3;
        color: #004974;
        text-decoration: none;
    }
    html,body {
      height: 100%;
    }
        
    body > .wrap-cc{
      min-height: 100%;
    }
        
    .content-cc{
      /* padding-bottom 等于 footer 的高度 */
      padding-bottom: 80px;
    }
        
    .footer-cc {
      width: 100%;
      height: 80px;
      /* margin-top 为 footer 高度的负值 */
      margin-top: -80px;
    }
    </style>


    <script>


        loadData();




        var myPageNo = 1;

        $("#loadDataUserIdInput").val("");//清空缓存
        function loadData(){
            var data = {
                "pageNo": 1,
                "id": $("#loadDataUserIdInput").val()/*,
                "createDate": ""*/
            };
            console.log("data===", data);




            $.ajax({
                "type": "post",
                "dataType": "json",
                "url" : "${pageContext.request.contextPath }/resource/front/findUserResourceByAjax",
                "data" : data,
                "success" : function(data){
                    var list = data.list;//当前页的数据数组
                    var len = list.length;
                    console.log("data.pages=" + data.pages);
                    $("#loadDataUserIdInput").val(list[len - 1].id);
                    //方式2
                    var d = {
                        "resourceList": list
                    };
                    var txt = template("resourceListTemplate", d);
                    $("#resourceList").append(txt);

                    $(".source-modify").on('click', function() {
                        $("#user_source").modal("show");
                    });

                    if(data.pages == 1){
                        $(".load-more").html("<span>已经到底了...</span>");
                    }

                },
                "error" : function(){
                    alert("error");
                }
            });
        }

    </script>

    <script>
        userResourceloadData();
        var myPageNo = 1;
        $("#loadDataUserResourceIdInput").val("");//清空缓存
        function userResourceloadData(){
            var data = {
                "pageNo": 1,
                "id": $("#loadDataUserResourceIdInput").val()/*,
                "createDate": ""*/
            };
            console.log("data===", data);
            $.ajax({
                "type": "post",
                "dataType": "json",
                "url" : "${pageContext.request.contextPath }/userResource/front/findUserResourceByAjax",
                "data" : data,
                "success" : function(data){
                    var list = data.list;//当前页的数据数组
                    var len = list.length;
                    console.log("data.pages=" + data.pages);
                    $("#loadDataUserResourceIdInput").val(list[len - 1].id);

                    var d = {
                        "userResourceList": list
                    };
                    var txt = template("userResourceListTemplate", d);
                    $("#userResourceList").append(txt);

                  /* if(data.pages == 1){
                        $(".load-more").html("<span>已经到底了...</span>");
                    }*/

                },
                "error" : function(){
                    alert("error");
                }
            });
        }

    </script>





    <script>
    $(function() {
        $(".arrow").click(function() {

            $(this).parent().next().toggle();

        });

        $(".title-ul>li").on('click', function() {
            console.log($(this).attr("show"));
            $('.' + $(this).attr("show")).show().siblings().hide();

            $(this).addClass('current').siblings().removeClass("current");

        });

        $(".source-modify").on('click', function() {
            $("#user_source").modal("show");
        });

    });

    function openAdd() {
        $("#title").val("");
        $("#course-resource-file").val("");
        $("#costType").find("option[value='-1']").attr("selected", true);
        $("#costNumber").val("");
        $("#user_source").modal("show");

    }

    function fileUpload(item) {
        $(item).click();
    }

    function fileChange(item) {
        var file = item.files[0]; //获取选中的第一个文件
        $(".file").html(file.name);
        //console.log("file", file.name);
    }

    function findResource(id) {
        $.ajax({
            "url" : "${pageContext.request.contextPath }/resource/findResourceById",
            "type" : "post",
            "dataType" : "json",
            "data" : {
                "id":id
            },
            "success" : function(result){
                if(result.responseCode==0){
                    $("#title").val(result.returnObject.title);
                     $("#costType").find("option[value='" + result.returnObject.costType+ "']").attr("selected", true);
                    $("#costNumber").val(result.returnObject.costNumber);
                }else {

                }
            },
            "error" : function(){
                console.log("error");
            }
        });

    }

    function modifyStatus(id) {
        $.ajax({
            "url" : "${pageContext.request.contextPath }/resource/modifyStatus",
            "type" : "post",
            "dataType" : "json",
            "data" : {
                "id":id
            },
            "success" : function(result){
                if(result.responseCode==0){

                  location.href="${pageContext.request.contextPath }/front_mycourse";
                }else {

                }
            },
            "error" : function(){
                console.log("error");
            }
        });

    }




    </script>
</head>

<body>
<div class="wrap-cc">
    <div class="content-cc">
    <nav class="navbar navbar-default">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <!--  <a class="navbar-brand" href="#">Brand</a> -->
                <img src="${pageContext.request.contextPath}/images/com-logo1.png" alt="" width="120" style="margin-right: 20px;">
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="#" class="vertical-middle">免费课程</a></li>
                    <li><a href="#" class="vertical-middle">职业路径</a></li>
                </ul>
                <form class="navbar-form navbar-left searchInput" style="padding:10px;">
                    <div class="form-group">
                        <input type="text" class="form-control " placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default "><span class="glyphicon glyphicon-search"></span></button>
                </form>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
                            <img class="img-circle" src="${pageContext.request.contextPath}/images/user.jpeg" id="userImg">
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu userinfo cc">
                            <li>
                                <img src="${pageContext.request.contextPath}/images/user.jpeg" class="img-circle" alt="">
                                <div class="">
                                    <p>${user.username}</p>
                                    <p>金币<span>${goldPoint.pointCount}</span>&nbsp;积分 <span>${goldPoint.goldCount}</span></p>
                                </div>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/front_mycourse">
                                    <i class="glyphicon glyphicon-edit"></i>我的课程
                                </a>
                                <a href="${pageContext.request.contextPath}/recode/findAllByUser">
                                    <i class="glyphicon glyphicon-record"></i>积分记录
                                </a>
                            </li>
                            <li>
                                <a href="#" data-toggle="modal" data-target="#userSet">
                                    <i class="glyphicon glyphicon-cog"></i>个人设置
                                </a>
                                <a href="${pageContext.request.contextPath}/user/front/loginOut"><i class="glyphicon glyphicon-off"></i>退出登录</a>                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
    <div class="container-fluid banner">
        <div class="container banner-mycourse">
            <div class="row">
                <p>${user.username}</p>
            </div>
            <div class="row">
                <img src="${pageContext.request.contextPath}/images/girl.png" alt="" width="18">&nbsp;&nbsp;
                <span>学习时长</span>&nbsp;
                <span>94小时</span>&nbsp;
                <span>积分0</span>&nbsp;
                <span>经验256</span>
            </div>
            <div class="row">
                这位同学很懒，木有签名的说~~
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <ul class="title-ul">
                <li class="current" show='cc-course'>最近学习</li>
                <li class="source" show='cc-source'>我的资源</li>
            </ul>
            <div>
                <!-- 最近学习 -->
                <ul class="mycourse-content cc-course">
                    <div id="userResourceList">

                    </div>

                    <script id="userResourceListTemplate" type="text/html" >
                        {{each userResourceList as userResource}}
                        <li>
                            <div class="col-md-1 col-sm-1">
                                <strong>{{userResource.updateDateStr}}</strong>
                            </div>
                            <div class="col-md-11 col-sm-11">
                                <span class="circle"></span>
                                <div class="row  border-bottom">
                                    <div class="col-md-3">
                                        <img src="${pageContext.request.contextPath}/images/timg.jpg" alt="" height="120" class="mycourseImg">
                                    </div>
                                    <div class="col-md-8 mycourse-info">
                                        <p class="padding-top-25">
                                        <span>
                                       {{userResource.resource.title}}
                                    </span>
                                            <span>
                                     </span>
                                        </p>
                                        <p class="padding-10">
                                            <span>已学0%</span> &nbsp;&nbsp;&nbsp;&nbsp;
                                            <span>

                                        </span> &nbsp;&nbsp;&nbsp;&nbsp;
                                            <span>

                                        </span>
                                        </p>
                                        <div>
                                            <div>
                                                笔记 0
                                            </div>
                                            <div>
                                                代码0
                                            </div>
                                            <div>
                                                问答0
                                            </div>
                                            <div>
                                                <a href="${pageContext.request.contextPath}/resource/findResource?id={{userResource.resource.id}}" >继续学习</a>

<%--
                                                <input type="button" onclick="showResource('{{userResource.resource.id}}')" class="btn btn-primary" value="继续学习"/>
--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        {{/each}}
                    </script>



                    <li>
                        <div class="load-more" id="user">
                            <input type="hidden" id="loadDataUserResourceIdInput" value="" />
                            <span onclick="userResourceloadData()">已经到底了...</span>
                        </div>
                    </li>
                </ul>






                <!-- 我的资源 -->
                <ul class="mycourse-content cc-source">
                    <li style="text-align: right;margin-top:20px; ">
                        <button class="btn btn-primary" onclick="openAdd()" style="width: 100px;">添加资源</button>
                    </li>
                    <div id="resourceList">

                    </div>




                    <li>
                        <div class="load-more">
                            <input type="hidden" id="loadDataUserIdInput" value="" />
                            <span onclick="loadData()">加载更多...</span>
                        </div>
                    </li>
                </ul>

                <script id="resourceListTemplate" type="text/html" >
                    {{each resourceList as item}}
                    <li>
                        <div class="col-md-1 col-sm-1">
                            <strong>{{item.createDateStr}}</strong>
                            <%-- <div>
                                 01月31日 13:50:06
                             </div>--%>
                        </div>
                        <div class="col-md-11 col-sm-11">
                            <span class="circle"></span>
                            <div class="row  border-bottom">
                                <div class="col-md-3">
                                    <img src="${pageContext.request.contextPath}/images/timg.jpg" alt="" height="120" class="mycourseImg">
                                </div>
                                <div class="col-md-8 mycourse-info">
                                    <p class="padding-top-25">
                                        <span>
                                            {{item.title}}
                                        </span>&nbsp;&nbsp;&nbsp;
                                        <span>
                                            {{item.fileSizeStr}}
                                        </span>
                                    </p>
                                    <p class="padding-10">
                                        <span>{{item.fileType}}</span> &nbsp;&nbsp;&nbsp;&nbsp;

                                    </p>
                                    <div>
                                        <div>
                                            {{if item.costType==0}}
                                            积分
                                            {{else}}
                                            金币
                                            {{/if}}
                                        </div>
                                        <div>
                                            {{item.costNumber}}
                                        </div>
                                        <div>
                                            {{item.user.username}}
                                        </div>
                                        <div class="nostyle">
                                            <button class="btn btn-warning source-modify" onclick="findResource('{{item.id}}')">修改</button>
                                            <button class="btn btn-danger" onclick="modifyStatus('{{item.id}}')" data-id="{{item.id}}">删除</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    {{/each}}
                </script>

            </div>
        </div>
    </div>







        <div class="modal fade" id="userSet" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">个人信息</h4>
                </div>
                <form action="../../php/editPassword.php" class="form-horizontal" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">旧密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="password" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">新密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password" name="newPassword" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">确认密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password" name="rePassword" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">昵称：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="nickname" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">邮箱：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="email" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button type="reset" class="btn btn-info">重&nbsp;&nbsp;置</button>
                        <button type="submit" class="btn btn-info">确&nbsp;&nbsp;定</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- 资源模态框 -->
    <div class="modal fade" id="user_source" tabindex="-1" role="dialog" aria-labelledby="mySourceModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="mySourceModalLabel">资源</h4>
                </div>
                <form action="${pageContext.request.contextPath}/resource/back/updateResource" class="form-horizontal" method="post" enctype="multipart/form-data" >
                    <input type="hidden" id="id" name="id">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">标题：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" id="title" name="title" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">资源：</label>
                            <div class="col-sm-6">
                                <a href="javascript:fileUpload('#course-resource-file');" class="file">选择文件</a>
                                <input type="file" name="file" style="display: none;" onchange="fileChange(this)" id="course-resource-file" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">资源花费类型：</label>
                            <div class="col-sm-6">
                                <select class="form-control" id="costType" name="costType">
                                    <option value="-1">请选择</option>
                                    <option value="0">积分</option>
                                    <option value="1">金币</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">花费值：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" id="costNumber" name="costNumber" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button type="submit" class="btn btn-info">确&nbsp;&nbsp;定</button>
                    </div>
                </form>
            </div>
        </div>
    </div>    
    </div>
</div>
<div class="footer-cc">
    <div class="footer">
        <div>
            版权所有： 南京网博
        </div>
        <div>
            Copyright © 2017 imooc.com All Rights Reserved | 京ICP备 13046642号-2
        </div>
    </div>
</div>


</body>

</html>
