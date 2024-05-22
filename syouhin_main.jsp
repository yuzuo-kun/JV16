<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	String session_name = (String)session.getAttribute("login_name");
	if(session_name == null) {
		response.sendRedirect("syouhin_index.jsp");
	}
	
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
		SQL.append("select syou_no, syou_name, syou_pre, syou_msg, syou_icon, pre_name from syou_tbl, ken_tbl where syou_pre = pre_no order by syou_no");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		while (rs.next()) {
			map = new HashMap<String, String>();
			map.put("syou_no", rs.getString("syou_no"));
			map.put("syou_name", rs.getString("syou_name"));
			map.put("pre_name", rs.getString("pre_name"));
			map.put("syou_msg", rs.getString("syou_msg"));
			map.put("syou_icon", rs.getString("syou_icon"));
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
<title>商品管理　全件検索</title>
</head>
	<%
		if (ERMSG != null) {
	%>
	予期せぬエラーが発生しました
	<br />
	<%=ERMSG%>
	<%
		}
	%>
<body>
	<h2>ようこそ<%=session_name%>さん</h2>
	<br>
	<h1>商品一覧</h1>
	<table border="1">
		<%
			// ArrayListからデータを取り出す
			for (int i = 0; i < list.size(); i++) {
		%>
		<tr>
			<td rowspan="4">
				<img src="./image/<%=list.get(i).get("syou_icon")%>.png" height="70px" width="70px" alt="<%=list.get(i).get("syou_name")%>の画像">
			</td>
			<td>商品No</td>
			<td width="300"><%=list.get(i).get("syou_no")%></td>
		</tr>
		<tr>
			<td>商品名</td>
			<td width="300"><%=list.get(i).get("syou_name")%></td>
		</tr>
		<tr>
			<td>生産地</td>
			<td width="300"><%=list.get(i).get("pre_name")%></td>
		</tr>
		<tr>
			<td>コメント</td>
			<td width="300"><%=list.get(i).get("syou_msg")%></td>
		</tr>
		<tr>
			<td>
				<a href="syouhin_updatein.jsp?syou_no=<%=list.get(i).get("syou_no") %>">[編集]</a>
				<a href="syouhin_deletecon.jsp?syou_no=<%=list.get(i).get("syou_no") %>">[削除]</a>
			</td>
		</tr>
		<%
			}
		%>
	</table>
	<br>
	<div style="display:flex">
		<form method="post" action="/JV16/syouhin_insertin.jsp">
			<input type="submit" value="商品登録">
		</form>
		<form method="post" action="syouhin_index.jsp">
			<input type="hidden" name="logout" value="loglout">
			<button type="submit">ログアウト</button>
		</form>
	</div>
</body>
</html>