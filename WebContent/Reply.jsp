<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Reply</title>
	<!-- Bootstrap 核心 CSS 文件 -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<!--font-awesome 核心CSS 文件，该文件可以用于显示输入框里面一些小的icon-->
	<link href="css/font-awesome.min.css" rel="stylesheet">
	<!-- 在bootstrap.min.js 之前引入 -->
	<script src="js/jquery-3.2.1.min.js"></script>
	<!-- Bootstrap 核心 JavaScript 文件 -->
	<script src="js/bootstrap.min.js"></script>
	<!--jquery.validate-->
	<script type="text/javascript" src="js/jquery.validate.min.js" ></script>
	<!-- 添加自定义的表单验证，可以参考http://www.runoob.com/jquery/jquery-plugin-validate.html -->
	<script type="text/javascript" src="js/additional-methods.js" ></script>
	<!-- 表单验证的出错的默认消息 -->
	<script type="text/javascript" src="js/messages_zh.js" ></script>
	<!-- 表单验证，以及同一个页面登录注册之间的切换的实现 -->
	<script type="text/javascript" src="js/main.js" ></script>
	<style type="text/css">
		body{background: url(img/4.jpg) no-repeat;background-size: cover;font-size: 16px;}
		.form{background: rgba(255,255,255,0.2);width:400px;margin:100px auto;}
		#reply_form{display: block;}			
		.fa{display: inline-block;top: 27px;left: 6px;position: relative;color: #ccc;}
		input[type="text"],input[type="password"]{padding-left:26px;}
		.checkbox{padding-left:21px;}
		/* 表单验证不符合时，提示消息字体颜色 */
		.error{	color:red;}
	</style>
</head>
<body>
	<div class="container">
		<form action="ReplyOK.jsp" id="reply_form" method="get" class="form-horizontal" role="form">
			<input type="hidden" name="id" value="<%= request.getParameter("id") %>">
			<input type="hidden" name="rootid" value="<%=request.getParameter("rootid") %>">
			<input type="hidden" name="isleaf" value="<%=request.getParameter("isleaf") %>">
			<fieldset>
        		<legend>Title(标题)</legend>
        		<div class="form-group">
          			<label class="col-sm-2 control-label" for="inputUsername">Title</label>
            		<div class="col-sm-10">
              			<input class="form-control" id="inputUsername" type="text" name="title" placeholder="Title"/>
            		</div>
        		</div>
      		</fieldset>
      		<fieldset>
        		<legend>Content(内容)</legend>
        		<div class="form-group">
          			<label class="col-sm-2 control-label" for="introduce">Content</label>
            		<div class="col-sm-10">
              			<textarea class="form-control" rows="10" id="introduce" name="cont" placeholder="content"></textarea>              
            		</div>
        		</div>
      		</fieldset>
   		    <div class="row">
       			<div class="col-md-6 col-md-offset-6">
        			<button type="submit" class="btn btn-default">提交</button>
       			</div>          			
      		</div>
		</form>
	</div>
</body>
</html>