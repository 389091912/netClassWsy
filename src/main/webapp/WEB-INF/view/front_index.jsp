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
    <script src="${pageContext.request.contextPath }/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath }/js/bootstrap-mypaginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.js"></script>
    <script src="${pageContext.request.contextPath}/js/template-web.js"></script>

    <!-- css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/swiper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href='${pageContext.request.contextPath}/iconfont/font_1/iconfont.css'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/front-index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css">

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
        $(".signBtn").click(function() {
            $(".expe").show().addClass('animated forward fadeOutUp');

            $(".signBtn").html("已签到").unbind("click").addClass('gray').removeClass('hoverRed');
        });

      /*  var isLogin = false;
        console.log("isLogin=", isLogin);
        changeUserDiv(isLogin);*/

        $.ajax({
            url:${pageContext.request.contextPath}"/json/types.json",
            dataType:'json',
            success:function(data){
                $('#typeItemDiv').html("");
                console.log(data);
                var txt = template('typeItemList', {list: data});
                $('#typeItemDiv').append(txt);
            },
            error:function(){
                alert('加载分类出错!');
            }
        });
    });

    function openUserModal(isRegist) {
        if (isRegist) { //是注册
           /* $("#username").val("");
            $("#password").val("");
            $("#repassword").val("");
            $("#nickname").val("");
            $("#email").val("");*/
            $("#regist_modal").modal("show");
            return;
        }
        //是登录
        $("#login_modal").modal("show");
    }

    function changeUserDiv(isLogin) {
        if (isLogin) { //
            $("#loginOff").hide();
            $("#loginOn").show();
            $("#login_modal").modal("hide");
            // $(".signBtn").html("已签到").unbind("click").addClass('gray').removeClass('hoverRed');
        } else {
            $("#loginOn").hide();
            $("#loginOff").show();
        }
    }
    </script>
</head>

<body>
    <div class="wrap-cc">
    <div class="content-cc">
        <!-- head -->
    <nav class="navbar navbar-default">
        <div class="container-fluid" style="background: #fff;box-shadow: 5px 5px 5px #eef;padding-left: 20px;">
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
                <form action="${pageContext.request.contextPath}/front_select" class="navbar-form navbar-left searchInput" style="padding:10px;">
                    <div class="form-group">
                        <input type="text" class="" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default "><span class="glyphicon glyphicon-search"></span></button>
                </form>
                <c:if test="${user.username == null}">
                    <div id="loginOff" class="regist ccc">
                        <span style="margin-right: 20px;font-size: 14px;">下载APP</span>
                        <a href="javascript:openUserModal(false);" class="ccc">登录</a> &nbsp;&nbsp;/&nbsp;&nbsp;
                        <a href="javascript:openUserModal(true);" id="userRegister" class="ccc">注册</a>
                    </div>
                </c:if>
                <c:if test="${user.username != null}">
                    <ul id="loginOn" class="nav navbar-nav navbar-right">
                        <li class="nav navbar-nav signIn">
                            <div class="signBtn hoverRed">签到</div>
                            <div class="expe">+5经验值</div>
                        </li>
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
                                    <a href="${pageContext.request.contextPath}/user/front/loginOut"><i class="glyphicon glyphicon-off"></i>退出登录</a>
                                </li>
                            </ul>
                        </li>
                    </ul>

                </c:if>


            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
    <!-- nav -->
    <div class="main">
        <!-- 左侧 -->
        <div id="typeItemDiv" class="menu-left">
            <div class="item" data-id="a">
                <a href="#">
                    <span class="group">前端开发</span>
                    <span class="tip">&gt;</span>
                </a>
                <div class="course-detail">
                    <div class="one">
                        <div class="base">
                            <span>基础</span>
                            <div class="line"></div>
                        </div>
                        <p>
                            <a href="#"><span>HTML/CSS</span></a>
                            <!-- <a href="#"><span>JavaScript</span></a>
                            <a href="#"><span>jQuery</span></a> -->
                        </p>
                    </div>
                    <!-- <div class="one">
                        <div class="base">
                            <span>进阶</span>
                            <div class="line"></div>
                        </div>
                        <p>
                            <a href="#"><span>HTML/CSS</span></a>
                            <a href="#"><span>JavaScript</span></a>
                            <a href="#"><span>jQuery</span></a>
                        </p>
                    </div> -->

                    <div class="two">
                        <div class="item-box">
                            <a href="front_course.html">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course04.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/front_course">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course02.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                            <a href="front_course.html">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course03.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>

                </div>
            </div>

            <div class="item" data-id="a">
                <a href="#">
                    <span class="group">前端开发</span>
                    <span class="tip">&gt;</span>
                </a>
                <div class="course-detail">
                    <div class="one">
                        <div class="base">
                            <span>基础</span>
                            <div class="line"></div>
                        </div>
                        <p>
                            <a href="#"><span>HTML/CSS</span></a>
                            <a href="#"><span>JavaScript</span></a>
                            <a href="#"><span>jQuery</span></a>
                        </p>
                    </div>
                    <div class="one">
                        <div class="base">
                            <span>进阶</span>
                            <div class="line"></div>
                        </div>
                        <p>
                            <a href="#"><span>HTML/CSS</span></a>
                            <a href="#"><span>JavaScript</span></a>
                            <a href="#"><span>jQuery</span></a>
                        </p>
                    </div>
                    <div class="two">
                        <div class="item-box">
                            <a href="front_course.html">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course04.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                            <a href="front_course.html">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course02.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                            <a href="front_course.html">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course03.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script id="typeItemList" type="text/html">
            {{each list as type1 index}}
            <div class="item" typeId="{{type1.id}}">
                <a href="#">
                    <span class="group">{{type1.typeName}}</span>
                    <span class="tip">&gt;</span>
                </a>
                <div class="course-detail">
                    {{each type1.children as type2 index2}}
                    <div class="one">
                        <div class="base" typeId="{{type2.id}}" >
                            <span>{{type2.typeName}}</span>
                            <div class="line"></div>
                        </div>
                        <p>
                            {{each type2.children as type3 index3}}
                            <a href="#">
                                <span typeId="{{type3.id}}" >{{type3.typeName}}</span>
                            </a>
                            {{/each}}
                        </p>
                    </div>
                    {{/each}}
                    <!-- 当前分类下,点击量前四的课程 -->
                    <div class="two">
                        <div class="item-box">
                            <a href="front_course.html">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course04.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                            <a href="front_course.html">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course02.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                            <a href="front_course.html">
                                <div class="item-course">
                                    <div class="item-course-l">
                                        <img src="${pageContext.request.contextPath}/images/course03.jpg" alt="">
                                    </div>
                                    <div class="item-course-r">
                                        <p>前端进阶：响应式开发与常用框架</p>
                                        <p>
                                            <span>职业路径</span>
                                            <span>5步/30课</span>
                                            <span>503人</span>
                                        </p>
                                        <p>￥599.00</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            {{/each}}
        </script>

        <!-- 右侧 -->
        <div class="menu-right">
            <!-- banner -->
            <div class="banner">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner01.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner02.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner03.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner04.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/images/banner05.jpg" alt="">
                        </div>
                    </div>
                    <!-- Add Pagination -->
                    <div class="swiper-pagination"></div>
                </div>
            </div>
            <!-- 课程信息 -->
            <div class="tips">
                <div class="path-banner">
                    <a href="#">
                        <i class="i-web"></i>
                        <p class="tit">Web前端攻城狮</p>
                        <p class="desc">互联网时代最火爆的技术</p>
                    </a>
                    <a href="#">
                        <i class="i-java"></i>
                        <p class="tit">Java攻城狮</p>
                        <p class="desc">健壮、安全、适用广泛</p>
                    </a>
                    <a href="#">
                        <i class="i-android"></i>
                        <p class="tit">Android攻城狮</p>
                        <p class="desc">移动设备市场份额第一</p>
                    </a>
                    <a href="#">
                        <i class="i-php"></i>
                        <p class="tit">PHP攻城狮</p>
                        <p class="desc">世界上最好的语言：）</p>
                    </a>
                    <a href="#">
                        <i class="i-ios"></i>
                        <p class="tit">iOS攻城狮</p>
                        <p class="desc">可能是全球最好用的系统</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- 实战推荐 -->
    <div class="course">
        <h3 class="types-title">                
            <span class="tit-icon tit-icon-l"></span>
            <em>实</em>／<em>战</em>／<em>推</em>／<em>荐</em>
        </h3>
        <div class="course-box">
            <div class="course-item">
                <div class="item-t">
                    <img src="${pageContext.request.contextPath}/images/course01.jpg" alt="">
                    <div class="java">
                        <label>Java</label>
                    </div>
                </div>
                <div class="item-b">
                    <a href="front_course.html">
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
                    <a href="front_course.html">
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
                    <a href="front_course.html">
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
                    <a href="front_course.html">
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
                    <a href="front_course.html">
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
    </div>    <!-- 实战推荐 -->
    <div class="course">
        <h3 class="types-title">                
            <span class="tit-icon tit-icon-l"></span>
            <em>实</em>／<em>战</em>／<em>推</em>／<em>荐</em>
        </h3>
        <div class="course-box">
            <div class="course-item">
                <div class="item-t">
                    <img src="images/course01.jpg" alt="">
                    <div class="java">
                        <label>Java</label>
                    </div>
                </div>
                <div class="item-b">
                    <a href="#">
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
                    <a href="#">
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
                    <a href="#">
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
                    <a href="#">
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
                    <a href="#">
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
    </div>    <!-- 实战推荐 -->
    <div class="course">
        <h3 class="types-title">                
            <span class="tit-icon tit-icon-l"></span>
            <em>实</em>／<em>战</em>／<em>推</em>／<em>荐</em>
        </h3>
        <div class="course-box">
            <div class="course-item">
                <div class="item-t">
                    <img src="images/course01.jpg" alt="">
                    <div class="java">
                        <label>Java</label>
                    </div>
                </div>
                <div class="item-b">
                    <a href="#">
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
                    <a href="#">
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
                    <a href="#">
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
                    <a href="#">
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
                    <a href="#">
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
                                <input class="form-control" type="text" name="password" maxlength="18" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">新密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password" name="newPassword" maxlength="18"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">确认密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password" name="rePassword" maxlength="18" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">昵称：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="nickname" maxlength="18" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">邮箱：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" name="email" maxlength="18" />
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
    <!-- regist modal -->
    <div class="modal fade" id="regist_modal" tabindex="-1" role="dialog" aria-labelledby="myRegistLabel">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myRegistLabel">注册</h4>
                </div>
                <form action="#" id="userForm" class="form-horizontal" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">登录名：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" id="username" name="username" maxlength="18" />
                            </div>
                            <span id="errorMsg"></span>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password" id="password" name="password" maxlength="18" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">确认密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password"  id="repassword" name="repassword" maxlength="18" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">昵称：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" id="nickname" name="nickname" maxlength="18" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">邮箱：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text" id="email" name="email" maxlength="18" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <button type="submit" class="btn btn-info">注&nbsp;&nbsp;册</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- login modal -->
    <div class="modal fade" id="login_modal" tabindex="-1" role="dialog" aria-labelledby="myLoginLabel">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myLoginLabel">登录</h4>
                </div>
                <form action="${pageContext.request.contextPath}/user/frontLogin" class="form-horizontal" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">登录名：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="text"  name="username" maxlength="18" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">密码：</label>
                            <div class="col-sm-6">
                                <input class="form-control" type="password" name="password" maxlength="18" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭</button>
                        <input type="submit" class="btn btn-info" onclick="changeUserDiv(true)" value="登&nbsp;&nbsp;录"/>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>

        $(function () {
            $("#username").blur(function () {

                $.ajax({
                    "type":"post",
                    "url":"${pageContext.request.contextPath}/user/findByUsername",
                    "data":{
                        "username":$("#username").val()
                    },
                    "dataType":"json",
                    success:function(result){
                        if(result.responseCode == 0){
                            $("#errorMsg").text(result.message);
                            $("#errorMsg").css("color","green");

                        }else{
                            $("#errorMsg").text(result.message);
                            $("#errorMsg").css("color","red");
                            alert(result.message);

                        }
                    }

                });

            });

        });


        $(function(){
            $('#userForm')
                .bootstrapValidator({
                    feedbackIcons:{
                        valid:'glyphicon glyphicon-ok',
                        invalid:'glyphicon glyphicon-remove',
                        validating:'glyphicon glyphicon-refresh'
                    },
                    fields:{
                        username:{
                            message:'用户名校验失败！',
                            validators:{
                                notEmpty:{
                                    message:'用户名不能为空'
                                },
                                stringLength:{
                                    min:2,
                                    max:18,
                                    message:'用户名长度必须在6-18位之间'
                                },
                                regexp:{
                                    regexp:/^[0-9a-zA-Z_]+$/,
                                    message:'用户名只能包含数字、字母和下划线'
                                }
                            }
                        },
                        password:{
                            validators:{
                                notEmpty:{
                                    message:'密码不能为空'
                                },
                                different:{ //不同的，不一样的
                                    field:'username',
                                    message:'密码不能和用户名相同'
                                }
                            }
                        },
                        repassword:{
                            validators:{
                                notEmpty:{
                                    message:'确认密码不能为空'
                                },
                                identical:{ // 相同的，一样的
                                    field:'password',
                                    message:'两次输入的密码不一致'
                                }
                            }
                        },
                        nickname: {
                            validators: {
                                regexp: {
                                    regexp:  /^[A-Za-z0-9\u4e00-\u9fa5]+$/,
                                    message: '昵称只能包含数字、文字、字母'
                                }
                            }
                        },
                        email:{
                            validators:{
                                emailAddress:{
                                    message:'邮箱格式不正确'
                                }
                            }
                        }
                    }
                })
                .on('success.form.bv',function(e){ //当表单校验成功提交时触发
                    //阻止表单提交
                    e.preventDefault();
                    var $form=$(e.target);
                    console.log($('#userForm').serialize());

                    //发送JSONP请求
                    $.ajax({
                        type:'post',
                        url:'${pageContext.request.contextPath}/user/register',
                        data:$form.serialize(),
                        dataType:'json',
                        success:function(result){
                            if(result.responseCode == 0){
                                alert("恭喜你注册成功！");
                                location.href="${pageContext.request.contextPath}/front_index";
                                console.log($form.serialize());
                            }
                            else{
                                alert("注册失败："+result.message);
                            }
                        },
                        error:function(){
                            console.log('请求失败');
                        }
                    });
                });
        });
    </script>



</body>

</html>
