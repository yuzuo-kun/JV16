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
                <td colspan="2">単位</td>
                <td>換算式</td>
                <td colspan="2">変換単位</td>
            </tr>
        <% for(int i = 0; i < tanni.length; i++) { %>
    		<form action="henkan_out.jsp" method="post">
	            <tr>
	                <td><input type="text" name="<%= tanni[i] %>"></td>
	                <td><%= tanni[i] %></td>
	                <td>x <%= kansan[i] %></td>
	                <td><%= henkanTanni[i] %></td>
	                <td><button type="submit">変換</button></td>
	            </tr>
    		</form>
        <% } %>
        </table>
</body>
</html>