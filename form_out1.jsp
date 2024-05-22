<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String formID = request.getParameter("formID");
	
	String name = request.getParameter("syou_name");
	String color = request.getParameter("syou_color");
	String size = request.getParameter("syou_size");
	String[] question = request.getParameterValues("syou_question");
	String q_design = "0";
	String q_color = "0";
	String q_price = "0";
	String q_desc = "0";
	String q_security = "0";
	String q_maker = "0";
	if(question != null) {
		for(int i = 0; i < question.length; i++) {
			if(question[i].equals("デザイン")) {
				q_design = "1";
			}
			if(question[i].equals("色")) {
				q_color = "1";
			}
			if(question[i].equals("価格")) {
				q_price = "1";
			}
			if(question[i].equals("説明")) {
				q_desc = "1";
			}
			if(question[i].equals("保障")) {
				q_security = "1";
			}
			if(question[i].equals("メーカー")) {
				q_maker = "1";
			}
		}
	}
	String msg = request.getParameter("syou_msg");
	if(msg.equals("") || msg == null) {
		msg = "意見無し";
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
	
	try { //ロードに失敗したときのための例外処理
			//JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();
	
		//Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASSWORD);
	
		//Statementオブジェクトの作成
		stmt = con.createStatement();
	
		//SQLステートメントの作成(選択クエリ)
		SQL = new StringBuffer();
		
		if(formID != null) {
			
			SQL.append("update form_tbl set name = '");
			SQL.append(name);
			SQL.append("', color_id = '");
			SQL.append(color);
			SQL.append("', size_id = '");
			SQL.append(size);
			SQL.append("', q_design = '");
			SQL.append(q_design);
			SQL.append("', q_color = '");
			SQL.append(q_color);
			SQL.append("', q_price = '");
			SQL.append(q_price);
			SQL.append("', q_desc = '");
			SQL.append(q_desc);
			SQL.append("', q_security = '");
			SQL.append(q_security);
			SQL.append("', q_maker = '");
			SQL.append(q_maker);
			SQL.append("', msg = '");
			SQL.append(msg);
			SQL.append("' where id = ");
			SQL.append(formID);
			
		} else {
	
			//SQL文の発行(選択クエリ)
			SQL.append("insert into form_tbl(name, color_id, size_id, q_design, q_color, q_price, q_desc, q_security, q_maker, msg) values('");
			SQL.append(name);
			SQL.append("', '");
			SQL.append(color);
			SQL.append("', '");
			SQL.append(size);
			SQL.append("', '");
			SQL.append(q_design);
			SQL.append("', '");
			SQL.append(q_color);
			SQL.append("', '");
			SQL.append(q_price);
			SQL.append("', '");
			SQL.append(q_desc);
			SQL.append("', '");
			SQL.append(q_security);
			SQL.append("', '");
			SQL.append(q_maker);
			SQL.append("', '");
			SQL.append(msg);
			SQL.append("')");
		}
	
		//SQL文の発行(選択クエリ)
		stmt.executeUpdate(SQL.toString());

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
    <title>アンケート登録完了</title>
    <style>
    	body {
		    width: fit-content;
		    margin: 0 auto;
		    text-align: center;
    	}
    	footer {
    		margin-top: 30px;
    	}
    </style>
</head>
<body>
    <h1>[アンケート登録]</h1>
    <br>
    <p>書き込み完了しました</p>
	<a href="form_menu.jsp">メニューへ戻る</a>
	<footer>
		Copyright©2024 HAL Nagoya the Department of WEB System Development, All right reserved.
	</footer>
</body>
</html>