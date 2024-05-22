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
	HashMap<String, String> preMap = null;
	HashMap<String, String> syouMap = null;
	// ArrayList（全ての件数を格納する配列）
	ArrayList<HashMap> preList = null;
	preList = new ArrayList<HashMap>();
	ArrayList<HashMap> syouList = null;
	syouList = new ArrayList<HashMap>();

	try { //ロードに失敗したときのための例外処理
			//JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();

		//Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASSWORD);

		//Statementオブジェクトの作成
		stmt = con.createStatement();

		SQL = new StringBuffer();

		//SQL文の発行(選択クエリ)
		SQL.append("select * from ken_tbl order by pre_no");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		while (rs.next()) {
			preMap = new HashMap<String, String>();
			preMap.put("pre_no", rs.getString("pre_no"));
			preMap.put("pre_name", rs.getString("pre_name"));
			// １件分のデータ（HashMap）をArrayListに格納
			preList.add(preMap);
		}

		//SQLステートメントの作成(選択クエリ)
		SQL = new StringBuffer();

		//SQL文の発行(選択クエリ)
		SQL.append("select syou_name, syou_pre, syou_msg, syou_icon from syou_tbl where syou_no = '" + syou_no + "'");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		if (rs.next()) {
			syouMap = new HashMap<String, String>();
			syouMap.put("syou_name", rs.getString("syou_name"));
			syouMap.put("syou_pre", rs.getString("syou_pre"));
			syouMap.put("syou_msg", rs.getString("syou_msg"));
			syouMap.put("syou_icon", rs.getString("syou_icon"));
			// １件分のデータ（HashMap）をArrayListに格納
			syouList.add(syouMap);
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
<title>商品変更</title>
<style>
	.button {
		appearance: auto;
		text-decoration: none;
	    font-size: 13.5px;
	    border-radius: 2.2px;
	    text-rendering: auto;
	    color: buttontext;
	    letter-spacing: normal;
	    word-spacing: normal;
	    line-height: normal;
	    text-transform: none;
	    text-indent: 0px;
	    text-shadow: none;
	    display: inline-block;
	    text-align: center;
	    align-items: flex-start;
	    cursor: default;
	    box-sizing: border-box;
	    background-color: buttonface;
	    margin: 0em;
	    padding-block: 2.2px;
	    padding-inline: 5px;
	    border-width: 1px;
	    border-style: outset;
	    border-color: buttonborder;
	    border-image: initial;
	}
</style>
</head>
<body>
	<h1>商品変更</h1>
	<form name="frm" method="post" action="/JV16/syouhin_updatecon.jsp">
		<table border="1">
			<tr>
				<th bgcolor="#99cc00">項目名</th>
				<th bgcolor="#99cc00">内容</th>
			</tr>
			<tr>
				<td bgcolor="#99cc00">商品No</td>
				<td>
					<%= syou_no %>
					<input type="hidden" name="syou_no" value="<%= syou_no %>">
				</td>
			</tr>
			<tr>
				<td bgcolor="#99cc00">商品名</td>
				<td>
					<input type="text" name="syou_name" size="40" maxlength="20" value="<%= syouList.get(0).get("syou_name") %>">
				</td>
			</tr>
			<tr>
				<td bgcolor="#99cc00">生産地</td>
				<td>
					<select size="1" name="pre_no">
						<%
							// ArrayListからデータを取り出す
							for (int i = 0; i < preList.size(); i++) {
						%>
						<option value="<%=preList.get(i).get("pre_no")%>"><%= preList.get(i).get("pre_name") %></option>
						<%
							}
						%>
					</select>
					<script>
						document.frm.pre_no.selectedIndex = <%= syouList.get(0).get("syou_pre") %> - 1;
					</script>
				</td>
			</tr>
			<tr>
				<td bgcolor="#99cc00">コメント</td>
				<td>
					<textarea name="syou_msg" rows="3" cols="43"><%= syouList.get(0).get("syou_msg") %></textarea>
				</td>
			</tr>
			<tr>
				<td bgcolor="#99cc00">アイコン</td>
				<td>
					<select  name="syou_icon">
						<option value="1">いちご</option>
						<option value="2">りんご</option>
						<option value="3">さくらんぼ</option>
						<option value="4">すいか</option>
						<option value="5">パイナップル</option>
						<option value="6">メロン</option>
						<option value="7">バナナ</option>
					</select>
					<script>
						document.frm.syou_icon.selectedIndex = <%= syouList.get(0).get("syou_icon") %> - 1;
					</script>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">商品変更</button>
					<a class="button" href="syouhin_updatein.jsp?syou_no=<%= syou_no %>">入力クリア</a>
				</td>
			</tr>
		</table>
	</form>
	<br>
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