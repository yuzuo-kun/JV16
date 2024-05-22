<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

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

	// hitフラグ
	int hit_flag = 0;

	// 追加件数
	int ins_count = 0;

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
		SQL.append("select * from cus_tbl where cus_id = '");
		SQL.append(cus_idStr);
		SQL.append("'");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		if (rs.next()) { // 存在する（追加NG）
			// hitフラグON
			hit_flag = 1;
		} else { // 存在しない
			// hitフラグOFF
			hit_flag = 0;

			SQL = new StringBuffer();


			//SQL文の発行(選択クエリ)
			SQL.append("insert into cus_tbl(cus_id, cus_pas, cus_name)");
			SQL.append(" values('");
			SQL.append(cus_idStr);
			SQL.append("', '");
			SQL.append(cus_pasStr);
			SQL.append("', '");
			SQL.append(cus_nameStr);
			SQL.append("')");

			//SQL文の発行(選択クエリ)
			ins_count = stmt.executeUpdate(SQL.toString());
		}

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
<title>「顧客テーブルにレコードを追加するプログラム」</title>
</head>
<body>

	<%
		// ArrayListからデータを取り出す
		if (hit_flag == 1) { // 追加NG
	%>
	追加NG
	<br>
	<%= "入力された顧客IDは既に存在しています" %>
	<%
		} else if(ins_count == 0){ // 追加処理失敗
	%>
	追加NG
	<br>
	<%="追加処理が失敗しました"%>
	<%
		} else { // 認証OK
	%>
	追加OK
	<br>
	<%=ins_count + "件　登録が完了しました"%>
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