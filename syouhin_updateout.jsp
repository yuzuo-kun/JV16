<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%
	String session_name = (String)session.getAttribute("login_name");
	if(session_name == null) {
		response.sendRedirect("syouhin_index.jsp");
	}

	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String syou_no = request.getParameter("syou_no");
	String syou_name = request.getParameter("syou_name");
	String pre_no = request.getParameter("syou_pre");
	String syou_msg = request.getParameter("syou_msg");
	String syou_icon = request.getParameter("syou_icon");

	//データベースに接続するために使用する変数宣言
	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	//ローカルのMySQLに接続する設定
	String USER = "root";
	String PASWORD = "root";
	String URL = "jdbc:mysql://localhost/nhs30061db";
	String DRIVER = "com.mysql.jdbc.Driver";

	//確認メッセージ
	StringBuffer ERMSG = null;

	int upd_cnt = 0;

	//HashMap(1件分のデータを格納する連想配列)
	HashMap<String, String> map = null;

	try {//ロードに失敗したときのための例外処理
			//JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();

		//Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASWORD);

		//Statementオブジェクトの作成
		stmt = con.createStatement();

		//SQLステートメントの作成(選択クエリ)
		SQL = new StringBuffer();

		//SQL文の発行(選択クエリ)
		SQL.append("update syou_tbl set syou_name = '");
		SQL.append(syou_name);
		SQL.append("', syou_pre = ");
		SQL.append(pre_no);
		SQL.append(", syou_msg = '");
		SQL.append(syou_msg);
		SQL.append("', syou_icon = ");
		SQL.append(syou_icon);
		SQL.append(" where syou_no = ");
		SQL.append(syou_no);
		upd_cnt = stmt.executeUpdate(SQL.toString());
	}

	catch (ClassNotFoundException e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
		out.println("ClassNotFoundException: " + ERMSG.toString());
	} catch (SQLException e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
		out.println("SQLException: " + ERMSG.toString());
	} catch (Exception e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
		out.println("Exception: " + ERMSG.toString());
	}

	finally {//例外があってもなくても必ず実行する
				//各種オブジェクトクローズ
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
		} catch (SQLException e) {
			ERMSG = new StringBuffer();
			ERMSG.append(e.getMessage());
		}
	}
%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>商品変更</title>
</head>
<body bgcolor="#ffffff">
	商品変更
	<%
		if (upd_cnt == 0) { // 更新処理失敗
	%>
	更新NG
	<br>
	<%="更新処理が失敗しました"%>
	<%
		} else { // 更新OK
	%>
	更新OK
	<br>
	<%=upd_cnt + "件 更新完了しました"%>
	<%
		}
	%>
	<div style="display:flex">
		<form action="/JV16/syouhin_main.jsp" method="post">
			<input type="submit" value="商品一覧に戻る">
		</form>
		<form method="post" action="syouhin_index.jsp">
			<input type="hidden" name="logout" value="loglout">
			<button type="submit">ログアウト</button>
		</form>
	</div>
</body>
</html>