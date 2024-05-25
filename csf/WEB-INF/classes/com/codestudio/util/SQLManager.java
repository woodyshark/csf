package com.codestudio.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mariadb.jdbc.MariaDbPoolDataSource;

public class SQLManager {
   public static SQLManager getInstance() {
      return new SQLManager();
   }

   public static void main(String[] a) {
      SQLManager m = getInstance();
      Connection c = m.requestConnection("csf");
      System.out.print(c);
   }

   public void returnConnection(String dbName, Connection conn) {
      try {
         conn.close();
      } catch (SQLException var4) {
         Logger.getLogger(SQLManager.class.getName()).log(Level.SEVERE, (String)null, var4);
      }

   }

   public Connection requestConnection(String dbName) {
//String constr = "jdbc:mariadb://192.168.68.123:3307/" + dbName + "?user=csf&password=Abcd@123456&maxPoolSize=10&characterEncoding=utf8";
	String constr = "jdbc:mariadb://183.90.168.95:3308/" + dbName + "?user=csf&password=thrnnvtn&maxPoolSize=10&characterEncoding=utf8";
      System.out.println(constr);
      MariaDbPoolDataSource pool = new MariaDbPoolDataSource(constr);
      Connection connection = null;

      try {
         connection = pool.getConnection();
      } catch (SQLException var6) {
         Logger.getLogger(SQLManager.class.getName()).log(Level.SEVERE, (String)null, var6);
      }

      return connection;
   }
}
