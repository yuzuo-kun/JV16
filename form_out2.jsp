<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String searchWord = request.getParameter("w");
	if(searchWord == null) {
		searchWord = "";
	}
	
	String isDel = request.getParameter("btn");

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
	
	// 合計値を格納する変数
	int cnt_design = 0;
	int cnt_color = 0;
	int cnt_price = 0;
	int cnt_desc = 0;
	int cnt_security = 0;
	int cnt_maker = 0;

	try { //ロードに失敗したときのための例外処理
			//JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();

		//Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASSWORD);

		//Statementオブジェクトの作成
		stmt = con.createStatement();

		//SQLステートメントの作成(選択クエリ)
		SQL = new StringBuffer();
		
		if(isDel != null) {
			String formID = request.getParameter("formID");
			//SQL文の発行(選択クエリ)
			SQL.append("delete from form_tbl where id = ");
			SQL.append(formID);
			stmt.executeUpdate(SQL.toString());
			SQL = new StringBuffer();
		}
		
		//SQL文の発行(選択クエリ)
		SQL.append("select f.id, f.name, c.name, s.name, f.q_design, f.q_color, f.q_price, f.q_desc, f.q_security, f.q_maker, f.msg from form_tbl f, color_tbl c, size_tbl s where f.color_id = c.id and f.size_id = s.id and f.name like '%");
		SQL.append(searchWord);
		SQL.append("%'");

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		while (rs.next()) {
			map = new HashMap<String, String>();
			map.put("id", rs.getString("f.id"));
			map.put("name", rs.getString("f.name"));
			map.put("color", rs.getString("c.name"));
			map.put("size", rs.getString("s.name"));
			map.put("q_design", rs.getString("f.q_design").equals("1") ? "〇" : "");
			map.put("q_color", rs.getString("f.q_color").equals("1") ? "〇" : "");
			map.put("q_price", rs.getString("f.q_price").equals("1") ? "〇" : "");
			map.put("q_desc", rs.getString("f.q_desc").equals("1") ? "〇" : "");
			map.put("q_security", rs.getString("f.q_security").equals("1") ? "〇" : "");
			map.put("q_maker", rs.getString("f.q_maker").equals("1") ? "〇" : "");
			map.put("msg", rs.getString("f.msg"));
			
			// 合計用のカウント処理
			if(rs.getString("f.q_design").equals("1")) {
				cnt_design++;
			}
			if(rs.getString("f.q_color").equals("1")) {
				cnt_color++;
			}
			if(rs.getString("f.q_price").equals("1")) {
				cnt_price++;
			}
			if(rs.getString("f.q_desc").equals("1")) {
				cnt_desc++;
			}
			if(rs.getString("f.q_security").equals("1")) {
				cnt_security++;
			}
			if(rs.getString("f.q_maker").equals("1")) {
				cnt_maker++;
			}
			
			// １件分のデータ（HashMap）をArrayListに格納
			list.add(map);
		}
	} //tryブロック終了
	catch (ClassNotFoundException e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
		System.out.println(ERMSG);
	} catch (SQLException e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
		System.out.println(ERMSG);
	} catch (Exception e) {
		ERMSG = new StringBuffer();
		ERMSG.append(e.getMessage());
		System.out.println(ERMSG);
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
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>アンケート一覧</title>
    <style>
    	body {
		    width: fit-content;
		    margin: 0 auto;
		    text-align: center;
    	}
    	footer {
    		margin-top: 30px;
    	}
    	table {
    		margin-bottom: 20px;
    	}
    	table, th, td {
    		border: solid 1px #555;
    	}
    	th {
    		background-color: pink;
    	}
    	th, td {
    		width: 80px;
    		height: 40px;
    		text-align: center;
    	}
    	.desc {
		    white-space: nowrap;
		    max-width: 80px;
		    overflow-x: scroll;
    	}
    	.btn {
    	    appearance: auto;
		    user-select: none;
		    align-items: flex-start;
		    text-align: center;
		    cursor: default;
		    box-sizing: border-box;
		    color: buttontext;
		    white-space: pre;
		    padding-inline: 6px;
		    border-width: 1px;
		    border-style: outset;
		    border-radius: 3px;
		    border-color: buttonborder;
		    border-image: initial;
		    text-decoration: none;
    		background-color: #aaa;
    	}
    	.btn:hover {
    		background-color: #888;
    	}
    </style>
</head>
<body>
    <h1>[アンケート一覧]</h1>
    <br>
    <form action="form_out2.jsp" method="get">
    	<input class="search" type="text" name="w" placeholder="商品名で検索" value="<%=searchWord %>">
    </form>
    <table>
    	<tr>
    		<th>商品名</th>
    		<th>色</th>
    		<th>サイズ</th>
    		<th>デザイン</th>
    		<th>色</th>
    		<th>価格</th>
    		<th>説明</th>
    		<th>保障</th>
    		<th>メーカー</th>
    		<th>ご意見</th>
    		<th>編集</th>
    		<th>削除</th>
    	</tr>
    	
    	<%
    		for(int i = 0; i < list.size(); i++) {
    	%>

		    	<tr>
		    		<td><%=list.get(i).get("name") %></td>
		    		<td><%=list.get(i).get("color") %></td>
		    		<td><%=list.get(i).get("size") %></td>
		    		<td><%=list.get(i).get("q_design") %></td>
		    		<td><%=list.get(i).get("q_color") %></td>
		    		<td><%=list.get(i).get("q_price") %></td>
		    		<td><%=list.get(i).get("q_desc") %></td>
		    		<td><%=list.get(i).get("q_security") %></td>
		    		<td><%=list.get(i).get("q_maker") %></td>
		    		<td class="desc"><%=list.get(i).get("msg") %></td>
		    		<td>
						<form action="form_in2.jsp" method="post">
							<input type="hidden" name="formID" value="<%=list.get(i).get("id")%>">
							<input class="btn" type="submit" value="編集">
						</form>
		    		</td>
		    		<td>
						<form action="form_out2.jsp" method="post">
							<input type="hidden" name="formID" value="<%=list.get(i).get("id")%>">
							<input class="btn" type="submit" name="btn" value="削除">
						</form>
		    		</td>
		    	</tr>
		    	
		<%
    		}
		%>
    	
    	<tr>
    		<td colspan="3">合計</td>
    		<td><%=cnt_design %></td>
    		<td><%=cnt_color %></td>
    		<td><%=cnt_price %></td>
    		<td><%=cnt_desc %></td>
    		<td><%=cnt_security %></td>
    		<td><%=cnt_maker %></td>
    	</tr>
    </table>
	<a href="form_menu.jsp">メニューへ戻る</a>
	<footer>
		Copyright©2024 HAL Nagoya the Department of WEB System Development, All right reserved.
	</footer>
</body>
</html>