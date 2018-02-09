<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%!
//this String is for output
String output = "";
public static final int PAGESIZE = 3;
%>

<%
//this is for page
String pageNoStr = request.getParameter("pageNo");
int pageNo;
if(pageNoStr == null || pageNoStr.equals("")) {
	pageNo = 1;
} else {
	pageNo = Integer.parseInt(pageNoStr.trim());
}

Class.forName("com.mysql.jdbc.Driver");
String connStr = "jdbc:mysql://localhost:3306/bbs?user=root&password=root";
Connection conn = DriverManager.getConnection(connStr);

//this is for count the max page
Statement stmtCount = conn.createStatement();
ResultSet rsCount = stmtCount.executeQuery("select count(*) from article where pid=0");
rsCount.next();
int count = rsCount.getInt(1);
rsCount.close();
stmtCount.close();
int totalPageNo = count%PAGESIZE == 0 ? count/PAGESIZE : count/PAGESIZE + 1;
if(pageNo <= 0) {
	pageNo = 1;
} else if(pageNo > totalPageNo) {
	pageNo = totalPageNo;
}

//this is for every page showing.
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select * from article where pid=0 order by pdate desc limit " + (pageNo-1)*PAGESIZE + ", " + PAGESIZE);
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
		<a class="btn btn-info" href="NewSubjectPl.jsp" role="button">创建新话题</a>
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
		<a href="ShowArticlePanel.jsp?pageNo=1" class="btn btn-primary btn-sm" role="button">首页</a>
		<a href="ShowArticlePanel.jsp?pageNo=<%= totalPageNo %>" class="btn btn-primary btn-sm" role="button">尾页</a>
		<%
		if(totalPageNo == 1) {
		%>
			<a href="ShowArticlePanel.jsp?pageNo=1" class="btn btn-primary btn-sm disabled" role="button">上一页</a>
			<a href="ShowArticlePanel.jsp?pageNo=1" class="btn btn-primary btn-sm disabled" role="button">下一页</a>
		<%
		} else if(pageNo == 1) {
		%>
			<a href="ShowArticlePanel.jsp?pageNo=1" class="btn btn-primary btn-sm disabled" role="button">上一页</a>
			<a href="ShowArticlePanel.jsp?pageNo=<%= pageNo+1 %>" class="btn btn-primary btn-sm" role="button">下一页</a>
		<%	
		} else if(pageNo > 1 && pageNo < totalPageNo) {
		%>
			<a href="ShowArticlePanel.jsp?pageNo=<%= pageNo-1 %>" class="btn btn-primary btn-sm" role="button">上一页</a>
			<a href="ShowArticlePanel.jsp?pageNo=<%= pageNo+1 %>" class="btn btn-primary btn-sm" role="button">下一页</a>
		<%
		} else if(pageNo == totalPageNo) {
		%>
			<a href="ShowArticlePanel.jsp?pageNo=<%= pageNo-1 %>" class="btn btn-primary btn-sm" role="button">上一页</a>
			<a href="ShowArticlePanel.jsp?pageNo=<%= totalPageNo %>" class="btn btn-primary btn-sm disabled" role="button">下一页</a>
		<%
		}
		%>		
		共<%= totalPageNo %>页，第<%= pageNo %>页
	</div>
</body>
<%
if(rs != null) rs.close();
if(stmt != null) stmt.close();
if(conn != null) conn.close();
output = ""; 
%>
</html>