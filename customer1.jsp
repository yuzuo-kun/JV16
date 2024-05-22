<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />

    <title>「顧客テーブルの内容を読み込みそのまま表示するプログラム」</title>
  </head>

  <body>
    <table border="1">
    <tr><th>顧客No.</th><th>顧客ID</th><th>パスワード</th><th>氏名</th></tr>

    <%
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");

      Connection con = null;
      Statement stmt = null;
      StringBuffer SQL = null;
      ResultSet rs = null;

      String USER = "root";
      String PASSWORD = "root";
      String URL = "jdbc:mysql://localhost/nhs30061db";

      String DRIVER = "com.mysql.jdbc.Driver";

      Class.forName(DRIVER).newInstance();

      con = DriverManager.getConnection(URL, USER, PASSWORD);

      stmt = con.createStatement();

      SQL = new StringBuffer();

      SQL.append("select * from cus_tbl");

      rs = stmt.executeQuery(SQL.toString());

      while(rs.next()) {
    %>
    <tr><td><%= rs.getString("cus_no") %></td><td><%= rs.getString("cus_id") %></td><td><%= rs.getString("cus_pas") %></td><td><%= rs.getString("cus_name") %></td></tr>
    <%
      }
      rs.close();
      stmt.close();
      con.close();
    %>
    </table>
  </body>
</html>
