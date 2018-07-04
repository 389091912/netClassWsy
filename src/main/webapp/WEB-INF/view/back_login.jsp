<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>优学堂精品课程管理系统登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css" type="text/css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
  </head>
  <script type="text/javascript">
      $(function(){
          $("#changeCode").click(function(){
              $("#image").attr("src","${pageContext.request.contextPath}/code/getCodeImage?id="+new Date().getTime());
          });


          $("#checkCode").mouseout(function(){
              var userCode=$(this).val();
              $.ajax({
                  type:"post",
                  url:"${pageContext.request.contextPath}/code/getCodeStr",
                  dataType:"json",
                  success:function(data){
                      console.log(data);
                      if(userCode!=data.obj){
                          $("#va").text("验证码错误");
                          $("#alert").show();
                          $("#submit").attr("disabled","disabled");
                      }
                      else{
                          $("#submit").removeAttr("disabled");
                          $("#va").text("");
                          $("#alert").hide();
                      }
                  },
                  error:function(){
                      $("#va").text("error");
                  }
              });
          });
          if($("#va").text()==""){
              $("#alert").hide();
              return;
          }else{
              $("#alert").show();
          }

      });

  </script>
  <body>
  	<!-- 使用自定义css样式 div-signin 完成元素居中-->
    <div class="containercc div-signin" style="position: relative; top: 50%; margin-top: -215px;">
          <div class="panel panel-primary div-shadow">
      	<!-- h3标签加载自定义样式，完成文字居中和上下间距调整 -->
	    <div class="panel-heading">
	    	<h3> 优学堂精品课程管理系统</h3>
	    	<span>High-quality Courses Manager System</span>
	    </div>
	    <div class="panel-body">
	      <!-- login form start -->
	      <form action="${pageContext.request.contextPath}/user/back/backLogin" class="form-horizontal ccc" method="post">
		    <div class="form-group">
		       <label class="col-xs-3 control-label">用户名：</label>
		       <div class="col-xs-9">
				   <input class="form-control" type="text" placeholder="请输入用户名" name="username" required oninvalid="setCustomValidity('用户名不能为空')" oninput="setCustomValidity('');">
		       </div>
		    </div>
		    <div class="form-group">
		       <label class="col-xs-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
		       <div class="col-xs-9">
				   <input class="form-control" type="password" placeholder="请输入密码" name="password" required oninvalid="setCustomValidity('密码不能为空')" oninput="setCustomValidity('');" title="密码不能为空">
		       </div>
		    </div>
		    <div class="form-group">
		       <label class="col-xs-3 control-label">验证码：</label>
		       <div class="col-xs-4">
				   <input class="form-control" type="text" placeholder="请输入验证码" name="code" id="checkCode" required oninvalid="setCustomValidity('验证码不能为空')" oninput="setCustomValidity('');" title="验证码不能为空" >
		       </div>
		       <div class="col-xs-2">
		       	  <!-- 验证码图片加载（需引入验证码文件）图像高度经过测试，建议不要修改 -->
			      <img class="img-rounded" id="image" src="${pageContext.request.contextPath}/code/getCodeImage" alt="验证码" style="height: 32px; width: 70px;"/>
		       </div>
		       <div class="col-xs-2">
		         <button type="button" class="btn btn-link" id="changeCode">看不清</button>
		       </div>
		    </div>
		    <br/>
		    <div class="form-group">
		       <div class="col-xs-9  col-xs-offset-3 padding-left-0">
		       	 <div class="col-xs-6">
			         <button type="reset" class="btn btn-primary btn-block">重&nbsp;&nbsp;置</button>
		       	 </div>
		       	 <div class="col-xs-6">
			         <button type="submit" class="btn btn-primary btn-block" id="submit">登&nbsp;&nbsp;录</button>
		       	 </div>
		       </div>
		    </div>
	      </form>
	      <!-- login form end -->
			<div class="form-group" style="margin-left: 80px;">
				<div class="col-xs-5">
					<div class="alert alert-danger alert-dismissible" role="alert" id="alert">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close" ><span aria-hidden="true">&times;</span></button>
						<strong id="va">${loginMsg}</strong>
					</div>
				</div>
			</div>

	    </div>
	  </div>
    </div>
    <!-- 页尾 版权声明 -->

  </body>
</html>

