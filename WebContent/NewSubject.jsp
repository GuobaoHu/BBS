<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>New Subject</title>
<link href="<%= this.getServletContext().getContextPath() %>/css/bootstrap.min.css" rel="stylesheet" media="screen">
<!-- 这一行必须在下面一行前面 -->
<script src="<%= this.getServletContext().getContextPath() %>/js/jquery-3.2.1.min.js"></script>
<script src="<%= this.getServletContext().getContextPath() %>/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
</head>
<body>
	<div class="container">
		<form action="FinishNew.jsp" method="get" class="form-horizontal" role="form">			
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
        			<button type="submit" class="btn btn-success">完成</button>
       			</div>          			
      		</div>
		</form>
	</div>
</body>
</html>