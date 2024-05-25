package libs;

import java.io.IOException;

public class keysearch {
   public static String search(String keys) throws IOException {
      String star = "*";
      String key = "";
      int counts = keys.length();
      if (keys != null && !star.equals(keys) && counts != 0 && !keys.equals("%")) {
         key = keys;

         for(int i = 1; i <= counts; ++i) {
            String cutkey = key.substring(i - 1, i);
            if (cutkey.equals("*")) {
               if (i == 1) {
                  key = "%" + key.substring(i, counts);
               } else if (i == counts) {
                  key = key.substring(0, i - 1) + "%";
               } else {
                  key = key.substring(0, i - 1) + "%" + key.substring(i, counts);
               }
            }

            if (cutkey.equals("'")) {
               if (i == 1) {
                  key = "'" + key.substring(i, counts);
               } else if (i == counts) {
                  key = key.substring(0, i - 1) + "'";
               } else {
                  key = key.substring(0, i - 1) + "'" + key.substring(i, counts);
               }
            }
         }

         if (key == keys) {
            key = "%" + keys + "%";
         }
      } else {
         key = "%";
      }

      return key;
   }
}
