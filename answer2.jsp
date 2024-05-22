<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String name = request.getParameter("name");
	String yubinNum = request.getParameter("yubinNum");
	String address = request.getParameter("address");
	String callNum = request.getParameter("callNum");
	String seibetuValue = request.getParameter("seibetu");

	String seibetu = "";

	if(seibetuValue.equals("1")) {
		seibetu = "男";
	} else {
		seibetu = "女";
	}

	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int day = Integer.parseInt(request.getParameter("day"));

	String seinen = year + "年" + month + "月" + day + "日";

    Date today = new Date();
    Calendar cal = Calendar.getInstance();
    cal.setTime(today);

    int yy = cal.get(cal.YEAR);
    int mm = cal.get(cal.MONTH) + 1;
    int dd = cal.get(cal.DATE);

    int nen = yy * 10000 + mm * 100 + dd;
    int age_nen = year * 10000 + month * 100 + day;

    int nenrei = (nen - age_nen) / 10000;

    String unseiItem[] = {"大吉", "中吉", "小吉", "吉", "末吉", "凶", "大凶"};
    double d_unseiNum = Math.floor(Math.random() * 7);
    int unseiNum = (int)d_unseiNum;
    String unsei = unseiItem[unseiNum];

    String passHeadRandom[] = {	"A","B","C","D","E",
					    		"F","G","H","I","J",
					    		"K","L","M","N","O",
					    		"P","Q","R","S","T",
					    		"U","V","W","X","Y",
					    		"Z"
    						};

    String passRandom[] = {	"A","B","C","D","E",
				    		"F","G","H","I","J",
				    		"K","L","M","N","O",
				    		"P","Q","R","S","T",
				    		"U","V","W","X","Y",
				    		"Z","a","b","c","d",
				    		"e","f","g","h","i",
				    		"j","k","l","m","n",
				    		"o","p","q","r","s",
				    		"t","u","v","w","x",
				    		"y","z","0","1","2",
				    		"3","4","5","6","7",
				    		"8","9"
						};

    double d_passMoziNum = 0.0;
    int passMoziNum = 0;

    String pass = "";

    double d_passNum = Math.floor(Math.random() * 7 + 6);
    int passNum = (int)d_passNum;

    for(int i = 0; i < passNum; i++) {
    	if(i == 0) {
    		d_passMoziNum = Math.floor(Math.random() * 26);
    	    passMoziNum = (int)d_passMoziNum;
    		pass += passHeadRandom[passMoziNum];
    	} else {
    		d_passMoziNum = Math.floor(Math.random() * 62);
    	    passMoziNum = (int)d_passMoziNum;
    		pass += passRandom[passMoziNum];
    	}

    }


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
                <td>項目名</td>
                <td>内容</td>
            </tr>
            <tr>
                <td>お名前</td>
                <td><%= name %></td>
            </tr>
            <tr>
                <td>郵便番号</td>
                <td><%= yubinNum %></td>
            </tr>
            <tr>
                <td>住所</td>
                <td><%= address %></td>
            </tr>
            <tr>
                <td>電話番号</td>
                <td><%= callNum %></td>
            </tr>
            <tr>
                <td>性別</td>
                <td><%= seibetu %></td>
            </tr>
            <tr>
                <td>生年月日</td>
                <td><%= seinen %></td>
            </tr>
            <tr>
                <td>年令</td>
                <td><%= nenrei %>才</td>
            </tr>
                <td>今日の運勢</td>
                <td><%= unsei %></td>
            </tr>
            </tr>
                <td>パスワード</td>
                <td><%= pass %></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;"><a href="question2.jsp">戻る</a></td>
            </tr>
        </table>
</body>
</html>