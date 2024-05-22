
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
	String session_name = (String)session.getAttribute("login_name");
	if(session_name == null) {
		response.sendRedirect("syouhin_index.jsp");
	}

	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String syou_no = request.getParameter("syou_no");

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
	HashMap<String, String> syouMap = null;
	// ArrayList（全ての件数を格納する配列）
	ArrayList<HashMap> syouList = null;
	syouList = new ArrayList<HashMap>();

	try {
		//JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();

		//Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASSWORD);

		//Statementオブジェクトの作成
		stmt = con.createStatement();

		//SQLステートメントの作成(選択クエリ)
		SQL = new StringBuffer();

		//SQL文の発行(選択クエリ)
		SQL.append("select syou_name, pre_name, syou_msg, syou_icon from syou_tbl, ken_tbl where syou_pre = pre_no and syou_no = '" + syou_no + "'");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		if (rs.next()) {
			syouMap = new HashMap<String, String>();
			syouMap.put("syou_name", rs.getString("syou_name"));
			syouMap.put("pre_name", rs.getString("pre_name"));
			syouMap.put("syou_msg", rs.getString("syou_msg"));
			syouMap.put("syou_icon", rs.getString("syou_icon"));
			// １件分のデータ（HashMap）をArrayListに格納
			syouList.add(syouMap);
		}

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

<title>商品削除(確認)</title>

<style>


button {
	width: 100px
}

th {
	width: 200px;
	text-align: left;
}
</style>

</head>

<body>

	<br>
	商品削除（確認）
	<br><br>
	以下の商品を削除します。

	<br>
	<br>
	<table class="bot">
		<tr>
			<th>商品名</th>
			<th><%=syouList.get(0).get("syou_name")%></th>
		</tr>
		<tr>
			<th>生産地</th>
			<th><%=syouList.get(0).get("pre_name")%></th>
		</tr>
		<tr>
			<th>コメント</th>
			<th><%=syouList.get(0).get("syou_msg")%></th>
		</tr>
		<tr>
			<th>画像</th>
			<td><img src="./image/<%=syouList.get(0).get("syou_icon")%>.png" height="70px"
				width="70px" alt="<%=syouList.get(0).get("syou_name")%>の画像"></td>
		</tr>
	</table>
	<div style="display: flex; justify-content: space-around; width: 400px;">
		<form method="post" action="/JV16/syouhin_delete.jsp">
			<input type="hidden" name="syou_no" value="<%= syou_no %>">
			<button type="submit">削除</button>
		</form>
		<form method="post" action="/JV16/syouhin_main.jsp">
			<button type="submit">商品一覧</button>
		</form>
		<form method="post" action="syouhin_index.jsp">
			<input type="hidden" name="logout" value="loglout">
			<button type="submit">ログアウト</button>
		</form>
	</div>

</body>


</html>