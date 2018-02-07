<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%! public static final boolean SWITCH = true; %>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs?user=root&password=root");

//get the parameter from request
String title = request.getParameter("title");
String cont = request.getParameter("cont");

//make the insert action and alter action a transaction.
conn.setAutoCommit(false);

//this is for insert action
String insertSql = "insert into article values(null, 0, ?, ?, ?, now(), 0)";
PreparedStatement preStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);

preStmt.setInt(1, -1);
preStmt.setString(2, title);
preStmt.setString(3, cont);
preStmt.execute();

//用java API 中的generateKeys获取自增id,需要在获得PreparedStatement的时候指定是否自动产生key
ResultSet rs = preStmt.getGeneratedKeys();
rs.next();
int currentMaxId = rs.getInt(1);
rs.close();
//this is for debug
if(SWITCH) {
	System.out.println("" + currentMaxId);
}

//下面是LAST_INSERT_ID()这种方法去获取自增ID，需要和数据库进行交互，不太方便

/* String sql = "select LAST_INSERT_ID() from article";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
rs.next();
int currentMaxId = rs.getInt(1);
//this is for debug
if(SWITCH) {
	System.out.println("" + currentMaxId);
} */

PreparedStatement stmtUpdate = conn.prepareStatement("update article set rootid=? where id=?");
stmtUpdate.setInt(1, currentMaxId);
stmtUpdate.setInt(2, currentMaxId);
stmtUpdate.execute();

//commit
conn.commit();
conn.setAutoCommit(true);

if(preStmt != null) preStmt.close();
if(stmtUpdate != null) stmtUpdate.close();
if(conn != null) conn.close();
response.sendRedirect("ShowArticleTree.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>