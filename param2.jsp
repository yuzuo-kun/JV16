<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
    String namaeStr = request.getParameter("NAMAE");
    String seibetuStr = request.getParameter("SEIBETU");
    String toshiStr = request.getParameter("TOSHI");
    String address1Str = request.getParameter("ADDRESS1");

    String seibetuHantei = "";

    if(seibetuStr.equals("1")){
        seibetuHantei = "男性";
    } else {
        seibetuHantei = "女性";
    }
%>

<!DOCTYPE html>
<html lang='ja'>
    <head>
        <meta charset='UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
        <title>サーブレットでデータの表示</title>
    </head>
    <body>
        param1.jsp
        <center>
            <h1>
                HTMLさんから届きました
                <br><br>
                あなたは
                <br>
                <font color='deeppink'>
                    <%= address1Str %>
                </font>
                にお住いの
                <font color='deeppink'>
                    <%= namaeStr %>
                </font>
                    さんですね
                <br>
                    ほいでもって
                <br>
                <font color='deeppink'>
                    <%= toshiStr %>
                </font>
                    才の
                <font color='deeppink'>
                    <%= seibetuHantei %>
                </font>
                なんですね
            </h1>
        </center>
    </body>
</html>
