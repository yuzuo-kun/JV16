<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="henkan.henkan" %>
<%
	henkan ht = new henkan();
	String[] tanni = ht.tanni;
	float[] kansan = ht.kansan;
	String[] henkanTanni = ht.henkanTanni;
%>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSPへデータ送信</title>

    <style type="text/css">
	    table{
	     	border: 1px solid #555;
	 	}
	 	th , td{
	    	border: 1px solid #555;
	    	padding: 5px 10px 5px 10px;
	 	}
	 	.koumoku{
	 		font-weight: bold;
	 		text-align: center;
	 	}
    </style>
</head>
<body>
    <h1>単位変換</h1>
    <br><br>
        <table>
            <tr class="koumoku">
                <td>項目名</td>
                <td>内容</td>
            </tr>
 			<form action="answer1.jsp" method="post">
	            <tr>
	                <td>お名前</td>
	                <td><input type="text" name="name"></td>
	            </tr>
	            <tr>
	                <td>郵便番号</td>
	                <td><input type="text" name="yubinNum"></td>
	            </tr>
	            <tr>
	                <td>住所</td>
	                <td><input type="text" name="address"></td>
	            </tr>
	            <tr>
	                <td>電話番号</td>
	                <td><input type="text" name="callNum"></td>
	            </tr>
	            <tr>
	                <td>性別</td>
	                <td>
	                	<input id="otoko" type="radio" name="seibetu" value="1"><label for="otoko">男性</label>
	                	<input id="onna" type="radio" name="seibetu" value="2"><label for="onna">女性</label>
	                </td>
	            </tr>
	            <tr>
	                <td>生年月日（年）</td>
	                <td><input type="text" name="year"></td>
	            </tr>
	            <tr>
	                <td>生年月日（月）</td>
	                <td><input type="text" name="month"></td>
	            </tr>
	            <tr>
	                <td>生年月日（日）</td>
	                <td><input type="text" name="day"></td>
	            </tr>
	            <tr>
	                <td colspan="2" style="text-align: center;"><input type="submit" value="送信する"></td>
	            </tr>
			</form>
        </table>
</body>
</html>