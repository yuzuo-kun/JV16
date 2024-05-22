import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/servlet/kokushi1"})
public class kokushi1 extends HttpServlet{
  public void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException{
      PrintWriter out;
      req.setCharacterEncoding("UTF-8");
      res.setContentType("text/html;charset=UTF-8");
      out = res.getWriter();

      // webブラウザのformからパラメータを取得
      String namae = req.getParameter("namae");
      String gakunen = req.getParameter("gakunen");
      int gozen = Integer.parseInt(req.getParameter("gozen"));
      int gogo = Integer.parseInt(req.getParameter("gogo"));

      int goukei = gozen + gogo;
      String hantei = "";
      if(gozen >= 65 && gogo >= 65 && goukei >= 140) {
        hantei = "合格";
      } else {
        hantei = "不合格";
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
      sb.append("<p>kokushi1.java</p>");
      sb.append("<br>");
      sb.append("<center>");
      sb.append("<h1>国家試験判定</h1>");
      sb.append("<br><br>");
      sb.append(gakunen);
      sb.append("年生の");
      sb.append(namae);
      sb.append("さん");
      sb.append("<br>");
      sb.append("あなたの得点は");
      sb.append("<br>");
      sb.append("午前");
      sb.append(gozen);
      sb.append("点");
      sb.append("　　午後");
      sb.append(gogo);
      sb.append("点");
      sb.append("　　合計");
      sb.append(goukei);
      sb.append("点");
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