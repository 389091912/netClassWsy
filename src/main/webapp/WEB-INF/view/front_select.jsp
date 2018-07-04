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
    <title>优学堂</title>
    <!-- js -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/front-index.js"></script>
    <!-- css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href='${pageContext.request.contextPath}/iconfont/font_1/iconfont.css'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/front-index.css">
    <style>
    html,
    body {
        height: 100%;
    }

    body>.wrap-cc {
        min-height: 100%;
    }

    .content-cc {
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
    $(function() {
        //组合查询
        $(".course-nav-row>div>ul>li").bind("click", function() {
            //siblings获取同胞元素
            $(this).addClass("on").siblings().removeClass("on");;
        });
        //最新,最热
        $(".tool-left>a").on('click', function() {
            $(this).addClass('present').siblings().removeClass("present");
        })
        $(".tool-iseasy>a").on('click', function() {
            $(this).addClass('active').siblings().removeClass("active");
        })
        var state = 0;
        $(".tool-chk").click(function() {
            if (state == 0) {
                $(".tool-chk").css({
                    "background": "url(images/sw-on.fw.png) no-repeat"
                });
                state = 1;
            } else {
                $(".tool-chk").css({
                    "background": "url(images/sw-off.png) no-repeat"
                });
                state = 0;
            }
        })
    })
    </script>
</head>

<body>
    <div class="wrap-cc">
        <div class="content-cc">
            <!-- head -->
            <nav class="navbar navbar-default">
                <div class="container" style="width: 1038px">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <!--  <a class="navbar-brand" href="#">Brand</a> -->
                        <img src="images/com-logo1.png" alt="" width="120" style="margin-right: 20px;">
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
                            <img class="img-circle" src="images/user.jpeg" id="userImg">
                            <span class="caret"></span>
                        </a>
                                <ul class="dropdown-menu userinfo cc">
                                    <li>
                                        <img src="images/user.jpeg" class="img-circle" alt="">
                                        <div class="">
                                            <p>${user.username}</p>
                                            <p>金币<span>${goldPoint.pointCount}</span>&nbsp;积分 <span>${goldPoint.goldCount}</span></p>
                                        </div>
                                    </li>
                                    <li>
                                        <a href="front_mycourse">
                                    <i class="glyphicon glyphicon-edit"></i>我的课程
                                </a>
                                        <a href="front_record">
                                    <i class="glyphicon glyphicon-record"></i>积分记录
                                </a>
                                    </li>
                                    <li>
                                        <a href="#" data-toggle="modal" data-target="#userSet">
                                    <i class="glyphicon glyphicon-cog"></i>个人设置
                                </a>
                                        <a href="${pageContext.request.contextPath}/user/front/loginOut"><i class="glyphicon glyphicon-off"></i>退出登录</a>                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <!-- /.navbar-collapse -->
                </div>
                <!-- /.container-fluid -->
            </nav>
            <!-- nav -->
            <div class="contain">
                <!-- 左侧 -->
                <div class="course-nav-row">
                    <span class="hd f-left"> 方向：</span>
                    <div>
                        <ul class="ln">
                            <li class="course-nav-item"><a href="javascript:void(0);">全部</a></li>
                            <li class="course-nav-item on"><a href="javascript:void(0);">前端开发</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">后端开发</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">移动开发</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">数据库</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">人工智能</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">云计算&大数据</a></li>
                        </ul>
                    </div>
                </div>
                <div class="course-nav-row">
                    <span class="hd f-left"> 分类：</span>
                    <div>
                        <ul class="ln">
                            <li class="course-nav-item"><a href="javascript:void(0);">全部</a></li>
                            <li class="course-nav-item "><a href="javascript:void(0);">HTML</a></li>
                            <li class="course-nav-item on"><a href="javascript:void(0);">CSS</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">ANGULAR</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">ReactJS</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">Vue.js</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">WebApp</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">Vue.js</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">Sass/less</a></li>
                        </ul>
                    </div>
                </div>
                <div class="course-nav-row">
                    <span class="hd f-left"> 类型：</span>
                    <div>
                        <ul class="ln">
                            <!-- <li class="course-nav-item"><a href="javascript:void(0);">全部</a></li> -->
                            <li class="course-nav-item on"><a href="javascript:void(0);">网站</a></li>
                            <li class="course-nav-item"><a href="javascript:void(0);">个人</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- 实战推荐 -->
            <div class="course">
                <div class="course-tool-bar">
                    <div class="tool-left f-left">
                        <a href="javascript:void(0);" class="present">最新</a>
                        <a href="javascript:void(0);">最热</a>
                    </div>
                    <div class="tool-right f-right">
                        <span class="tool-item">
                     <a href="#" class="hide-learned tool-chk">隐藏已参加课程</a>
                 </span>
                        <span class="tool-item tool-page">
                     <span class="pager-num">
                         <b class="pager-cur">2</b>
                         / <em class="pager-total">10</em>
                     </span>
                        <a href="#" class="pager-action pager-prev">
                    <i class="icon iconfont icon-jiankuohaocudazuo"></i>
                </a>
                        <a href="#" class="pager-action pager-next">
                    <i class="icon iconfont icon-jiankuohaocudayou"></i>
                </a>
                        </span>
                    </div>
                    <div class="tool-iseasy f-right">
                        <strong>难度：</strong>
                        <a href="#" class="sort-item active">全部</a>
                        <a href="#" class="sort-item">初级</a>
                        <a href="#" class="sort-item">中级</a>
                        <a href="#" class="sort-item">高级</a>
                    </div>
                </div>
                <div class="course-box">
                    <div class="course-item">
                        <div class="item-t">
                            <img src="images/course01.jpg" alt="">
                            <div class="java">
                                <label>Java</label>
                            </div>
                        </div>
                        <div class="item-b">
                            <a href="front_courseDetail.html">
                                <h4>Java企业级电商项目架构演进之路  Tomcat集群与Redis分布式</h4>
                            </a>
                            <p class="title">
                                <span>实战</span>
                                <span>高级</span>
                                <span>￥400</span>
                                <span>4星</span>
                            </p>
                            <p class="price">￥ 399.00</p>
                        </div>
                    </div>
                    <div class="course-item">
                        <div class="item-t">
                            <img src="images/course02.jpg" alt="">
                            <div class="java">
                                <label>Python</label>
                            </div>
                        </div>
                        <div class="item-b">
                            <a href="front_courseDetail.html">
                                <h4>全网最热Python3入门+进阶 更快上手实际开发</h4>
                            </a>
                            <p class="title">
                                <span>实战</span>
                                <span>高级</span>
                                <span>￥400</span>
                                <span>4星</span>
                            </p>
                            <p class="price">￥ 399.00</p>
                        </div>
                    </div>
                    <div class="course-item">
                        <div class="item-t">
                            <img src="images/course03.jpg" alt="">
                            <div class="java">
                                <label>Java</label>
                                <label>Spring Boot</label>
                            </div>
                        </div>
                        <div class="item-b">
                            <a href="front_courseDetail.html">
                                <h4>Spring Boot企业微信点餐系统</h4>
                            </a>
                            <p class="title">
                                <span>实战</span>
                                <span>高级</span>
                                <span>￥400</span>
                                <span>4星</span>
                            </p>
                            <p class="price">￥ 399.00</p>
                        </div>
                    </div>
                    <div class="course-item">
                        <div class="item-t">
                            <img src="images/course04.jpg" alt="">
                            <div class="java">
                                <label>Android</label>
                            </div>
                        </div>
                        <div class="item-b">
                            <a href="front_courseDetail.html">
                                <h4>人人都是架构师 从零开始设计架构并开发Android电商项目</h4>
                            </a>
                            <p class="title">
                                <span>实战</span>
                                <span>高级</span>
                                <span>￥400</span>
                                <span>4星</span>
                            </p>
                            <p class="price">￥ 399.00</p>
                        </div>
                    </div>
                    <div class="course-item">
                        <div class="item-t">
                            <img src="images/course05.jpg" alt="">
                            <div class="java">
                                <label>React.JS</label>
                            </div>
                        </div>
                        <div class="item-b">
                            <a href="front_courseDetail.html">
                                <h4>Redux+React Router+Node.js全栈开发</h4>
                            </a>
                            <p class="title">
                                <span>实战</span>
                                <span>高级</span>
                                <span>￥400</span>
                                <span>4星</span>
                            </p>
                            <p class="price">￥ 399.00</p>
                        </div>
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
                        <form action="#" class="form-horizontal" method="post">
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
        </div>
    </div>
    <div class="footer-cc">
        <div class="foots">
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
