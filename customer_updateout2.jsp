<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String cus_noStr = request.getParameter("cus_no");
	String cus_idStr = request.getParameter("cus_id");
	String cus_pasStr = request.getParameter("cus_pas");
	String cus_nameStr = request.getParameter("cus_name");

	//データベースに接続するために使用する変数宣言
	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	//ローカルのMySQLに接続する設定
	String USER = "root";
	String PASSWORD = "root";
	String URL = "jdbc:mysql://localhost/nhs30061db";

	//サーバのMySQLに接続する設定
	//String USER = "nhs30435";
	//String PASWORD = "byyyymmdd";
	//String URL = "jdbc:mysql://192.168.121.16/nhs30435db";

	String DRIVER = "com.mysql.jdbc.Driver";

	//確認メッセージ
	StringBuffer ERMSG = null;

	int upd_count = 0;

	// HashMap（１件分のデータを格納する仮想配列）
	HashMap<String, String> map = null;

	try { //ロードに失敗したときのための例外処理
			//JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();

		//Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASSWORD);

		//Statementオブジェクトの作成
		stmt = con.createStatement();

		//SQLステートメントの作成(選択クエリ)
		SQL = new StringBuffer();

		//SQL文の発行(選択クエリ)
		SQL.append("update cus_tbl set cus_id = '");
		SQL.append(cus_idStr);
		SQL.append("', cus_pas = '");
		SQL.append(cus_pasStr);
		SQL.append("', cus_name = '");
		SQL.append(cus_nameStr);
		SQL.append("' where cus_no = ");
		SQL.append(cus_noStr);

		//SQL文の発行(選択クエリ)
		upd_count = stmt.executeUpdate(SQL.toString());

	} //tryブロック終了
	catch (ClassNotFoundException e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	} catch (SQLException e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	} catch (Exception e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
	}

	finally { //例外があってもなくても必ず実行する
				//各種オブジェクトクローズ（後片付け）
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
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>「顧客テーブルのレコードを更新するプログラム」</title>
</head>
<body BGCOLOR="#FFFFFF">

	<%
		if(upd_count == 0){ // 更新処理失敗
	%>
	更新NG
	<br>
	<%="更新処理が失敗しました"%>
	<%
		} else { // 更新OK
	%>
	更新OK
	<br>
	<%=upd_count + "件　更新が完了しました"%>
	<%
		}
	%>
	<br>
	<br>
	<%
		if (ERMSG != null) {
	%>
	予期せぬエラーが発生しました
	<br />
	<%=ERMSG%>
	<%
		} else {
	%>
	※エラーは発生しませんでした
	<br />
	<%
		}
	%>
</body>
</html>