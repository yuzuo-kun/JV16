<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	// 
	
	// reqより値の取得
	int PINum = 0;
	int PWNum = 0;
	try {
		if(request.getParameter("PINum") != null && !request.getParameter("PINum").equals("")) {
			PINum = Integer.parseInt(request.getParameter("PINum"));
		}
		if(request.getParameter("PWNum") != null && !request.getParameter("PWNum").equals("")) {
			PWNum = Integer.parseInt(request.getParameter("PWNum"));	
		}
	} catch(Exception e) {
		response.sendRedirect("random_in2.jsp");
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
	String DRIVER = "com.mysql.jdbc.Driver";
	
	//サーバのMySQLに接続する設定
	//String USER = "nhs30435";
	//String PASWORD = "byyyymmdd";
	//String URL = "jdbc:mysql://192.168.121.16/nhs30435db";
	
	//エラーメッセージ
	StringBuffer ERMSG = null;
	// list
	ArrayList<HashMap> list = new ArrayList<HashMap>();
	// map
	HashMap<String, String> map = null;
	
	try { 
		//JDBCのドライバのロード
		Class.forName(DRIVER).newInstance();
		//Connectionオブジェクトの作成
		con = DriverManager.getConnection(URL, USER, PASSWORD);
		//Statementオブジェクトの作成
		stmt = con.createStatement();
		
		// PIIdsの取得
		ArrayList<Integer> PIIds = new ArrayList<Integer>();        
		SQL = new StringBuffer();
		SQL.append("select id from meibo_tbl where classID = 1 order by id");
		rs = stmt.executeQuery(SQL.toString());
        while(rs.next()) {
            PIIds.add(rs.getInt("id"));
        }
        // シャッフル
        Collections.shuffle(PIIds);
		// PWIdsの取得
		ArrayList<Integer> PWIds = new ArrayList<Integer>();        
		SQL = new StringBuffer();
		SQL.append("select id from meibo_tbl where classID = 2 order by id");
		rs = stmt.executeQuery(SQL.toString());
        while(rs.next()) {
            PWIds.add(rs.getInt("id"));
        }
        // シャッフル
        Collections.shuffle(PWIds);
		
		// numの数だけ取得→randomNum
		int[] PIRandomNum = new int[PINum];       
        for(int i = 0 ; i < PINum ; i++) {
            PIRandomNum[i] = PIIds.get(i);
            if(i == PIIds.size() - 1) {
            	break;
            }
        }
		int[] PWRandomNum = new int[PWNum];       
        for(int i = 0 ; i < PWNum ; i++) {
            PWRandomNum[i] = PWIds.get(i);
            if(i == PWIds.size() - 1) {
            	break;
            }
        }
		
		// randomNumの件数分繰り返してデータを取得
		// PI
		SQL = new StringBuffer();
		SQL.append("select c.name, m.num, m.name from meibo_tbl m, class_tbl c where m.classID = c.id and m.id in (");
		for(int i = 0; i < PIRandomNum.length; i++) {
			SQL.append(PIRandomNum[i]);
			if(i != PIRandomNum.length - 1) {
				SQL.append(", ");
			}
		}
		SQL.append(") order by m.num");
		System.out.println(SQL.toString());
		// PINumが0なら実行しない
		if(PINum != 0) {
			rs = stmt.executeQuery(SQL.toString());
			// データの格納処理
			while(rs.next()) {
				map = new HashMap<String, String>();
				map.put("className", rs.getString("c.name"));
				map.put("num", rs.getInt("m.num") < 10 ? "0" + rs.getString("m.num") : rs.getString("m.num"));
				map.put("name", rs.getString("m.name"));
				list.add(map);
			}
		}
		// PW
		SQL = new StringBuffer();
		SQL.append("select c.name, m.num, m.name from meibo_tbl m, class_tbl c where m.classID = c.id and m.id in (");
		for(int i = 0; i < PWRandomNum.length; i++) {
			SQL.append(PWRandomNum[i]);
			if(i != PWRandomNum.length - 1) {
				SQL.append(", ");
			}
		}
		SQL.append(") order by m.num");
		System.out.println(SQL.toString());
		// PWNumが0なら実行しない
		if(PWNum != 0) {
			rs = stmt.executeQuery(SQL.toString());
			// データの格納処理
			while(rs.next()) {
				map = new HashMap<String, String>();
				map.put("className", rs.getString("c.name"));
				map.put("num", rs.getInt("m.num") < 10 ? "0" + rs.getString("m.num") : rs.getString("m.num"));
				map.put("name", rs.getString("m.name"));
				list.add(map);
			}
		}
	} catch (ClassNotFoundException e) {
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
	} finally { //例外があってもなくても必ず実行する
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
    <title>ランダム表示</title>
    <style>	
    	footer {
    		margin-top: 30px;
    	}
    	p {
    		padding: 0;	
    		margin: 0;
    	}
    	.red {
    		color: red;
    	}
    </style>
</head>
<body>
    <h1>[ランダム表示]</h1>
    <br>
    <%
    	if(ERMSG != null) {
    %>
    	<P class="red"><%=ERMSG%></P>
    <%
    	}
    %>
    <%
		for(int i = 0; i < list.size(); i++) {
    %>
    		<p><%=list.get(i).get("className")%>　<%=list.get(i).get("num")%>　<%=list.get(i).get("name")%></p>
    <%
		}
    %>
    <br>
    <br>
	<a href="random_in2.jsp">戻る</a>
	<footer>
		Copyright©2024 HAL Nagoya the Department of WEB System Development, All right reserved.
	</footer>
</body>
</html>