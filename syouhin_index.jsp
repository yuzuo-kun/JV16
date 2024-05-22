<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	String logout = request.getParameter("logout");
	if(logout != null) {
		session.removeAttribute("login_name");
	}
	String session_name = (String)session.getAttribute("login_name");
	if(session_name != null) {
		response.sendRedirect("syouhin_main.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>ログインページ</title>
</head>
<body>
		<form method="post" action="login_index_action.jsp">
		<table border="1">
			<tr>
				<td>会員ID</td>
				<td><input type="text" name="id" size="50"
					maxlength="20" required></td>
			</tr>
			<tr>
				<td>パスワード</td>
				<td><input type="text" name="pas" size="50"
					maxlength="20" required></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">ログイン</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>