<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
  String namae = request.getParameter("namae");
  String gakunen = request.getParameter("gakunen");
  int gozen = Integer.parseInt(request.getParameter("gozen"));
  int gogo = Integer.parseInt(request.getParameter("gogo"));

  int goukei = gozen + gogo;
  String hantei = "";
  if(gozen >= 65 && gogo >= 65 && goukei >= 140) {
    hantei = "合格";
  } else {
    hantei = "不合格";
  }
%>
<html lang='ja'>
  <head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>サーブレットへデータ送信</title>
  </head>
  <body style='background-color: #fff;'>
    <p>kokushi2.jsp</p>
    <br>
        <center>
            <h1>
                国家試験判定
                <br><br>
                <font color='deeppink'>
                   <%= gakunen %>
                </font>
             	の
                <font color='deeppink'>
                    <%= namae %>
                </font>
                 さん
                 <br><br>
                 あなたの得点は
                 <br><br>
                 午前
                <font color='deeppink'>
                   <%= gozen %>
                </font>
                 点　午後
                <font color='deeppink'>
                   <%= gogo %>
                </font>
                点　合計
                <font color='deeppink'>
                   <%= goukei %>
                </font>
                点
                <br><br>
                判定結果は
                <font color='deeppink'>
                    <%= hantei %>
                </font>
                です
            </h1>
        </center>
    <hr>
  </body>
</html>


