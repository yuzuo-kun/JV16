<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%

%>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>アンケート情報メニュー</title>
    <style>
    	body {
		    width: fit-content;
		    margin: 0 auto;
		    text-align: center;
    	}
    	footer {
    		margin-top: 30px;
    	}
    	.menu-box {
    		 display: flex;
		    justify-content: center;
    	}
    	.menu-box * {
    		width: 200px;
    		border: solid 1px #555;
    		margin: 0 2px;
    	}
    </style>
</head>
<body>
    <h1>[アンケート情報メニュー]</h1>
    <br>
    <div class="menu-box">
		<a href="form_in1.jsp">アンケート登録</a>
		<a href="form_out2.jsp">アンケート一覧</a>
	</div>
	<footer>
		Copyright©2024 HAL Nagoya the Department of WEB System Development, All right reserved.
	</footer>
</body>
</html>