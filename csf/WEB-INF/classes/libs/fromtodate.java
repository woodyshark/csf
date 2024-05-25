package libs;

import java.io.IOException;
import java.util.Date;

public class fromtodate {
   public static String convert_percent(String data, int counter) throws IOException {
      for(int i = 0; i < counter && data.length() != counter; ++i) {
         data = "%".concat(data);
      }

      return data;
   }

   public static String convert_zero(String data, int counter) throws IOException {
      for(int i = 0; i < counter && data.length() != counter; ++i) {
         data = "0".concat(data);
      }

      return data;
   }

   public static String where(String start_dd, String start_mm, String start_yy, String end_dd, String end_mm, String end_yy, String table) throws IOException {
      String start_dd1 = "";
      String start_mm1 = "";
      String start_yy1 = "";
      String end_dd1 = "";
      String end_mm1 = "";
      String end_yy1 = "";
      String where2 = "";
      start_dd1 = convert_percent(start_dd, 2);
      start_mm1 = convert_percent(start_mm, 2);
      start_yy1 = convert_percent(start_yy, 4);
      end_dd1 = convert_percent(end_dd, 2);
      end_mm1 = convert_percent(end_mm, 2);
      end_yy1 = convert_percent(end_yy, 4);
      if (!start_dd.equals("") || !start_mm.equals("") || !start_yy.equals("") || !end_dd.equals("") || !end_mm.equals("") || !end_yy.equals("")) {
         if ((start_dd.equals("") || start_mm.equals("") || start_yy.equals("")) && end_dd.equals("") && end_mm.equals("") && end_yy.equals("")) {
            where2 = " and substring(" + table + ",1,4) like '" + start_yy1 + "' and substring(" + table + ",5,2) like '" + start_mm1 + "' and substring(" + table + ",7,2) like '" + start_dd1 + "' ";
         } else if (!start_dd.equals("") || !start_mm.equals("") || !start_yy.equals("") || !end_dd.equals("") && !end_mm.equals("") && !end_yy.equals("")) {
            start_dd1 = convert_zero(start_dd, 2);
            start_mm1 = convert_zero(start_mm, 2);
            start_yy1 = convert_zero(start_yy, 4);
            end_dd1 = convert_zero(end_dd, 2);
            end_mm1 = convert_zero(end_mm, 2);
            end_yy1 = convert_zero(end_yy, 4);
            where2 = " and (" + table + " >= '" + start_yy1 + start_mm1 + start_dd1 + "' and " + table + " <= '" + end_yy1 + end_mm1 + end_dd1 + "') ";
         } else {
            where2 = " and substring(" + table + ",1,4) like '" + end_yy1 + "' and substring(" + table + ",5,2) like '" + end_mm1 + "' and substring(" + table + ",7,2) like '" + end_dd1 + "' ";
         }
      }

      return where2;
   }

   public static int today() throws IOException {
      Date today = new Date();
      String years = Integer.toString(1900 + today.getYear());
      String months = convert_zero(Integer.toString(today.getMonth() + 1), 2);
      String dates = convert_zero(Integer.toString(today.getDate()), 2);
      int today_dates = Integer.parseInt(years.concat(months).concat(dates));
      return today_dates;
   }
}
