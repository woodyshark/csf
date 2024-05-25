package libs;

import java.text.DecimalFormat;
import java.text.NumberFormat;

public class convertthaibaht {
   public static String thaiPercent(String sVal) {
      return thaiPercent(Double.parseDouble("0" + sVal));
   }

   public static String thaiPercent(int iVal) {
      return thaiPercent(Double.parseDouble("0" + iVal));
   }

   public static String thaiPercent(double dVal) {
      StringBuffer thaiValue = new StringBuffer("");
      String[] thaiDigit = new String[]{"�ٹ��", "˹��", "�ͧ", "���", "���", "���", "ˡ", "��", "Ỵ", "���", "���", "���", "ź"};
      if (dVal == 0.0D) {
         return "�ٹ��";
      } else {
         NumberFormat form = NumberFormat.getInstance();
         ((DecimalFormat)form).applyPattern("0.00");
         String strVal = form.format(dVal);
         int strLen = strVal.length();
         String strBath = new String((new StringBuffer(strVal.substring(0, strLen - 3))).reverse());
         String strStang = new String(new StringBuffer(strVal.substring(strLen - 2)));
         if (strBath.compareTo("0") != 0) {
            thaiValue.append(digitAlpha(strBath));
         } else {
            thaiValue.append("�ٹ��");
         }

         if (strStang.compareTo("00") != 0) {
            thaiValue.append("�ش");
            thaiValue.append(thaiDigit[Integer.parseInt(strStang.substring(0, 1))]);
            String str = strStang.substring(1, 2);
            if (str.compareTo("0") != 0) {
               thaiValue.append(thaiDigit[Integer.parseInt(str)]);
            }
         }

         return thaiValue.toString();
      }
   }

   public static String thaiDecimal(double dVal) {
      StringBuffer thaiValue = new StringBuffer("");
      if (dVal == 0.0D) {
         return "�ٹ��ҷ";
      } else {
         NumberFormat form = NumberFormat.getInstance();
         ((DecimalFormat)form).applyPattern("0.00");
         String strVal = form.format(dVal);
         int strLen = strVal.length();
         String strBath = new String((new StringBuffer(strVal.substring(0, strLen - 3))).reverse());
         String strStang = new String((new StringBuffer(strVal.substring(strLen - 2))).reverse());
         if (strStang.compareTo("00") == 0) {
            thaiValue.insert(0, "��ǹ");
         } else {
            thaiValue.insert(0, "ʵҧ��");
            thaiValue.insert(0, digitAlpha(strStang));
         }

         if (strBath.compareTo("0") != 0) {
            thaiValue.insert(0, "�ҷ");
            thaiValue.insert(0, digitAlpha(strBath));
         }

         return thaiValue.toString();
      }
   }

   private static String digitAlpha(String strVal) {
      String[] thaiDigit = new String[]{"�ٹ��", "˹��", "�ͧ", "���", "���", "���", "ˡ", "��", "Ỵ", "���", "���", "���", "ź"};
      String[] thaiUnit = new String[]{"��ҹ", "�Ժ", "����", "�ѹ", "����", "�ʹ"};
      StringBuffer digitValue = new StringBuffer("");
      int strLen = strVal.length();
      if (strLen == 0 && strVal.charAt(0) == '0') {
         digitValue.insert(0, thaiDigit[0]);
         return digitValue.toString();
      } else {
         for(int i = 0; i < strLen; ++i) {
            char charVal = strVal.charAt(i);
            int iUnit = i % 6;
            if (charVal == '0') {
               if (iUnit == 0 && i > 0) {
                  digitValue.insert(0, thaiUnit[iUnit]);
               }
            } else {
               if (charVal == '-') {
                  digitValue.insert(0, thaiDigit[12]);
                  break;
               }

               if (i > 0) {
                  digitValue.insert(0, thaiUnit[iUnit]);
               }

               if (iUnit != 1 || charVal != '1') {
                  if (iUnit == 0 && charVal == '1') {
                     boolean testOne = false;

                     for(int j = i + 1; j < strLen && j - i != 3; ++j) {
                        if (strVal.charAt(j) > '0') {
                           testOne = true;
                           break;
                        }
                     }

                     if (testOne) {
                        digitValue.insert(0, thaiDigit[10]);
                     } else {
                        digitValue.insert(0, thaiDigit[1]);
                     }
                  } else if (iUnit == 1 && charVal == '2') {
                     digitValue.insert(0, thaiDigit[11]);
                  } else {
                     digitValue.insert(0, thaiDigit[charVal - 48]);
                  }
               }
            }
         }

         return digitValue.toString();
      }
   }
}
