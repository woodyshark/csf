package libs;

import java.text.DecimalFormat;
import java.text.NumberFormat;

public class convertcomma {
   public static String dtoa(String x, String fmt) {
      if (x != null && x.compareTo("") != 0 && x.compareToIgnoreCase("null") != 0) {
         NumberFormat form = NumberFormat.getInstance();
         ((DecimalFormat)form).applyPattern(fmt);
         return form.format(new Double(x));
      } else {
         return "";
      }
   }
}
