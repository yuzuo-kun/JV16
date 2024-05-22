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
	int num = 0;
	// 空入力x
	if(request.getParameter("num") == null || request.getParameter("num").equals("")) {
		response.sendRedirect("random_in.jsp");
	} else {
		// 文字x
		try{
			num = Integer.parseInt(request.getParameter("num"));
		} catch(Exception e) {
			response.sendRedirect("random_in.jsp");
		}
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
	// 最大数
	int maxNum = 0;
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
		
		// 最大数の取得
		SQL = new StringBuffer();
		SQL.append("select count(id) from meibo_tbl");
		rs = stmt.executeQuery(SQL.toString());
		rs.next();
		maxNum = rs.getInt("count(id)");
		
		// numを比較
		if(1 > num || num > maxNum) {
			response.sendRedirect("random_in.jsp");
		}
		
        // idsの生成
        ArrayList<Integer> ids = new ArrayList<Integer>();        
        for(int i = 1 ; i <= maxNum ; i++) {
            ids.add(i);
        }
        
        // シャッフルして、順番を変える
        Collections.shuffle(ids);
		
		// numの数だけ取得→randomNum
		int[] randomNum = new int[num];       
        for(int i = 0 ; i < num ; i++) {
            randomNum[i] = ids.get(i);
        }
		
		// randomNumの件数分繰り返してデータを取得
		// SQLステートメントの作成(選択クエリ)
		SQL = new StringBuffer();
		SQL.append("select m.id, c.id, c.name, m.num, m.name from meibo_tbl m, class_tbl c where m.classID = c.id and m.id in (");
		for(int i = 0; i < randomNum.length; i++) {
			SQL.append(randomNum[i]);
			if(i != randomNum.length - 1) {
				SQL.append(", ");
			}
		}
		System.out.println(SQL.toString());
		SQL.append(") order by c.id, m.num");
		rs = stmt.executeQuery(SQL.toString());
		// データの格納処理
		while(rs.next()) {
			map = new HashMap<String, String>();
			map.put("id", rs.getString("m.id"));
			map.put("className", rs.getString("c.name"));
			map.put("num", rs.getInt("m.num") < 10 ? "0" + rs.getString("m.num") : rs.getString("m.num"));
			map.put("name", rs.getString("m.name"));
			list.add(map);
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
	<a href="random_in.jsp">戻る</a>
	<footer>
		Copyright©2024 HAL Nagoya the Department of WEB System Development, All right reserved.
	</footer>
</body>
</html>