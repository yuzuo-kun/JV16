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

	String insyou_name = request.getParameter("syou_name");
	String insyou_msg = request.getParameter("syou_msg");
	String insyou_pre = request.getParameter("pre_no");
	String insyou_icon = request.getParameter("syou_icon");

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

	String inpre_name = "沖縄";

	try { //ロードに失敗したときのための例外処理
			//JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();

		//Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASSWORD);

		//Statementオブジェクトの作成
		stmt = con.createStatement();

		// 変更後県名の取得
		SQL = new StringBuffer();

		//SQL文の発行(選択クエリ)
		SQL.append("select pre_name from ken_tbl where pre_no = " + insyou_pre);

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		if (rs.next()) {
			inpre_name = rs.getString("pre_name");
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
<title>商品変更(確認)</title>
<style>
th {
	width: 200px;
	text-align: left;
}

.center {
	text-align: center;
}

button {
	width: 100px;
}
</style>
</head>
<body>
	商品登録(確認)
	<br>
	<br> 以下の商品を追加します
	<br>
	<br>
	<table>
		<tr>
			<th>商品名</th>
			<th><%=insyou_name%></th>
		</tr>
		<tr>
			<th>生産地</th>
			<th><%=inpre_name%></th>
		</tr>
		<tr>
			<th>コメント</th>
			<th><%=insyou_msg%></th>
		</tr>
		<tr>
			<th>画像</th>
			<th><img src="./image/<%=insyou_icon%>.png" height="70px"
				width="70px" alt="<%=insyou_name%>の画像"></th>
		</tr>
	</table>
	<div style="display: flex; justify-content: center; width: 400px;">
		<form method="post" action="/JV16/syouhin_insertout.jsp">
			<input type="hidden" name="syou_name" value="<%=insyou_name%>">
			<input type="hidden" name="syou_msg" value="<%=insyou_msg%>">
			<input type="hidden" name="syou_pre" value="<%=insyou_pre%>">
			<input type="hidden" name="syou_icon" value="<%=insyou_icon%>">
			<button type="submit">登録</button>
		</form>
		<form method="post" action="/JV16/syouhin_insertin.jsp">
			<input type="hidden" name="syou_name" value="<%=insyou_name%>">
			<input type="hidden" name="syou_msg" value="<%=insyou_msg%>">
			<input type="hidden" name="syou_pre" value="<%=insyou_pre%>">
			<input type="hidden" name="syou_icon" value="<%=insyou_icon%>">
			<button type="submit">入力に戻る</button>
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