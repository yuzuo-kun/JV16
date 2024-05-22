<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%

%>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>アンケート入力フォーム</title>
    <style>
    	body {
		    width: fit-content;
		    margin: 0 auto;
		    text-align: center;
    	}
    	div {
    		margin-bottom: 20px;
    	}
    	footer {
    		margin-top: 30px;
    	}
    	textarea {
    	    resize: none;
		    width: 300px;
		    height: 70px;
    	}
    	p {
    		margin: 0;
    	}
    	.btn-box {
		    display: flex;
		    justify-content: center;
    	}
    	.btn-box * {
    		margin: 0 10px;
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
    <h1>[アンケート登録]</h1>
    <br>
    <form action="form_out1.jsp" method="post">
		<div>
			<label for="syou_name">商品名:</label>
			<input id="syou_name" name="syou_name" type="text" required>
		</div>
		<div>
			<span>色:</span>
			<input id="syou_red" name="syou_color" type="radio" value="1" checked>
			<label for="syou_red">赤
			<input id="syou_green" name="syou_color" type="radio" value="2">
			<label for="syou_green">緑
			<input id="syou_yellow" name="syou_color" type="radio" value="3">
			<label for="syou_yellow">黄
		</div>
		<div>
			<label for="syou_size">サイズ:</label>
			<select id="syou_size" name="syou_size">
				<option value="1">S</option>
				<option value="2">M</option>
				<option value="3">L</option>
				<option value="4">LL</option>
			</select>
		</div>
		<div>
			<p>アンケート（何が気に入りましたか）　複数回答可:</p>
			<input id="q_design" name="syou_question" type="checkbox" value="デザイン">
			<label for="q_design">デザイン
			<input id="q_color" name="syou_question" type="checkbox" value="色">
			<label for="q_color">色
			<input id="q_price" name="syou_question" type="checkbox" value="価格">
			<label for="q_price">価格
			<input id="q_desc" name="syou_question" type="checkbox" value="説明">
			<label for="q_desc">説明
			<input id="q_security" name="syou_question" type="checkbox" value="保障">
			<label for="q_security">保障
			<input id="q_maker" name="syou_question" type="checkbox" value="メーカー">
			<label for="q_maker">メーカー
		</div>
		<div>
			<label for="syou_msg">ご意見:</label>
			<textarea id="syou_msg" name="syou_msg"></textarea>
		</div>
		<div class="btn-box">
			<input class="btn" type="submit" value="データ送信">
			<a class="btn" href="form_in1.jsp">リセット</a>
		</div>
	</form>
	<a href="form_menu.jsp">メニューへ戻る</a>
	<footer>
		Copyright©2024 HAL Nagoya the Department of WEB System Development, All right reserved.
	</footer>
</body>
</html>