<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String session_name = (String)session.getAttribute("login_name");
	if(session_name == null) {
		response.sendRedirect("syouhin_index.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String syou_no = request.getParameter("syou_no");
	Connection con = null;
	Statement stmt = null;
	StringBuffer sql = null;
	ResultSet rs = null;
	String user = "root";
	String password = "root";
	String url = "jdbc:mysql://localhost/nhs30061db";
	String driver = "com.mysql.jdbc.Driver";
	StringBuffer ERMSG = null;
	int del_count = 0;
	try {
		Class.forName(driver).newInstance();
		con = DriverManager.getConnection(url, user, password);
		stmt = con.createStatement();
		sql = new StringBuffer();
		sql.append("DELETE FROM syou_tbl WHERE syou_no = ");
		sql.append(syou_no);
		del_count = stmt.executeUpdate(sql.toString());
	} catch (ClassNotFoundException e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	} catch (SQLException e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	} catch (Exception e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	} finally {

		try {

			if (rs != null) {

				rs.close();

			}

			if (stmt != null) {

				stmt.close();

			}

			if (con != null) {

				con.close();

			}

		}

		catch (SQLException e) {

			ERMSG = new StringBuffer();

			ERMSG.append(e.getMessage());

		}

	}
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>商品削除</title>

</head>

<body>

	<%
		if (del_count == 0) {
	%>

	削除NG
	<br>

	<%="商品削除が失敗しました"%>

	<%
		} else {
	%>

	削除OK
	<br>
	<%=del_count + "件　商品削除が完了しました"%>

	<%
		}
	%>
	<br>
	<br>
	<div style="display:flex">
		<form method="post" action="/JV16/syouhin_main.jsp">
			<button type="submit">商品一覧に戻る</button>
		</form>
		<form method="post" action="syouhin_index.jsp">
			<input type="hidden" name="logout" value="loglout">
			<button type="submit">ログアウト</button>
		</form>
	</div>

</body>

</html>