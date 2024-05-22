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

	String syou_no = request.getParameter("syou_no");
	String upsyou_name = request.getParameter("syou_name");
	String upsyou_msg = request.getParameter("syou_msg");
	String upsyou_pre = request.getParameter("pre_no");
	String upsyou_icon = request.getParameter("syou_icon");

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

	String uppre_name = "沖縄";

	boolean updateNameFlag = false;
	boolean updatePreFlag = false;
	boolean updateMsgFlag = false;
	boolean updateIconFlag = false;

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

		// 変更後県名の取得
		SQL = new StringBuffer();

		//SQL文の発行(選択クエリ)
		SQL.append("select pre_name from ken_tbl where pre_no = " + upsyou_pre);

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		if (rs.next()) {
			uppre_name = rs.getString("pre_name");
		}

		if(!upsyou_name.equals(syouList.get(0).get("syou_name"))) {
			updateNameFlag = true;
		}
		if(!upsyou_msg.equals(syouList.get(0).get("syou_msg"))) {
			updateMsgFlag = true;
		}
		if(!uppre_name.equals(syouList.get(0).get("pre_name"))) {
			updatePreFlag = true;
		}
		if(!upsyou_icon.equals(syouList.get(0).get("syou_icon"))) {
			updateIconFlag = true;
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
	td{
		width: 100px;
	}
	th{
		text-align: left;
	}
	.center{
		text-align: center;
	}
	button{
		width: 100px;
	}
</style>
</head>
<body>
	商品変更(確認)
	<br>
	<br>
	以下の商品を変更します
	<br>
	<br>
	<table>
		<tr>
			<th></th>
			<th>変更前</th>
			<th></th>
			<th>変更後</th>
		</tr>
		<% if(updateNameFlag) { %>
		<tr>
			<th>商品名</th>
			<th><%= syouList.get(0).get("syou_name") %></th>
			<th class="center"> →</th>
			<th><%= upsyou_name %></th>
		</tr>
		<% } %>
		<% if(updatePreFlag) { %>
		<tr>
			<th>生産地</th>
			<th><%= syouList.get(0).get("pre_name") %></th>
			<th class="center"> →</th>
			<th><%= uppre_name %></th>
		</tr>
		<% } %>
		<% if(updateMsgFlag) { %>
		<tr>
			<th>コメント</th>
			<th><%= syouList.get(0).get("syou_msg") %></th>
			<th class="center"> →</th>
			<th><%= upsyou_msg %></th>
		</tr>
		<% } %>
		<% if(updateIconFlag) { %>
		<tr>
			<th>画像</th>
			<td align="center"><img src="./image/<%= syouList.get(0).get("syou_icon") %>.png" height="70px" width="70px" alt="<%=syouList.get(0).get("syou_name")%>の画像"></td>
			<th class="center"> →</th>
			<td align="center"><img src="./image/<%= upsyou_icon %>.png" height="70px" width="70px" alt="<%= upsyou_name %>の画像"></td>
		</tr>
		<% } %>
		<tr>
			<td></td>
			<td>
				<form method="post" action="/JV16/syouhin_updateout.jsp">
					<input type="hidden" name="syou_no" value="<%= syou_no %>">
					<input type="hidden" name="syou_name" value="<%= upsyou_name %>">
					<input type="hidden" name="syou_msg" value="<%= upsyou_msg %>">
					<input type="hidden" name="syou_pre" value="<%= upsyou_pre %>">
					<input type="hidden" name="syou_icon" value="<%= upsyou_icon %>">
					<button type="submit">更新</button>
				</form>
			</td>
			<td></td>
			<td>
				<form method="post" action="/JV16/syouhin_main.jsp">
					<button type="submit">商品一覧</button>
				</form>
			</td>
		</tr>
	</table>
	<br>
	<br>
	<form method="post" action="syouhin_index.jsp">
		<input type="hidden" name="logout" value="loglout">
		<button type="submit">ログアウト</button>
	</form>
	
</body>
</html>