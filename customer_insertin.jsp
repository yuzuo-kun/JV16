<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>顧客ID入力</title>
</head>
<body BGCOLOR="#FFFFFF">
	customer_insertin.jsp
	<br>
	<br>
	顧客登録
	<br>
	<br>
	<form method="post" action="/JV16/customer_insertout.jsp">
	<table border="1">
		<tr>
			<th>項目名</th><th>内容</th>
		</tr>
		<tr>
			<td>顧客ID</td>
			<td><input type="text" name="cus_id" size="40" maxlength="20"></td>
		</tr>
		<tr>
			<td>パスワード</td>
			<td><input type="password" name="cus_pas" size="41" maxlength="20"></td>
		</tr>
		<tr>
			<td>氏名</td>
			<td><input type="text" name="cus_name" size="40" maxlength="20"></td>
		</tr>

	</table>
		<br>
		<br>
		<hr>
		<button type="submit">送信</button>
		<button type="reset">入力クリア</button>
	</form>
</body>
</html>