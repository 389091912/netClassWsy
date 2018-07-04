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
<title>用户管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/back-index.css" />
<script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-mypaginator.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath }/js/template-web.js" charset="utf-8" ></script>

    <script type="text/javascript" charset="utf-8">
	$(function() {
		$(".doModify").on("click", function() {
			$(".modal-title").html("用户修改");
			$("#myModal").modal("show");
		});
		$(".updateOne").on("click", function() {
			$("#myModal").modal("hide");
		});

		// 显示隐藏查询列表
		$('#show-user-search').click(function() {
			$('#show-user-search').hide();
			$('#upp-user-search').show();
			$('.showusersearch').slideDown(500);
		});
		$('#upp-user-search').click(function() {
			$('#show-user-search').show();
			$('#upp-user-search').hide();
			$('.showusersearch').slideUp(500);
		});


	});

</script>
	<script type="text/javascript">
        function showUser(id){
            var data = "";
            if(id == undefined || id == null || id == ""){
                data = $("#myForm").serialize();
                console.log("serialize:", data);
            }else{
                data = "id=" + id;
            }
            $.ajax({
                "url" : "${pageContext.request.contextPath }/user/findByUser",
                "type" : "post",
                "dataType" : "json",
                "data" : data,//"user.id="+id,
                "success" : function(result){
                  if(result.responseCode==0){
					  $("#user_id").val(result.returnObject.id),
					  $("#nickname").val(result.returnObject.nickname),
					  $("#roleName").find("option[value='" + result.returnObject.role+ "']").attr("selected", true);
					  $("#email").val(result.returnObject.email)
				  }

                },
                "error" : function(){
                    console.log("error");
                }
            });

        }

        function modifyUserStatus(id,status){
            $.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/user/modifyStatus",
				data:{
				    "id":id,
					"flag":status
				},
				dataType:"json",
				success:function (result) {
					if(result.responseCode==0){
                        ajaxLoadData({
							'pageNo': $("#pageNo").val(),
                            'username':$("#user_name").val(),
                            'nickname':$("#user-nickname").val(),
                            'email':$("#user-email").val()

                        });
					}
                }
			});
		}



	</script>



</head>

<body>
	<div class="panel panel-default" id="userInfo">
		<div class="panel-heading">
			<h3 class="panel-title">用户管理</h3>
		</div>
		<div>
			<input type="hidden" name="pageNo" id="pageNo" value="${userList.pageNum}">
			<input type="button" value="查询" class="btn btn-success" id="doSearch"
				style="margin: 5px 5px 5px 15px;" /> <input type="button"
				class="btn btn-primary" id="show-user-search" value="展开搜索" /> <input
				type="button" value="收起搜索" class="btn btn-primary"
				id="upp-user-search" style="display: none;" />
		</div>

		<div class="panel-body">
			<div class="showusersearch" style="display: none;">
				<form class="form-horizontal" id="fromUser">
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label for="user_name" class="col-xs-3 control-label">登录名：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="user_name" name="username" placeholder="请输入登录名"  />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label for="user-nickname" class="col-xs-3 control-label">昵称：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="user-nickname" name="nickname"
									placeholder="请输入昵称" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label for="user-email" class="col-xs-3 control-label">邮箱：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="user-email" name="email"
									placeholder="请输入邮箱" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label for="role-name" class="col-xs-3 control-label">角色：</label>
							<div class="col-xs-8">
								<select class="form-control" id="role-name" name="role-name">
									<option value="a">全部</option>
									<option value="normal">普通</option>
									<option value="admin">管理员</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">开始日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="createStartDate" name="createStartDate"
									placeholder="请输入创建开始时间:2017-10-10" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">结束日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="createEndDate" name="createEndDate"
									placeholder="请输入创建结束时间:2017-10-12" />
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">开始日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="loginStartDate"  name="loginStartDate"
									placeholder="请输入登录开始时间:2017-10-10" />
							</div>
						</div>
						<div class="form-group col-xs-6">
							<label class="col-xs-3 control-label">结束日期：</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" id="outStartDate" name="outStartDate"
									placeholder="请输入登录结束时间:2017-10-12" />
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="show-list">
				<table class="table table-bordered table-hover"
					style='text-align: center;'>
					<thead>
						<tr class="text-danger">
							<th class="text-center">编号</th>
							<th class="text-center">登录名</th>
							<th class="text-center">角色</th>
							<th class="text-center">昵称</th>
							<th class="text-center">邮箱</th>
							<th class="text-center">创建日期</th>
							<th class="text-center">最近登录日期</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="userList">

					</tbody>
                    <script id="userListTemplate" type="text/html">
                        {{each userList as item}}
                        <tr>
                            <td><a href="javascript:showUser('{{item.id}}');">{{item.id}}</a></td>
                            <td>{{item.username}}</td>
                            <td>{{item.role}}</td>
                            <td>{{item.nickname}}</td>
                            <td>{{item.email}}</td>
                            <td>{{item.createDateStr}}</td>
                            <td>{{item.loginDateStr}}</td>
                            <td class="text-center">
                                <input type="button" onclick="showUser('{{item.id}}')" class="btn btn-warning btn-sm doModify" value="修改" />
								{{if item.flag == 0}}
								<input type="button" onclick="modifyUserStatus('{{item.id}}','{{item.flag}}')" class="btn btn-danger btn-sm" value="禁用" />
								{{else}}
								<input type="button" onclick="modifyUserStatus('{{item.id}}','{{item.flag}}')" class="btn btn-success btn-sm" value="启用" />
								{{/if}}
                            </td >

                        </tr>
                        {{/each}}
                    </script>

				</table>
			</div>
			<!-- 分页 -->
			<div style="text-align: center;">
				<ul id="myPages"></ul>
				<input id="currentPageInput" type="hidden" value="" />
			</div>

			<div class="modal fade" tabindex="-1" id="myModal">
				<!-- 窗口声明 -->
				<div class="modal-dialog modal-lg">
					<!-- 内容声明 -->
					<div class="modal-content">
						<!-- 头部、主体、脚注 -->


						<div class="modal-header">
							<button class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">用户修改</h4>
						</div>
						<form id="userModify">
							<div class="modal-body text-center">
								<div class="row text-right">
									<label for="user_id" class="col-xs-4 control-label">编号：</label>
									<div class="col-xs-4">
										<input type="text" class="form-control" id="user_id" name="id"
											readonly="true" />
									</div>
								</div>
								<br>
								<div class="row text-right">
									<label for="nickname" class="col-xs-4 control-label">昵称：</label>
									<div class="col-xs-4">
										<input type="text" class="form-control" id="nickname" name="nickname" maxlength="15" />
									</div>
								</div>
								<br>
								<div class="row text-right">
									<label for="roleName" class="col-xs-4 control-label">角色：</label>
									<div class="col-xs-4">
										<select name="role" id="roleName" class="form-control">
											<option value="admin">管理员</option>
											<option value="normal">普通用户</option>
										</select>

									</div>
								</div>
								<br>
								<div class="row text-right">
									<label for="password" class="col-xs-4 control-label">密码：</label>
									<div class="col-xs-4">
										<input type="password" class="form-control" id="password" name="password" maxlength="16" />
									</div>
								</div>
								<br>
								<div class="row text-right">
									<label for="email" class="col-xs-4 control-label">邮箱：</label>
									<div class="col-xs-4">
										<input type="email" class="form-control" id="email" name="email" />
									</div>
								</div>
								<br>
							</div>
							<div class="modal-footer">
								<%--<button class="btn btn-warning updateOne" onclick="submitModifyUser()" >修改</button>--%>
									<input type="button" class="btn btn-warning updateOne" onclick="submitModifyUser()" value="修改">
								<button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>
	</div>
    <script type="text/javascript" charset="utf-8">
        myoptions.onPageClicked = function(event, originalEvent, type, page){
            ajaxLoadData({
                'pageNo': page,
                'username':$("#user_name").val(),
                'nickname':$("#user-nickname").val(),
                'email':$("#user-email").val(),
                'createStartDate':$("#createStartDate").val(),
                'createEndDate':$("#createEndDate").val(),
                'loginStartDate':$("#loginStartDate").val(),
                'outStartDate':$("#outStartDate").val(),
                'role':$("#role-name").val()
            });
        };
        $(function () {
            ajaxLoadData({
                'pageNo': 1,
                'username':$("#user_name").val(),
                'nickname':$("#user-nickname").val(),
                'email':$("#user-email").val(),
                'createStartDate':$("#createStartDate").val(),
                'createEndDate':$("#createEndDate").val(),
                'loginStartDate':$("#loginStartDate").val(),
                'outStartDate':$("#outStartDate").val(),
                'role':$("#role-name").val()
            });

           $("#doSearch").click(function(){
                ajaxLoadData({
                    'pageNo': 1,
                    'username':$("#user_name").val(),
                    'nickname':$("#user-nickname").val(),
                    'email':$("#user-email").val(),
                    'createStartDate':$("#createStartDate").val(),
                    'createEndDate':$("#createEndDate").val(),
                    'loginStartDate':$("#loginStartDate").val(),
                    'outStartDate':$("#outStartDate").val(),
                     'role':$("#role-name").val()
                });

            });

        });

        function ajaxLoadData(params){
            $.ajax({
                "type": "post",
                "dataType": "json",
                "url" : "${pageContext.request.contextPath }/user/back/findAllUserByAjax",
                "data" : params,
                "success" : function(data){
                    var list = data.list;//当前页的数据数组
                    console.log(list);
                    $("#userList").html("");
                    var d = {
                        "userList": list  //json
                    };
                    var txt = template("userListTemplate", d);

                    $("#userList").html(txt);

                    var totalPages = data.pages;//新数据的总页数
                    if(totalPages == 0){
                        totalPages = 1;
                    }
                    $(".doModify").on("click", function() {
                        $(".modal-title").html("用户修改");
                        $("#myModal").modal("show");
                    });
                    $(".updateOne").on("click", function() {
                        $("#myModal").modal("hide");
                    });
                    $("#pageNo").val(params.pageNo);
                    myPaginatorFun("myPages", params.pageNo, totalPages);
                },

                "error" : function(){
                    alert("此条件,没有用户存在！！");
                }
            });
        }

        function submitModifyUser() {
            data01 = $("#userModify").serialize();
            console.log(data01);
            $.ajax({
                "type":"post",
                "url":"${pageContext.request.contextPath}/user/modifyUser",
                "data":data01,
                dataType:"json",
                success:function (result) {
                    if(result.responseCode==0){
                        ajaxLoadData({
                            'pageNo': $("#pageNo").val()
                        })
                    }
                    else{
                        $("#errorMsg").tooltip({
                            title:"error",
                            placement:"center",
                            //template表示显示的错误信息
                            template:"<div class='tooltip errorMsg'>"+result.Msg+"</div>",
                            tigger:"manual",
                        }).tooltip("show");
                        /*       alert(result.Msg);*/
                    }
                }


            });

        }

    </script>

	<script type="text/javascript">
        $(function(){
            $('#fromUser')
                .bootstrapValidator({
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        username: {
                            message: '用户名校验失败！',
                            validators: {

                                stringLength: {
                                    min: 0,
                                    max: 18,
                                    message: '用户名长度必须在0-18位之间'
                                },
                                regexp: {
                                    regexp: /^[0-9a-zA-Z]+$/,
                                    message: '用户名只能包含数字、字母'
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
                        email: {
                            validators: {
                                emailAddress: {
                                    message: '邮箱格式不正确'
                                }
                            }
                        },
                        createStartDate: {
                            validators: {
                                date: {
                                    format: 'YYYY-MM-DD',
                                    message: '日期格式错误'
                                }
                            }
                        },
                        createEndDate: {
                            validators: {
                                date: {
                                    format: 'YYYY-MM-DD',
                                    message: '日期格式错误'
                                }
                            }
                        },
                        loginStartDate: {
                            validators: {
                                date: {
                                    format: 'YYYY-MM-DD',
                                    message: '日期格式错误'
                                }
                            }
                        },
                        outStartDate: {
                            validators: {
                                date: {
                                    format: 'YYYY-MM-DD',
                                    message: '日期格式错误'
                                }
                            }
                        }
                    }
                });

        });



	</script>

</body>

</html>
