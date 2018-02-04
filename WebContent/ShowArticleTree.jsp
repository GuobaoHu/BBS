<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	String connStr = "jdbc:mysql://localhost:3306/bbs?user=root&password=root";
	Connection conn = DriverManager.getConnection(connStr);
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>BBS</title>
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
		<table class="table">
			<%
				while(rs.next()) {
			%>
				<tr>
				<td><%= rs.getInt("id") %></td>
				<td><%= rs.getString("cont") %></td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
<% 
	rs.close();
	stmt.close();
	conn.close(); 
%>
</html>