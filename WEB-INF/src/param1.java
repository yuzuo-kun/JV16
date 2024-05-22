import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"/servlet/param1"})

public class param1 extends HttpServlet{
  public void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException{
      PrintWriter out;
      req.setCharacterEncoding("UTF-8");
      res.setContentType("text/html;charset=UTF-8");
      out = res.getWriter();

      // webブラウザのformからパラメータを取�?
      String namaeStr = req.getParameter("NAMAE");
      String seibetuStr = req.getParameter("SEIBETU");
      String toshiStr = req.getParameter("TOSHI");
      String address1Str = req.getParameter("ADDRESS1");

      // 入力データの表示
      StringBuffer sb = new StringBuffer();
      sb.append("<!DOCTYPE html>");
      sb.append("<html lang='ja'>");
      sb.append("<head>");
      sb.append("<meta charset='UTF-8'>");
      sb.append("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
      sb.append("<title>サーブレットでデータの表示</title>");
      sb.append("</head>");
      sb.append("<body>");
      sb.append("param1.java");
      sb.append("<center>");
      sb.append("<h1>");
      sb.append("HTMLさんから届きました");
      sb.append("<br><br>");
      sb.append("あなたは");
      sb.append("<br>");
      sb.append("<font color='deeppink'>");
      sb.append(address1Str);
      sb.append("</font>");
      sb.append("にお住いの");
      sb.append("<font color='deeppink'>");
      sb.append(namaeStr);
      sb.append("</font>");
      sb.append("さんですね");
      sb.append("<br>");
      sb.append("ほいでもって");
      sb.append("<br>");
      sb.append("<font color='deeppink'>");
      sb.append(toshiStr);
      sb.append("</font>");
      sb.append("才の");
      sb.append("<font color='deeppink'>");
      if(seibetuStr.equals("1")){
        sb.append("男性");
      }else{
        sb.append("女性");
      }
      sb.append("</font>");
      sb.append("なんですね");
      sb.append("</h1>");
      sb.append("</center>");
      sb.append("</body>");
      sb.append("</html>");
      out.println(sb.toString());
    }
}