<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String cus_noStr = request.getParameter("cus_no");

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

	int hit_flag = 0;

	// HashMap（１件分のデータを格納する仮想配列）
	HashMap<String, String> map = null;

	// ArrayList（全ての件数を格納する配列）
	ArrayList<HashMap> list = null;
	list = new ArrayList<HashMap>();

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
		SQL.append("select * from cus_tbl where cus_no = '");
		SQL.append(cus_noStr);
		SQL.append("'");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		if (rs.next()) { // 存在する
			// hitフラグON
			hit_flag = 1;

			// 検索データをHashMapへ格納する
			map = new HashMap<String, String>();
			map.put("cus_no", rs.getString("cus_no"));
			map.put("cus_id", rs.getString("cus_id"));
			map.put("cus_pas", rs.getString("cus_pas"));
			map.put("cus_name", rs.getString("cus_name"));
			// １件分のデータ（HashMap）をArrayListに格納
			list.add(map);
		} else { // 存在しない
			// hitフラグOFF
			hit_flag = 0;
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
<title>顧客変更</title>
</head>
<body BGCOLOR="#FFFFFF">
	customer_updateout.jsp
	<br>
	<br>
	顧客登録
	<br>
	<br>
	<form method="post" action="/JV16/customer_updateout2.jsp">
	<input type="hidden" name="cus_no" value="<%= list.get(0).get("cus_no") %>">
	<table border="1">
		<tr>
			<th>項目名</th><th>内容</th>
		</tr>
		<tr>
			<td>顧客ID</td>
			<td><input type="text" name="cus_id" size="40" maxlength="20" value="<%= list.get(0).get("cus_id") %>"></td>
		</tr>
		<tr>
			<td>パスワード</td>
			<td><input type="password" name="cus_pas" size="41" maxlength="20" value="<%= list.get(0).get("cus_pas") %>"></td>
		</tr>
		<tr>
			<td>氏名</td>
			<td><input type="text" name="cus_name" size="40" maxlength="20" value="<%= list.get(0).get("cus_name") %>"></td>
		</tr>

	</table>
		<br>
		<br>
		<hr>
		<button type="submit">変更</button>
		<button type="reset">入力クリア</button>
	</form>
</body>
</html>