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
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>课程类别管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(function(){

            var pages;
            if("${pageTypes.pages}"==0)
            {
                pages==1;
            }
            else{
                pages="${pageTypes.pages}";
            }

            var options = {
                bootstrapMajorVersion:3, //表示当前bootstrap版本号
                currentPage:"${pageTypes.pageNum}",//当前页
                totalPages:pages,//总页数
                size:"normal",
                aligment:"center",
                pageUrl:function(type,page,current){
                    return "${pageContext.request.contextPath}/courseType/findCourseType?parentId="+$("input[name='parent_id']").val()+"&pageNo="+page;
                }

            };

            $("#myPages").bootstrapPaginator(options);


            $("#doAddCourseType").on("click", function() {
                $("#courseType-id-input").hide();
                $("#courseTypeModal").modal("show");
            });
            $(".courseType-btn").on("click", function() {
                $("#courseTypeModal").modal("hide");
            });

            $(".courseType-modify").on("click", function() {
                $("#courseType-id-input").show();
                $("#courseTypeModal").modal("show");
            });

            //查询子类别
            $(".course-type-detail").on("click", function() {
                $('#frame-id', window.parent.document).attr('src',"/courseType/findNowChildCourseType?id="+$(this).attr("data-id"));
            });
            //返回父类别列表页面
            $("#back").on("click", function() {
                $('#frame-id', window.parent.document).attr('src', "/courseType/findParentCourseType?id="+$(this).attr("data-id"));
            });


            $("#doAddCourseType").click(function () {
                $("#courseType-id").val("");
                $("#courseType-name").val("");
            });

            $("#courseType-name").blur(function(){
                $("#errorMsg").text("");
                var reg = /^[A-Za-z0-9\u4e00-\u9fa5]+$/;
                var name=$(this).val();
                if(reg.test(name)){
                    $("#submitCourseType").removeAttr("disabled");
                    $("#errorMsg").text("");
                }else{
                    $("#errorMsg").text("只能输入中文，英文，数字");
                    $("#errorMsg").css("color","red");
                    $("#submitCourseType").attr("disabled","disabled");
                }

            });








            $("#submitCourseType").click(function () {
                $.ajax({
                    type:"post",
                    url:"${pageContext.request.contextPath}/courseType/addOrModifyCourseType",
                    data:
                        {
                            id:$("#courseType-id").val(),
                            typeName: $("#courseType-name").val(),
                            parentId:$("input[name='parent_id']").val()
                        },
                    dataType:"json",
                    success:function(result){
                        if(result.responseCode == 0){
                            console.log("123");
                            console.log($("input[name='parent_id']").val());
                            console.log($("input[name='pageNo']").val());
                            location.href="${pageContext.request.contextPath}/courseType/findCourseType?parentId="+$("input[name='parent_id']").val()+"&pageNo="+$("input[name='pageNo']").val();
                        }else{
                          /*  $("#errorMsg").tooltip({
                                title:"error",
                                placement:"center",
                                //template表示显示的错误信息
                                template:"<div class='tooltip errorMsg'>"+result.message+"</div>",
                                tigger:"manual",
                            }).tooltip("show");*/
                            alert(result.message);
                        }
                    }

                });

            });

            $("input[name='toModifyType']").click(function () {
                $.ajax({
                    type:"post",
                    url:"${pageContext.request.contextPath}/courseType/findCourseTypeById",
                    data:{
                        "id":$(this).attr("data-id")
                        },
                    dataType:"json",
                    success:function (result) {
                        if(result.responseCode == 0){
                                $("#courseType-id").val(result.returnObject.id),
                                $("#courseType-name").val(result.returnObject.typeName)
                        }else{
                           /* $("#errorMsg").tooltip({
                                title:"error",
                                placement:"center",
                                //template表示显示的错误信息
                                template:"<div class='tooltip errorMsg'>"+result.message+"</div>",
                                tigger:"manual",
                            }).tooltip("show");*/
                            alert(result.message);
                        }

                    }


                });
            });



            $("input[name='tomodifyStatus']").click(function () {
                $.ajax({
                    type:"post",
                    url:"${pageContext.request.contextPath}/courseType/modifyStatus",
                    data:{
                        "id":$(this).attr("data-id")
                    },
                    dataType:"json",
                    success:function (result) {
                        if(result.responseCode == 0){

                        location.href="${pageContext.request.contextPath}/courseType/findCourseType?parentId="+$("input[name='parent_id']").val()+"&pageNo="+$("input[name='pageNo']").val();

                        }else{
                            /*$("#errorMsg").tooltip({
                                title:"error",
                                placement:"center",
                                //template表示显示的错误信息
                                template:"<div class='tooltip errorMsg'>"+result.message+"</div>",
                                tigger:"manual",
                            }).tooltip("show");*/
                            alert(result.message);
                        }

                    }


                });
            });



        });

    </script>


</head>

<body>

    <!-- 课程类别管理 -->
    <div class="panel panel-default" id="departmentSet">
        <div class="panel-heading">
            <h3 class="panel-title">课程类别管理</h3>
        </div>
        <div class="panel-body">
            <input type="button" value="添加课程类别" class="btn btn-primary" id="doAddCourseType" />
            <!-- courseType父类别id,没有时,移除此按钮 -->
            <c:if test="${pageTypes.list[0].parent != null}">
                <input type="button" value="返回上级列表" class="btn btn-success" data-id="${pageTypes.list[0].parent.id}" id="back" style="float: right;" />
            </c:if>
            <input type="hidden" name="parent_id" value="${pageTypes.list[0].parent.id}"  />
            <input type="hidden" name="pageNo" value="${pageTypes.pageNum}"  />
            <br>
            <br>
            <div class="modal fade" tabindex="-1" id="courseTypeModal">
                <!-- 窗口声明 -->
                <div class="modal-dialog modal-lg">
                    <!-- 内容声明 -->
                    <div class="modal-content">
                        <!-- 头部、主体、脚注 -->
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">添加类别</h4>
                        </div>
                        <form id="myForm">
                        <div class="modal-body text-center">
                            <div class="row text-right" id="courseType-id-input" >
                                <label for="courseType-id" class="col-sm-4 control-label">编号：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="courseType-id" readonly="true" />
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="courseType-name" class="col-sm-4 control-label">类别名称：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="courseType-name" maxlength="18" />
                                </div>
                            </div>
                            <span id="errorMsg" name="errorMsg" style="margin-top:-5px "></span>

                            <br>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-primary courseType-btn" id="submitCourseType" value="确定"></input>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                        </div>
                        </form>
                    </div>

                </div>
            </div>
            <div class="show-list">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                        <tr class="text-danger">
                            <th class="text-center">编号</th>
                            <th class="text-center">名称</th>
                            <th class="text-center">状态</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>
                    <tbody id="tb">
                    <c:forEach items="${pageTypes.list}" var="type">
                        <c:if test="${type.id != null }">
                        <tr>
                            <td>${type.id}</td>
                            <td>${type.typeName}</td>
                            <td>
                                <c:if test="${type.status eq 0}">启用</c:if>
                                <c:if test="${type.status eq 1}">禁用</c:if>
                            </td>
                            <td>
                                <input type="button" class="btn btn-warning btn-sm courseType-modify" name="toModifyType" data-id="${type.id}" value="修改" />
                                <c:if test="${type.status eq 0}">
                                    <input type="button" class="btn btn-danger btn-sm" name="tomodifyStatus" data-id="${type.id}" value="禁用" />
                                </c:if>
                                <c:if test="${type.status eq 1}">
                                       <input type="button" class="btn btn-success btn-sm" name="tomodifyStatus" data-id="${type.id}" value="启用" />
                                </c:if>
                                <input type="button" name="findNowChild" class="btn btn-success btn-sm course-type-detail" data-id="${type.id}" value="查询子类别" />
                            </td>
                        </tr>
                    </c:if>
                    </c:forEach>

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
