<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
	//文字コードの指定
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	// 入力した数量を格納する配列
	String[] syouhin = new String[3];
	
	// sessionの数量を格納する配列
	String[] syouhin_count = new String[3];
	
	// カートを空にする
	String cart_crea = request.getParameter("crea");
	if(cart_crea != null) {
		// session変数を削除
		session.removeAttribute("syouhin1");
		session.removeAttribute("syouhin2");
		session.removeAttribute("syouhin3");
	}
	
	// 商品単位でカートを空にする
	String one_crea = request.getParameter("onecrea");
	if(one_crea != null) {
		// session変数を削除
		if(one_crea.equals("1")) {
			session.removeAttribute("syouhin1");
		} else if(one_crea.equals("2")) {
			session.removeAttribute("syouhin2");
		} else if(one_crea.equals("3")) {
			session.removeAttribute("syouhin3");			
		}
	}
	
	// カートの増減処理
	String one_pluse = request.getParameter("onepluse");
	String one_pluse_count = "";
	if(one_pluse != null) {
		// session変数を削除
		if(one_pluse.equals("1")) {
			one_pluse_count = (String)session.getAttribute("syouhin1");
			one_pluse_count =  new Integer(Integer.parseInt(one_pluse_count) + 1).toString();
			session.setAttribute("syouhin1", one_pluse_count);
		} else if(one_pluse.equals("2")) {
			one_pluse_count = (String)session.getAttribute("syouhin2");
			one_pluse_count =  new Integer(Integer.parseInt(one_pluse_count) + 1).toString();
			session.setAttribute("syouhin2", one_pluse_count);
		} else if(one_pluse.equals("3")) {
			one_pluse_count = (String)session.getAttribute("syouhin3");
			one_pluse_count =  new Integer(Integer.parseInt(one_pluse_count) + 1).toString();
			session.setAttribute("syouhin3", one_pluse_count);			
		}
	}
	String one_minus = request.getParameter("oneminus");
	String one_minus_count = "";
	if(one_minus != null) {
		// session変数を削除
		if(one_minus.equals("1")) {
			one_minus_count = (String)session.getAttribute("syouhin1");
			if(Integer.parseInt(one_minus_count) - 1 <= 0) {
				session.removeAttribute("syouhin1");
			} else {
				one_minus_count =  new Integer(Integer.parseInt(one_minus_count) - 1).toString();
				session.setAttribute("syouhin1", one_minus_count);
			}
		} else if(one_minus.equals("2")) {
			one_minus_count = (String)session.getAttribute("syouhin2");
			if(Integer.parseInt(one_minus_count) - 1 <= 0) {
				session.removeAttribute("syouhin2");
			} else {
				one_minus_count =  new Integer(Integer.parseInt(one_minus_count) - 1).toString();
				session.setAttribute("syouhin2", one_minus_count);
			}
		} else if(one_minus.equals("3")) {
			one_minus_count = (String)session.getAttribute("syouhin3");
			if(Integer.parseInt(one_minus_count) - 1 <= 0) {
				session.removeAttribute("syouhin3");
			} else {
				one_minus_count =  new Integer(Integer.parseInt(one_minus_count) - 1).toString();
				session.setAttribute("syouhin3", one_minus_count);
			}		
		}
	}
	
	// 商品ページより数量の取得
	syouhin[0] = request.getParameter("syouhin1");
	syouhin[1] = request.getParameter("syouhin2");
	syouhin[2] = request.getParameter("syouhin3");
	
	//sessionより数量の取得
	syouhin_count[0] = (String)session.getAttribute("syouhin1");
	syouhin_count[1] = (String)session.getAttribute("syouhin2");
	syouhin_count[2] = (String)session.getAttribute("syouhin3");
	
	// 合計を加算
	int goukei = 0;
	for(int i = 0; i < 3; i++) {
		if(syouhin[i] != null) {
			if(syouhin_count[i] != null) {
				goukei = Integer.parseInt(syouhin_count[i]);
			}
			goukei = goukei + Integer.parseInt(syouhin[i]);
		}
	}
	
	// sessionにビハインド
	if(syouhin[0] != null) {
		session.setAttribute("syouhin1", new Integer(goukei).toString());
	} else if(syouhin[1] != null) {
		session.setAttribute("syouhin2", new Integer(goukei).toString());
	} else if(syouhin[2] != null) {
		session.setAttribute("syouhin3", new Integer(goukei).toString());
	}
	
	// 有効期限30秒
	session.setMaxInactiveInterval(30);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>カートの中身</title>
</head>
<body>
	<h2>カートの中には以下の商品が入っています</h2>
	<%
		String count1 = (String)session.getAttribute("syouhin1");
		String count2 = (String)session.getAttribute("syouhin2");
		String count3 = (String)session.getAttribute("syouhin3");
	%>
	<% if(count1 != null) { %>
		<table border="1">
			<tr>
				<td rowspan="3">
					<img src="./image/bung1.png" height="64px" width="32px">
				</td>
				<td width="80">商品No</td>
				<td width="80">商品名</td>
				<td width="80">数量</td>
				<td>増減</td>
				<td rowspan="3">
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="onecrea" value="1">
						<button type="submit">この商品を削除</button>
					</form>
				</td>
			</tr>
			<tr>
				<td rowspan="2" width="80">1</td>
				<td rowspan="2">はさみ</td>
				<td rowspan="2"><%=count1%></td>
				<td>
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="oneminus" value="1">
						<button type="submit" style="width: 50px">ー</button>
					</form>
				</td>

			</tr>
			<tr>
				<td>
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="onepluse" value="1">
						<button type="submit" style="width: 50px">＋</button>
					</form>
				</td>
			</tr>
		</table>
	<br>
	<%
		}
	%>
	
	<% if(count2 != null) { %>
		<table border="1">
			<tr>
				<td rowspan="3">
					<img src="./image/bung2.png" height="64px" width="32px">
				</td>
				<td width="80">商品No</td>
				<td width="80">商品名</td>
				<td width="80">数量</td>
				<td>増減</td>
				<td rowspan="3">
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="onecrea" value="2">
						<button type="submit">この商品を削除</button>
					</form>
				</td>
			</tr>
			<tr>
				<td rowspan="2" width="80">2</td>
				<td rowspan="2">えんぴつ</td>
				<td rowspan="2"><%=count2%></td>
				<td>
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="oneminus" value="2">
						<button type="submit" style="width: 50px">ー</button>
					</form>
				</td>

			</tr>
			<tr>
				<td>
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="onepluse" value="2">
						<button type="submit" style="width: 50px">＋</button>
					</form>
				</td>
			</tr>
		</table>
	<br>
	<%
		}
	%>
	
	<% if(count3 != null) { %>
		<table border="1">
			<tr>
				<td rowspan="3">
					<img src="./image/bung3.png" height="64px" width="32px">
				</td>
				<td width="80">商品No</td>
				<td width="80">商品名</td>
				<td width="80">数量</td>
				<td>増減</td>
				<td rowspan="3">
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="onecrea" value="3">
						<button type="submit">この商品を削除</button>
					</form>
				</td>
			</tr>
			<tr>
				<td rowspan="2" width="80">3</td>
				<td rowspan="2">ノート</td>
				<td rowspan="2"><%=count3%></td>
				<td>
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="oneminus" value="3">
						<button type="submit" style="width: 50px">ー</button>
					</form>
				</td>

			</tr>
			<tr>
				<td>
					<form method="post" action="cart_out.jsp">
						<input type="hidden" name="onepluse" value="3">
						<button type="submit" style="width: 50px">＋</button>
					</form>
				</td>
			</tr>
		</table>
	<br>
	<%
		}
	%>
	
	<% if(count1 == null && count2 == null && count3 == null) { %>
	カートの中はありません<br>
	<%}%>
	<br>
	
	<table border="0">
		<tr>
			<td>
				<form method="post" action="cart_in.jsp">
					<button type="submit">お買い物を続ける</button>
				</form>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 20px">
				<form method="post" action="cart_out.jsp">
					<input type="hidden" name="crea" value="crea">
					<button type="submit">カートを全て空にする</button>
				</form>
			</td>
		</tr>
	</table>
</body>
</html>