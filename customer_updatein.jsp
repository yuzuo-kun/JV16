<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

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
		SQL.append("select * from cus_tbl");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		while (rs.next()) {
			map = new HashMap<String, String>();
			map.put("cus_no", rs.getString("cus_no"));
			map.put("cus_id", rs.getString("cus_id"));
			map.put("cus_pas", rs.getString("cus_pas"));
			map.put("cus_name", rs.getString("cus_name"));
			// １件分のデータ（HashMap）をArrayListに格納
			list.add(map);
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>「顧客テーブルの内容を読み込みそのまま表示するプログラム」</title>
</head>
<body>
	<form method="post" action="/JV16/customer_updateout.jsp">
		<table border="1">
			<tr>
				<th>更新</th>
				<th>顧客No.</th>
				<th>顧客ID</th>
				<th>パスワード</th>
				<th>氏名</th>
			</tr>
			<%
				// ArrayListからデータを取り出す
				for (int i = 0; i < list.size(); i++) {
			%>
			<tr>
				<td align="center" bgcolor="blue">
					<input type="radio" name="cus_no" value="<%= list.get(i).get("cus_no") %>">
				</td>
				<td><%=list.get(i).get("cus_no")%></td>
				<td><%=list.get(i).get("cus_id")%></td>
				<td><%=list.get(i).get("cus_pas")%></td>
				<td><%=list.get(i).get("cus_name")%></td>
			</tr>
			<%
				}
			%>
		</table>
		<input type="submit" value="更新">
	</form>
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