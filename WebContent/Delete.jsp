<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%! 
//递归删除记录，模拟好一次：传一个id进来，该id有儿子没，有删儿子（调用方法本身），完成之后把自己删了，则一次递归完成。
private void del(Connection conn, int id) {
	Statement stmt = null;
	ResultSet rs = null;
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from article where pid = " + id);
		while(rs.next()) {
			del(conn, rs.getInt("id"));
			/* Statement stmtDel = conn.createStatement();
			stmtDel.executeUpdate("delete * from article where id = " + rs.getInt("id"));
			stmtDel.close(); */
		}
		Statement stmtDel = conn.createStatement();
		stmtDel.executeUpdate("delete from article where id = " + id);
		stmtDel.close();
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}

%>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs?user=root&password=root");

//get the parameter from request
int id = Integer.parseInt(request.getParameter("id"));
int pid = Integer.parseInt(request.getParameter("pid"));

//make the delete action and alter action a transaction.
conn.setAutoCommit(false);

//this is for delete action
del(conn, id);

//this is for alter action
String sql = "select count(*) from article where pid = " + pid;
Statement stmt = conn.createStatement();
Statement stmtUpd = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
rs.next();
if(rs.getInt(1) <= 0) {
	String sqlUpdate = "update article set isleaf=0 where id=" + pid;
	stmtUpd = conn.createStatement();
	stmtUpd.executeUpdate(sqlUpdate);
}

//3.commit
conn.commit();
conn.setAutoCommit(true);

if(stmtUpd != null) stmtUpd.close();
if(stmt != null) stmt.close();
if(conn != null) conn.close();
response.sendRedirect("ShowArticleTree.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete</title>
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

</body>
</html>