<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>顧客ID入力</title>
</head>
<body BGCOLOR="#FFFFFF">
	customer_selectin.jsp
	<br>
	<br> 顧客認証
	<br>
	<br>
	<form method="post" action="/JV16/customer_selectout.jsp">
		顧客ID <input type="text" name="cus_id"> 顧客PW <input type="text"
			name="cus_pas"> <br>
		<br>
		<hr>
		<button type="submit">送信</button>
		<button type="reset">入力クリア</button>
	</form>
</body>
</html>