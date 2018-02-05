<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs?user=root&password=root");

//get the parameter from request
int pid = Integer.parseInt(request.getParameter("id"));
int rootId = Integer.parseInt(request.getParameter("rootid"));
int isleaf = Integer.parseInt(request.getParameter("isleaf"));
String title = request.getParameter("title");
String cont = request.getParameter("cont");

//make the insert action and alter action a transaction.
conn.setAutoCommit(false);

//this is for insert action
String insertSql = "insert into article values(null, ?, ?, ?, ?,now(),0)";
PreparedStatement preStmt = conn.prepareStatement(insertSql);

//this is for alter action
String alterSql = "update article set isleaf = 1 where id = " + pid;
Statement stmt = conn.createStatement();
//1.insert into article a row.

preStmt.setInt(1, pid);
preStmt.setInt(2, rootId);
preStmt.setString(3, title);
preStmt.setString(4, cont);
preStmt.execute();
//2.alter the row'isleaf column who has been replied
if(0 == isleaf) {
	stmt.execute(alterSql);
}
//3.commit
conn.commit();
conn.setAutoCommit(true);

if(preStmt != null) preStmt.close();
if(stmt != null) stmt.close();
if(conn != null) conn.close();
response.sendRedirect("ShowArticleTree.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ReplyOK</title>
</head>
<body>

</body>
</html>