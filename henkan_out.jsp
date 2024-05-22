<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*" %>
<%@ page import="henkan.henkan" %>
<%
	henkan ht = new henkan();
	String[] tanni = ht.tanni;
	float[] kansan = ht.kansan;
	String[] henkanTanni = ht.henkanTanni;

	String nyuryoku[] = new String[tanni.length];

	for(int i = 0; i < tanni.length; i++) {
		nyuryoku[i] = request.getParameter(tanni[i]);
	}

	float ans = 0.0F;
	int yousoIndex = 0;
	boolean inputFlg = false;

	for(int i = 0; i < nyuryoku.length; i++) {
		if(nyuryoku[i] != null && !nyuryoku[i].equals("")) {
			ans = Float.parseFloat(nyuryoku[i]) * kansan[i];
			yousoIndex = i;
			inputFlg = true;
		}
	}

%>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSPへデータ送信</title>
</head>
<body>
    <h1>変換結果</h1>
    <br><br>


    <p>
    	<% if(inputFlg) { %>
	    	<%= nyuryoku[yousoIndex] %> <%= tanni[yousoIndex] %> →
	    		<%= ans %> <%= henkanTanni[yousoIndex] %>
	    <% } else { %>
	    	何も入力されてないよう
	    <% } %>

    </p>


	<hr>
	<a href="henkan_in.jsp">戻る</a>

</body>
</html>