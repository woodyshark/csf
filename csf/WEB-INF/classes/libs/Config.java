package libs;

import java.io.IOException;

public class Config {
   public static String parthtml() throws IOException {
      String data = "http://chotserver.myaisfibre.com:8888/csf/login.jsp";
      return "http://chotserver.myaisfibre.com:8888/csf/login.jsp";
   }

   public static String partdirectory() throws IOException {
      String data = "/usr/local/tomcat/webapps/csf/document/";
      return "/usr/local/tomcat/webapps/csf/document/";
   }
}
