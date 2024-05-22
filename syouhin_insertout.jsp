<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	String session_name = (String)session.getAttribute("login_name");
	if(session_name == null) {
		response.sendRedirect("syouhin_index.jsp");
	}

	// 文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String syou_name = request.getParameter("syou_name");
	String pre_no = request.getParameter("syou_pre");
	String syou_msg = request.getParameter("syou_msg");
	String syou_icon = request.getParameter("syou_icon");

	// データベースに接続するために使用する変数宣言
	Connection con = null;
	Statement stmt = null;
	StringBuffer SQL = null;
	ResultSet rs = null;

	// ローカルのMySQLに接続する設定
	String USER = "root";
	String PASSWORD = "root";
	String URL = "jdbc:mysql://localhost/nhs30061db";

	// サーバのMySQLに接続する設定
	// String USER = "nhs30435";
	// String PASSWORD = "byyyymmdd";
	// String URL = "jdbc:mysql://192.168.121.16/nhs30435db";
	String DRIVER = "com.mysql.jdbc.Driver";

	// 確認メッセージ
	StringBuffer ERMSG = null;

	int ins_cnt = 0;

	// HashMap（１件分のデータを格納する仮想配列）
	HashMap<String, String> map = null;
	// ArrayList（全ての件数を格納する配列）
	ArrayList<HashMap> list = null;

	try {
		// JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();

		// Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASSWORD);

		// Statementオブジェクトの作成
		stmt = con.createStatement();

		// SQLステートメントの作成(選択クエリ)
		SQL = new StringBuffer();

		// SQL文の発行(選択クエリ)
		SQL.append("insert into syou_tbl(syou_name, syou_pre, syou_msg, syou_icon) values('");
		SQL.append(syou_name);
		SQL.append("', ");
		SQL.append(pre_no);
		SQL.append(", '");
		SQL.append(syou_msg);
		SQL.append("', ");
		SQL.append(syou_icon);
		SQL.append(")");

		// SQL文の発行(選択クエリ)
		ins_cnt = stmt.executeUpdate(SQL.toString());

		// 抽出したデータを繰り返し処理で表示する

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
		// 例外があってもなくても必ず実行する
		// 各種オブジェクトクローズ（後片付け）
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

	// エラーがあればエラーメッセージを表示
	if (ERMSG != null) {
%>
<p>
	データベース接続エラー:
	<%=ERMSG.toString()%></p>
<%
	}
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>商品登録</title>

</head>
<body>
	<%
		if (ins_cnt == 0) { // 追加処理失敗
	%>
	追加NG
	<br>
	<%="登録処理が失敗しました"%>
	<%
		} else { // 追加OK
	%>
	追加OK
	<br>
	<%=ins_cnt + "件 登録完了しました"%>
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