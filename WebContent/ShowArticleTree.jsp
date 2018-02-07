<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%!
//this String is for output
String output = "";
//this function is for finding this id'sons,and output them
private void tree(Connection conn, int id, int level) {
	Statement stmt = null;
	ResultSet rs = null;
	String preStr = "";
	for(int i=0; i<level; i++) {
		preStr = preStr + "----";
	}
	try {
		stmt = conn.createStatement();
		//find this id's sons
		rs = stmt.executeQuery("select * from article where pid=" + id);
		while(rs.next()) {
			output = output + "<tr><td>" + rs.getInt("id") + "</td><td>" + preStr + 
					"<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + rs.getString("title") + "</a>" +
					"</td><td><a href='Delete.jsp?id=" + rs.getInt("id") + "&pid=" + rs.getInt("pid") + "'>删除</a>" + "</td></tr>";
			if(rs.getInt("isleaf") != 0) {
				tree(conn, rs.getInt("id"), level+1);
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
%>

<%
	Class.forName("com.mysql.jdbc.Driver");
	String connStr = "jdbc:mysql://localhost:3306/bbs?user=root&password=root";
	Connection conn = DriverManager.getConnection(connStr);
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article where pid=0");
	while(rs.next()) {
		output = output + "<tr><td>" + rs.getInt("id") + "</td><td>" + 
				"<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + rs.getString("title") + "</a></td><td>" +
				"<a href='Delete.jsp?id=" + rs.getInt("id") + "&pid=" + rs.getInt("pid") + "'>删除</a>" + "</td></tr>";
		if(rs.getInt("isleaf") != 0) {
			tree(conn, rs.getInt("id"), 1);
		}
	}
	if(rs != null) rs.close();
	if(stmt != null) stmt.close();
	if(conn != null) conn.close();
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
			<%= output %>
		</table>
		<a class="btn btn-info" href="NewSubject.jsp" role="button">创建新话题</a>
	</div>
</body>
<% output=""; %>
</html>