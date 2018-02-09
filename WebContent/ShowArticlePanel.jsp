<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%!
//this String is for output
String output = "";
%>

<%
	Class.forName("com.mysql.jdbc.Driver");
	String connStr = "jdbc:mysql://localhost:3306/bbs?user=root&password=root";
	Connection conn = DriverManager.getConnection(connStr);
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article where pid=0");
	/* while(rs.next()) {		
		output = output + "<tr><td>" + rs.getInt("id") + "</td><td>" + 
				"<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + rs.getString("title") + "</a></td>" + "</tr>";		
	} */
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BBS Panel</title>
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
					<td><a href='ShowArticleDetail.jsp?id=<%= rs.getInt("id") %>'><%= rs.getString("title") %></a></td>
				</tr>
			<%	
			}
			%>
		</table>
		<a class="btn btn-info" href="NewSubjectPl.jsp" role="button">创建新话题</a>
	</div>
</body>
<%
if(rs != null) rs.close();
if(stmt != null) stmt.close();
if(conn != null) conn.close();
output = ""; 
%>
</html>