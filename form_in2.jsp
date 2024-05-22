<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String formID = request.getParameter("formID");

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
		SQL.append("select f.id, f.name, f.color_id, f.size_id, f.q_design, f.q_color, f.q_price, f.q_desc, f.q_security, f.q_maker, f.msg from form_tbl f where f.id = ");
		SQL.append(formID);

		//SQL文の発行(選択クエリ)
		rs = stmt.executeQuery(SQL.toString());

		//抽出したデータを繰り返し処理で表示する
		if (rs.next()) {
			map = new HashMap<String, String>();
			map.put("id", rs.getString("f.id"));
			map.put("name", rs.getString("f.name"));
			map.put("color", rs.getString("f.color_id"));
			map.put("size", rs.getString("f.size_id"));
			map.put("q_design", rs.getString("f.q_design").equals("1") ? "checked" : "");
			map.put("q_color", rs.getString("f.q_color").equals("1") ? "checked" : "");
			map.put("q_price", rs.getString("f.q_price").equals("1") ? "checked" : "");
			map.put("q_desc", rs.getString("f.q_desc").equals("1") ? "checked" : "");
			map.put("q_security", rs.getString("f.q_security").equals("1") ? "checked" : "");
			map.put("q_maker", rs.getString("f.q_maker").equals("1") ? "checked" : "");
			map.put("msg", rs.getString("f.msg").equals("意見無し") ? "" : rs.getString("f.msg"));
			map.put("color1", "");
			map.put("color2", "");
			map.put("color3", "");
			map.put("size1", "");
			map.put("size2", "");
			map.put("size3", "");
			map.put("size4", "");
			if(rs.getString("f.color_id").equals("1")) {
				map.put("color1", "checked");
			}
			if(rs.getString("f.color_id").equals("2")) {
				map.put("color2", "checked");
			}
			if(rs.getString("f.color_id").equals("3")) {
				map.put("color3", "checked");
			}
			if(rs.getString("f.size_id").equals("1")) {
				map.put("size1", "checked");
			}
			if(rs.getString("f.size_id").equals("2")) {
				map.put("size2", "checked");
			}
			if(rs.getString("f.size_id").equals("3")) {
				map.put("size3", "checked");
			}
			if(rs.getString("f.size_id").equals("4")) {
				map.put("size4", "checked");
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
    <title>アンケート編集フォーム</title>
    <style>
    	body {
		    width: fit-content;
		    margin: 0 auto;
		    text-align: center;
    	}
    	div {
    		margin-bottom: 20px;
    	}
    	footer {
    		margin-top: 30px;
    	}
    	textarea {
    	    resize: none;
		    width: 300px;
		    height: 70px;
    	}
    	p {
    		margin: 0;
    	}
    	.btn-box {
		    display: flex;
		    justify-content: center;
    	}
    	.btn-box * {
    		margin: 0 10px;
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
    <h1>[アンケート編集]</h1>
    <br>
    <form action="form_out1.jsp" method="post">
		<div>
			<label for="syou_name">商品名:</label>
			<input id="syou_name" name="syou_name" type="text" required value="<%=list.get(0).get("name") %>">
		</div>
		<div>
			<span>色:</span>
			<input id="syou_red" name="syou_color" type="radio" value="1" <%=list.get(0).get("color1") %>>
			<label for="syou_red">赤
			<input id="syou_green" name="syou_color" type="radio" value="2" <%=list.get(0).get("color2") %>>
			<label for="syou_green">緑
			<input id="syou_yellow" name="syou_color" type="radio" value="3" <%=list.get(0).get("color3") %>>
			<label for="syou_yellow">黄
		</div>
		<div>
			<label for="syou_size">サイズ:</label>
			<select id="syou_size" name="syou_size">
				<option value="1" <%=list.get(0).get("size1") %>>S</option>
				<option value="2" <%=list.get(0).get("size2") %>>M</option>
				<option value="3" <%=list.get(0).get("size3") %>>L</option>
				<option value="4" <%=list.get(0).get("size4") %>>LL</option>
			</select>
		</div>
		<div>
			<p>アンケート（何が気に入りましたか）　複数回答可:</p>
			<input id="q_design" name="syou_question" type="checkbox" value="デザイン" <%=list.get(0).get("q_design") %>>
			<label for="q_design">デザイン
			<input id="q_color" name="syou_question" type="checkbox" value="色" <%=list.get(0).get("q_color") %>>
			<label for="q_color">色
			<input id="q_price" name="syou_question" type="checkbox" value="価格" <%=list.get(0).get("q_price") %>>
			<label for="q_price">価格
			<input id="q_desc" name="syou_question" type="checkbox" value="説明" <%=list.get(0).get("q_desc") %>>
			<label for="q_desc">説明
			<input id="q_security" name="syou_question" type="checkbox" value="保障" <%=list.get(0).get("q_security") %>>
			<label for="q_security">保障
			<input id="q_maker" name="syou_question" type="checkbox" value="メーカー" <%=list.get(0).get("q_maker") %>>
			<label for="q_maker">メーカー
		</div>
		<div>
			<label for="syou_msg">ご意見:</label>
			<textarea id="syou_msg" name="syou_msg"><%=list.get(0).get("msg") %></textarea>
		</div>
		<div class="btn-box">
			<input class="btn" type="submit" value="データ送信">
		</div>
		<input type="hidden" name="formID" value="<%=list.get(0).get("id") %>">
	</form>
	<a href="form_menu.jsp">メニューへ戻る</a>
	<footer>
		Copyright©2024 HAL Nagoya the Department of WEB System Development, All right reserved.
	</footer>
</body>
</html>