import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/servlet/bmi"})
public class bmi extends HttpServlet{
  public void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException{
      PrintWriter out;
      req.setCharacterEncoding("UTF-8");
      res.setContentType("text/html;charset=UTF-8");
      out = res.getWriter();

      // webブラウザのformからパラメータを取得
      String namae = req.getParameter("namae");
      float height = Float.parseFloat(req.getParameter("height"));
      float weight = Float.parseFloat(req.getParameter("weight"));

      float bmi = weight / ((height / 100) * (height / 100));
      String hantei = "";
      if(bmi >= 25) {
        hantei = "太っている";
      } else if(bmi >= 18.5) {
        hantei = "標準";
      } else {
        hantei = "やせている";
      }

      // 入力データの表示
      StringBuffer sb = new StringBuffer();
      sb.append("<!DOCTYPE html>");
      sb.append("<html lang='ja'>");
      sb.append("<head>");
      sb.append("<meta charset='UTF-8'>");
      sb.append("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
      sb.append("<title>サーブレットへデータ送信</title>");
      sb.append("</head>");
      sb.append("<body style='background-color: #fff;'>");
      sb.append("<p>bmi.java</p>");
      sb.append("<br>");
      sb.append("<center>");
      sb.append("<h1>BMI測定</h1>");
      sb.append("<br><br>");
      sb.append(namae);
      sb.append("さん");
      sb.append("<br>");
      sb.append("あなたのBMI値は");
      sb.append("<br>");
      sb.append("身長：");
      sb.append(height);
      sb.append("ｃｍ");
      sb.append("<br>");
      sb.append("体重：");
      sb.append(weight);
      sb.append("ｋｇ");
      sb.append("<br>");
      sb.append("BMI値：");
      sb.append(bmi);
      sb.append("<br>");
      sb.append("<br>");
      sb.append("判定結果は");
      sb.append(hantei);
      sb.append("です");
      sb.append("</center>");
      sb.append("<hr>");
      sb.append("</body>");
      sb.append("</html>");
      out.println(sb.toString());
    }
}
