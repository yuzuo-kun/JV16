<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>ショッピングカート</title>
</head>
<body>
	<h1>商品一覧</h1>
	<%
		String[] syouhin_name = {"はさみ", "えんぴつ", "ノート"};
		// ArrayListからデータを取り出す
		for (int i = 0; i < syouhin_name.length; i++) {
	%>
	<form method="post" action="cart_out.jsp">
		<table border="1">
			<tr>
				<td rowspan="4">
					<img src="./image/bung<%=i + 1%>.png" height="64px" width="64px">
				</td>
			</tr>
			<tr>
				<td>商品No</td>
				<td width="100"><%=i + 1%></td>
			</tr>
			<tr>
				<td>商品名</td>
				<td width="100"><%=syouhin_name[i]%></td>
			</tr>
			<tr>
				<td>数量</td>
				<td width="100">
					<select size="1" name="syouhin<%=i + 1%>">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<button type="submit">カートに入れる</button>
				</td>
			</tr>
		</table>
	</form>
	<br>
	<%
		}
	%>
	<form method="post" action="cart_out.jsp">
		<button type="submit">カートの中を見る</button>
	</form>
</body>
</html>