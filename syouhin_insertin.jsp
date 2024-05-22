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

	String syou_name = request.getParameter("syou_name");
	if (syou_name == null) {
		syou_name = "";
	}
	String syou_msg = request.getParameter("syou_msg");
	if (syou_msg == null) {
		syou_msg = "";
	}
	String syou_pre = request.getParameter("syou_pre");
	if (syou_pre == null) {
		syou_pre = "1";
	}
	String syou_icon = request.getParameter("syou_icon");
	if (syou_icon == null) {
		syou_icon = "1";
	}

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
		SQL.append("select * from ken_tbl order by pre_no");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		while (rs.next()) {
			map = new HashMap<String, String>();
			map.put("pre_no", rs.getString("pre_no"));
			map.put("pre_name", rs.getString("pre_name"));
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
<title>商品登録</title>
</head>
<body>
	<h1>商品登録</h1>
	<form name="frm" method="post" action="/JV16/syouhin_insertcon.jsp">
		<table border="1">
			<tr>
				<th bgcolor="#99cc00">項目名</th>
				<th bgcolor="#99cc00">内容</th>
			</tr>
			<tr>
				<td bgcolor="#99cc00">商品名</td>
				<td><input type="text" name="syou_name" size="40"
					maxlength="20" value="<%=syou_name%>" required></td>
			</tr>
			<tr>
				<td bgcolor="#99cc00">生産地</td>
				<td><select size="1" name="pre_no">
						<%
							// ArrayListからデータを取り出す
							for (int i = 0; i < list.size(); i++) {
						%>
						<option value="<%=list.get(i).get("pre_no")%>"><%=list.get(i).get("pre_name")%></option>
						<%
							}
						%>
				</select> <script>
					document.frm.pre_no.selectedIndex =
				<%=syou_pre%>
					- 1;
				</script></td>
			</tr>
			<tr>
				<td bgcolor="#99cc00">コメント</td>
				<td><textarea name="syou_msg" rows="3" cols="43" required><%=syou_msg%></textarea>
				</td>
			</tr>
			<tr>
				<td bgcolor="#99cc00">アイコン</td>
				<td><select name="syou_icon">
						<option value="1">いちご</option>
						<option value="2">りんご</option>
						<option value="3">さくらんぼ</option>
						<option value="4">すいか</option>
						<option value="5">パイナップル</option>
						<option value="6">メロン</option>
						<option value="7">バナナ</option>
				</select> <script>
					document.frm.syou_icon.selectedIndex =
				<%=syou_icon%>
					- 1;
				</script></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">登録</button>
				</td>
			</tr>
		</table>
	</form>
	<br>
	<div style="display:flex">
		<form metho="post" action="/JV16/syouhin_main.jsp">
			<input type="submit" value="商品一覧に戻る">
		</form>
		<form method="post" action="syouhin_index.jsp">
			<input type="hidden" name="logout" value="loglout">
			<button type="submit">ログアウト</button>
		</form>
	</div>
</body>
</html>