<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");

	String cus_id = request.getParameter("id");
	String cus_pas = request.getParameter("pas");

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
	
	String COMPMSG = null;
	String COMPPRO = null;

	boolean flag = true;

	if(cus_id != "" && cus_pas != "") {
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
			SQL.append("select * from cus_tbl where cus_id = '");
			SQL.append(cus_id);
			SQL.append("'");
	
			//SQL文の発行(選択クエリ)
			rs = stmt.executeQuery(SQL.toString());
	
			//抽出したデータを繰り返し処理で表示する
			if (rs.next()) {
				if (rs.getString("cus_pas").equals(cus_pas)) {
					if (rs.getString("cus_pas").equals(cus_pas)) {
						session.setMaxInactiveInterval(30);
						session.setAttribute("login_name", rs.getString("cus_name"));
						response.sendRedirect("syouhin_main.jsp");
					}
				}
			} else {
				COMPMSG = "該当レコードは存在しません";
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
	}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>認証処理</title>
</head>
<body>

	<%
		if (ERMSG != null) {
	%>
	予期せぬエラーが発生しました
	<br>
	<%=ERMSG%>
	<%
		} else {
	%>
	<%=COMPMSG%>
	<form method="post" action="syouhin_index.jsp">
		<button type="submit">戻る</button>
	</form>
	<%
		}
	%>	

</body>
</html>