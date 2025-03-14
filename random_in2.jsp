<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%

%>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ランダム選択</title>
    <style>
    	footer {
    		margin-top: 30px;
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
    <h1>[ランダム選択]</h1>
    <br>
    <form action="random_out2.jsp" method="post">
	    <p>各クラスの中からランダムで選択します。</p>
	    <br>
	    <p>PI11A203(34名)から任意の人数を入力してください</p>
		<input type="text" name="PINum">人
		<br>
		<br>
	    <p>PW11A203(36名)から任意の人数を入力してください</p>
		<input type="text" name="PWNum">人
		<br>
		<br>
		<input class="btn" type="submit" value="送信する">
	</form>
	<footer>
		Copyright©2024 HAL Nagoya the Department of WEB System Development, All right reserved.
	</footer>
</body>
</html>