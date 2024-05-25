<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>
<%@ page import="org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*" %>

<%   
    POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream("e:/csf/jsp/horoscope/world.xls"));
	HSSFWorkbook wb = new HSSFWorkbook(fs);
	HSSFSheet sheet = null;
	HSSFRow row = null;HSSFCell cell = null;HSSFRow row1 = null;HSSFCell cell1 = null;
	HSSFRow row2 = null;HSSFCell cell2 = null;HSSFRow row3 = null;HSSFCell cell3 = null;

	String zodiac0 = request.getParameter("zodiac0"); 
	String zodiac1 = request.getParameter("zodiac1");
	String zodiac2 = request.getParameter("zodiac2");
	String zodiac3 = request.getParameter("zodiac3");
	String zodiac4 = request.getParameter("zodiac4");
	String zodiac5 = request.getParameter("zodiac5");
	String  zodiac6 = request.getParameter("zodiac6"); 
	String zodiac7 = request.getParameter("zodiac7");
	String zodiac8 = request.getParameter("zodiac8");
	String zodiac9 = request.getParameter("zodiac9");
	String zodiac10 = request.getParameter("zodiac10");
	String zodiac11 = request.getParameter("zodiac11");
	String day = request.getParameter("day");//วันเกิด
	String[] zodiac = {zodiac0,zodiac1,zodiac2,zodiac3,zodiac4,zodiac5,zodiac6,zodiac7,zodiac8,zodiac9,zodiac10,zodiac11}; //ราศี 0-11
	
	String[] star= new String[11];//ดาว 0-9 ล
	for(int k=0;k<12;k++){
		int counts = zodiac[k].length();
		if ((zodiac[k] == null) || (counts ==0)){
		}else{ 
			for(int i=1;i<=counts;i++){
				String cutkey = zodiac[k].substring(i-1,i);
				if (cutkey.equals("0")){
					star[0] = Integer.toString(k);
				}else if(cutkey.equals("1")){
					star[1] = Integer.toString(k);
				}else if(cutkey.equals("2")){
					star[2] = Integer.toString(k);
				}else if(cutkey.equals("3")){
					star[3] = Integer.toString(k);
				}else if(cutkey.equals("4")){
					star[4] = Integer.toString(k);
				}else if(cutkey.equals("5")){
					star[5] = Integer.toString(k);
				}else if(cutkey.equals("6")){
					star[6] = Integer.toString(k);
				}else if(cutkey.equals("7")){
					star[7] = Integer.toString(k);
				}else if(cutkey.equals("8")){
					star[8] = Integer.toString(k);
				}else if(cutkey.equals("9")){
					star[9] = Integer.toString(k);
				}else if(cutkey.equals("A")){
					star[10] = Integer.toString(k);
				}
			}
		}
	}
	out.println("starA="+star[10]+"star1="+star[1]+"star2="+star[2]+"star3="+star[3]+"star4="+star[4]+"star5="+star[5]+"star6="+star[6]+"star7="+star[7]+"star8="+star[8]+"star9="+star[9]+"star0="+star[0]);	
		
	String[] world_aspect = new String[12];//ภพของลัคนา	
	world_aspect[0]=star[10];
	int counter = Integer.parseInt(star[10]);
	for(int k=1;k<12;k++){
		if(counter==11){
			counter = 0;
		}else{
			counter = counter+1;
		}
		world_aspect[k]= Integer.toString(counter);
	}
	out.println("world_aspect0="+world_aspect[0]+"world_aspect1="+world_aspect[1]+"world_aspect2="+world_aspect[2]+"world_aspect3="+world_aspect[3]+"world_aspect4="+world_aspect[4]+"world_aspect5="+world_aspect[5]+"world_aspect6="+world_aspect[6]+"world_aspect7="+world_aspect[7]+"world_aspect8="+world_aspect[8]+"world_aspect9="+world_aspect[9]+"world_aspect10="+world_aspect[10]+"world_aspect11="+world_aspect[11]);	
	
	String[] kaset = {"3","6","4","2","1","4","6","3","5","7","8","5"}; //ดาวเกษตร 0

	String[] world_aspect_result = new String[12];//ภพพยากรณ์	
	for(int k=0;k<12;k++){
		String result = star[Integer.parseInt(kaset[Integer.parseInt(world_aspect[k])])];
		for(int i=0;i<12;i++){
			if(result.equals(world_aspect[i])){
				world_aspect_result[k] = Integer.toString(i);
				break;
			}
		}
	}

	String starA_fraction_result = ""; //ตนุเศษ
	int start = Integer.parseInt(star[10]);
	int middle = Integer.parseInt(star[Integer.parseInt(kaset[start])]);
	int end = Integer.parseInt(star[Integer.parseInt(kaset[middle])]);
	int num1=0;int num2=0;
	if(middle-start <0){
		num1 = (12-(start-middle))+1;
	}else{
		num1 = (middle-start)+1;
	}
	if(end-middle <0){
		num2 = (12-(middle-end))+1;
	}else{
		num2 = (end-middle)+1;
	}
	starA_fraction_result = Integer.toString((num1*num2) % 7);
	if(starA_fraction_result.equals("0")){
		starA_fraction_result="7";
	}
	
	out.println("num1="+num1+"num2="+num2+"starA_fraction_result="+starA_fraction_result);

	String world_aspect_starA_fraction_result = ""; //ภพของตนุเศษ
	for(int i=0;i<12;i++){
		if(star[Integer.parseInt(starA_fraction_result)].equals(world_aspect[i])){
			world_aspect_starA_fraction_result = Integer.toString(i);
			break;
		}
	}

	out.println("world_aspect_starA_fraction_result="+world_aspect_starA_fraction_result);

	String starA_zodiac = star[10];//บุคคลประจำราศี

	out.println("starA_zodiac="+starA_zodiac);

	String[][]  relate_star = new String[20][3];//การสัมพันธ์ของดาว
	int count=-1;
	for(int k=1;k<9;k++){
		for(int i=1;((i<9) && (k!=i));i++){
			if(star[k].equals(star[i])){
				int world=0;
				for(int m=0;m<12;m++){
					if(world_aspect[m].equals(star[k])){
						world=m;
						break;
					}
				}
				count = count+1;
				relate_star[count][0] = Integer.toString(k);
				relate_star[count][1] = Integer.toString(i);
				relate_star[count][2] = Integer.toString(world);
			}
		}
	}

	String[] dot = {"6","3","5","7","8","5","3","6","4","2","1","4"};//ประ 1
	String[] great_stop = {"1","2","","5","","4","7","8","","3","","6"};//มหาอุจ 2
	String[] great_stop_front = {"6","1","2","","5","","4","7","8","","3",""};//อุจจาภิมุข 3
	String[] great_stop_back = {"2","","5","","4","7","8","","3","","6","1"};//อุจจาวิลาศ 4
	String[] constantly = {"7","8","","3","","6","1","2","","5","","4"};//นิจ 5
	String[] king_luck = {"5","3","1","6","4","2","8","7","","","",""};//ราชาโชค 6
	String[] angel_luck = {"8","7","","","","","5","3","1","6","4","2"};//เทวีโชค 7
	String[] great_circle = {"2","7","","1","4","3","","5","6","8","",""};//มหาจักร 8
	String[]  micro_circle = {"","5","6","8","","","2","7","","1","4","3"};//จุลจักร 9

	String[][] star_standard = new String[9][12];//ดวงมาตราฐาน
	for(int k=1;k<9;k++){
		if(Integer.toString(k).equals(kaset[Integer.parseInt(star[k])])){
			star_standard[k][0] = "เกษตร แสดงภาคพื้น";
		}
		if(Integer.toString(k).equals(dot[Integer.parseInt(star[k])])){
			star_standard[k][1] = "ประ แสดงภาคพื้น";
		}
		if(Integer.toString(k).equals(great_stop[Integer.parseInt(star[k])])){
			star_standard[k][2] = "มหาอุจ แสดงวาสนา";
		}
		if(Integer.toString(k).equals(great_stop_front[Integer.parseInt(star[k])])){
			star_standard[k][3] = "อุจจาภิมุข";
		}
		if(Integer.toString(k).equals(great_stop_back[Integer.parseInt(star[k])])){
			star_standard[k][4] = "อุจจาวิลาศ แสดงความสง่าหรือเป็นที่นิยม";
		}
		if(Integer.toString(k).equals(constantly[Integer.parseInt(star[k])])){
			star_standard[k][5] = "นิจ แสดงวาสนา";
		}
		if(Integer.toString(k).equals(king_luck[Integer.parseInt(star[k])])){
			star_standard[k][6] = "ราชาโชค แสดงความสง่าหรือเป็นที่นิยม";
		}
		if(Integer.toString(k).equals(angel_luck[Integer.parseInt(star[k])])){
			star_standard[k][7] = "เทวีโชค";
		}
		if(Integer.toString(k).equals(great_circle[Integer.parseInt(star[k])])){
			star_standard[k][8] = "มหาจักร แสดงความโลดโผน";
		}
		if(Integer.toString(k).equals(micro_circle[Integer.parseInt(star[k])])){
			star_standard[k][9] = "จุลจักร";
		}
	}

	String[] south = {"1","2","3","4","7","5","8","6"};//ทักษา 10
	String[] south_name = {"บริวาร","อายุ","เดช","ศรี","มูละ","อุสาหะ","มนตรี","กาลกิณี"};//ชื่อทักษา
	String[] south_result = new String[8];//ทักษาของเจ้าชะตา
	south_result[0] = day;
	int begin=0;
	for(int k=0;k<8;k++){
		if(day.equals(south[k])){
			begin = k;
			break;
		}
	}
	for(int i=1;i<8;i++){	
		begin = begin+1;
		if(begin==8){
			begin=0;
		}
		south_result[i]=south[begin];
	}
	for(int i=0;i<8;i++){	
		star_standard[Integer.parseInt(south_result[i])][10] = south_name[i];
	}

	String criterion = " ";//เกณฑ์ 11 แสดงความถาวร
	if(star[10].equals("0") || star[10].equals("1") || star[10].equals("4")){//ปัสวะเกณฑ์
		if(star[1].equals(world_aspect[9])){star_standard[1][11] = "ปัสวะเกณฑ์ องค์เกณฑ์";}
		if(star[2].equals(world_aspect[9])){star_standard[2][11] = "ปัสวะเกณฑ์ องค์เกณฑ์";}
		if(star[3].equals(world_aspect[9])){star_standard[3][11] = "ปัสวะเกณฑ์ องค์เกณฑ์";}
		if(star[5].equals(world_aspect[9])){star_standard[5][11] = "ปัสวะเกณฑ์ องค์เกณฑ์";}
		if(star[1].equals(world_aspect[5]) || star[1].equals(world_aspect[9])){star_standard[1][11] = "ปัสวะเกณฑ์ อุดมเกณฑ์";}		
		if(star[2].equals(world_aspect[5]) || star[2].equals(world_aspect[9])){star_standard[2][11] = "ปัสวะเกณฑ์ อุดมเกณฑ์";}
		if(star[3].equals(world_aspect[5]) || star[3].equals(world_aspect[9])){star_standard[3][11] = "ปัสวะเกณฑ์ อุดมเกณฑ์";}
		if(star[6].equals(world_aspect[5]) || star[6].equals(world_aspect[9])){star_standard[6][11] = "ปัสวะเกณฑ์ อุดมเกณฑ์";}		
	}else if(star[10].equals("2") || star[10].equals("5") || star[10].equals("6") || star[10].equals("8") || star[10].equals("10")){//นระเกณฑ์
		if(star[1].equals(world_aspect[0])){star_standard[1][11] = "นระเกณฑ์ องค์เกณฑ์";}
		if(star[5].equals(world_aspect[0])){star_standard[5][11] = "นระเกณฑ์ องค์เกณฑ์";}
		if(star[7].equals(world_aspect[0])){star_standard[7][11] = "นระเกณฑ์ องค์เกณฑ์";}
		if(star[4].equals(world_aspect[0]) || star[4].equals(world_aspect[2]) || star[4].equals(world_aspect[3]) || star[4].equals(world_aspect[6]) || star[4].equals(world_aspect[10])){star_standard[4][11] = "นระเกณฑ์ อุดมเกณฑ์";}		
		if(star[5].equals(world_aspect[0]) || star[5].equals(world_aspect[2]) || star[5].equals(world_aspect[3]) || star[5].equals(world_aspect[6]) || star[5].equals(world_aspect[10])){star_standard[5][11] = "นระเกณฑ์ อุดมเกณฑ์";}		
		if(star[6].equals(world_aspect[0]) || star[6].equals(world_aspect[2]) || star[6].equals(world_aspect[3]) || star[6].equals(world_aspect[6]) || star[6].equals(world_aspect[10])){star_standard[6][11] = "นระเกณฑ์ อุดมเกณฑ์";}		
		if(star[7].equals(world_aspect[0]) || star[7].equals(world_aspect[2]) || star[7].equals(world_aspect[3]) || star[7].equals(world_aspect[6]) || star[7].equals(world_aspect[10])){star_standard[7][11] = "นระเกณฑ์ อุดมเกณฑ์";}		
	}else if(star[10].equals("3") || star[10].equals("9") || star[10].equals("11")){//อำพุเกณฑ์
		if(star[2].equals(world_aspect[3])){star_standard[2][11] = "อำพุเกณฑ์ องค์เกณฑ์";}
		if(star[4].equals(world_aspect[3])){star_standard[4][11] = "อำพุเกณฑ์ องค์เกณฑ์";}
		if(star[5].equals(world_aspect[3])){star_standard[5][11] = "อำพุเกณฑ์ องค์เกณฑ์";}
		if(star[6].equals(world_aspect[3])){star_standard[6][11] = "อำพุเกณฑ์ องค์เกณฑ์";}
		if(star[3].equals(world_aspect[3]) || star[3].equals(world_aspect[4]) || star[3].equals(world_aspect[8])){star_standard[3][11] = "อำพุเกณฑ์ อุดมเกณฑ์";}		
		if(star[5].equals(world_aspect[3]) || star[5].equals(world_aspect[4]) || star[5].equals(world_aspect[8])){star_standard[5][11] = "อำพุเกณฑ์ อุดมเกณฑ์";}
		if(star[7].equals(world_aspect[3]) || star[7].equals(world_aspect[4]) || star[7].equals(world_aspect[8])){star_standard[7][11] = "อำพุเกณฑ์ อุดมเกณฑ์";}
		if(star[8].equals(world_aspect[3]) || star[8].equals(world_aspect[4]) || star[8].equals(world_aspect[8])){star_standard[8][11] = "อำพุเกณฑ์ อุดมเกณฑ์";}
	}else if(star[10].equals("7")){//กีฎะเกณฑ์
		if(star[1].equals(world_aspect[9])){star_standard[1][11] = "กีฎะเกณฑ์ องค์เกณฑ์";}
		if(star[2].equals(world_aspect[9])){star_standard[2][11] = "กีฎะเกณฑ์ องค์เกณฑ์";}
		if(star[3].equals(world_aspect[9])){star_standard[3][11] = "กีฎะเกณฑ์ องค์เกณฑ์";}
		if(star[5].equals(world_aspect[9])){star_standard[5][11] = "กีฎะเกณฑ์ องค์เกณฑ์";}
		if(star[1].equals(world_aspect[5]) || star[1].equals(world_aspect[9])){star_standard[1][11] = "กีฎะเกณฑ์ อุดมเกณฑ์";}		
		if(star[2].equals(world_aspect[5]) || star[2].equals(world_aspect[9])){star_standard[2][11] = "กีฎะเกณฑ์ อุดมเกณฑ์";}		
		if(star[3].equals(world_aspect[5]) || star[3].equals(world_aspect[9])){star_standard[3][11] = "กีฎะเกณฑ์ อุดมเกณฑ์";}		
		if(star[6].equals(world_aspect[5]) || star[6].equals(world_aspect[9])){star_standard[6][11] = "กีฎะเกณฑ์ อุดมเกณฑ์";}		
	}

//ตรีโกณ แสดงหลัก
%>

<html>
<body><head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
</head>
<font  class="f1" >ดูดวง</font><br><br>
    <table align="center" background="pookduang.gif" width="225" height="220">
      <tr> 
        <td height="42" width="37">&nbsp;</td>
        <td height="42" width="29">&nbsp;</td>
        <td height="42" width="31">&nbsp;</td>
        <td height="42" width="34">&nbsp;</td>
        <td height="42" width="31">&nbsp;</td>
        <td height="42" width="30">&nbsp;</td>
        <td height="42" width="36">&nbsp;</td>
      </tr>
      <tr> 
        <td width="37" height="25"></td>
        <td width="29" height="25"></td>
        <td width="31" height="25" valign="top"> 
          <div align="center" class="f1"><%=zodiac[1]%></div>
        </td>
        <td width="34" height="25" valign="top"> 
          <div align="center" class="f1"><%=zodiac[0]%></div>
        </td>
        <td width="31" height="25" valign="top"> 
          <div align="center"class="f1"><%=zodiac[11]%></div>
        </td>
        <td width="30" height="25"></td>
        <td width="36" height="25"></td>
      </tr>
      <tr> 
        <td width="37" height="32"></td>
        <td width="29" height="32" valign="middle"> 
          <div align="center"class="f1"><%=zodiac[2]%></div>
        </td>
        <td width="31" height="32"></td>
        <td width="34" height="32"></td>
        <td width="31" height="32"></td>
        <td width="30" height="32" valign="middle"> 
          <div align="center"class="f1"><%=zodiac[10]%></div>
        </td>
        <td width="36" height="32"></td>
      </tr>
      <tr> 
        <td width="37" height="29"></td>
        <td width="29" height="29" valign="middle"> 
          <div align="center" class="f1"><%=zodiac[3]%></div>
        </td>
        <td width="31" height="29"></td>
        <td width="34" height="29"></td>
        <td width="31" height="29"></td>
        <td width="30" height="29" valign="middle"> 
          <div align="center"class="f1"><%=zodiac[9]%></div>
        </td>
        <td width="36" height="29"></td>
      </tr>
      <tr> 
        <td width="37" height="30"></td>
        <td width="29" height="30" valign="middle"> 
          <div align="center"class="f1"><%=zodiac[4]%></div>
        </td>
        <td width="31" height="30"></td>
        <td width="34" height="30"></td>
        <td width="31" height="30"></td>
        <td width="30" height="30" valign="middle"> 
          <div align="center"class="f1"><%=zodiac[8]%></div>
        </td>
        <td width="36" height="30"></td>
      </tr>
      <tr> 
        <td width="37" height="30"></td>
        <td width="29" height="30"></td>
        <td width="31" height="30" valign="top"> 
          <div align="center"class="f1"><%=zodiac[5]%></div>
        </td>
        <td width="34" height="30" valign="top"> 
          <div align="center"class="f1"><%=zodiac[6]%></div>
        </td>
        <td width="31" height="30" valign="top"> 
          <div align="center"class="f1"><%=zodiac[7]%></div>
        </td>
        <td width="30" height="30"></td>
        <td width="36" height="30"></td>
      </tr>
      <tr> 
        <td height="20" width="37"></td>
        <td height="20" width="29"></td>
        <td height="20" width="31"></td>
        <td height="20" width="34"></td>
        <td height="20" width="31"></td>
        <td height="20" width="30"></td>
        <td height="20" width="36"></td>
      </tr>
    </table>
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr0">
		<td align="center" width="20%">ภพพยากรณ์</td>
		<td align="center">แสดงพื้นชะตาทั่วไป</td>
	</tr>
<%
	sheet = wb.getSheetAt(0);
	for(int i=0;i<12;i++){
		row1 = sheet.getRow(13);
		cell1 = row1.getCell((short)i);
		row2 = sheet.getRow(13);
		cell2 = row2.getCell((short)Integer.parseInt(world_aspect_result[i]));
		row = sheet.getRow(i);
		cell = row.getCell((short)Integer.parseInt(world_aspect_result[i]));		
		String background="";
		int bar = i%2;
		if(bar==0){
			background = "tr1";
		} else background = "tr2";
%>
	<tr class="<%=background%>">
		<td align="left" class="h1"><%=cell1.getStringCellValue()%>---><%=cell2.getStringCellValue()%></td>
		<td><%=cell.getStringCellValue()%></td>
	</tr>
<%
	}
%>
	<tr class="tr0">
		<td align="center">ตนุเศษ</td>
		<td align="center">แสดงอารมณ์ของเจ้าชะตา นิสัยใจคอ</td>
	</tr>
<%
    sheet = wb.getSheetAt(1);
	row1 = sheet.getRow(Integer.parseInt(starA_fraction_result));
	cell1 = row1.getCell((short)0);
	row2 = sheet.getRow(Integer.parseInt(starA_fraction_result)); 
	cell2 = row2.getCell((short)1);
%>
	<tr class="tr1">
		<td align="left" class="h1"><%=cell1.getStringCellValue()%></td>
		<td><%=cell2.getStringCellValue()%></td>
	</tr>
	<tr class="tr0">
		<td align="center">ภพของตนุเศษ</td>
		<td align="center">แสดงความรู้สึกนึกคิดที่มีต่อเหตุการณ์ทที่เกิดขึ้น</td>
	</tr>
<%
    sheet = wb.getSheetAt(0);
	row1 = sheet.getRow(13);
	cell1 = row1.getCell((short)Integer.parseInt(world_aspect_starA_fraction_result));
	row2 = sheet.getRow(15);
	cell2 = row2.getCell((short)Integer.parseInt(world_aspect_starA_fraction_result));		
%>
	<tr class="tr1">
		<td align="left" class="h1"><%=cell1.getStringCellValue()%></td>
		<td><%=cell2.getStringCellValue()%></td>
	</tr>
	<tr class="tr0">
		<td align="center">บุคคลประจำราศี</td>
		<td align="center">รูปร่าง นิสีย ส่วนของร่างกาย</td>
	</tr>
<%
    sheet = wb.getSheetAt(2);
	row = sheet.getRow(Integer.parseInt(starA_zodiac));
	cell = row.getCell((short)0);
	row1 = sheet.getRow(Integer.parseInt(starA_zodiac));
	cell1 = row1.getCell((short)1);
	row2 = sheet.getRow(Integer.parseInt(starA_zodiac));
	cell2 = row2.getCell((short)2);
	row3 = sheet.getRow(Integer.parseInt(starA_zodiac));
	cell3 = row3.getCell((short)3);
%>
	<tr class="tr1">
		<td align="left" class="h1"><%=cell.getStringCellValue()%></td>
		<td><%=cell2.getStringCellValue()%>  <%=cell3.getStringCellValue()%> <%=cell1.getStringCellValue()%> </td>
	</tr>
	<tr class="tr0">
		<td align="center">การสัมพันธ์ของดาว</td>
		<td align="center"></td>
	</tr>
<%
	for(int i=0;((i<relate_star.length) && (relate_star[i][0]!=null));i++){
		sheet = wb.getSheetAt(0);
		row1 = sheet.getRow(13);
		cell1 = row1.getCell((short)Integer.parseInt(relate_star[i][2]));
		sheet = wb.getSheetAt(4);
		row = sheet.getRow(Integer.parseInt(relate_star[i][0]));
		cell = row.getCell((short)Integer.parseInt(relate_star[i][1]));
		String background="";
		int bar = i%2;
		if(bar==0){
			background = "tr1";
		} else background = "tr2";
%>
	<tr class="<%=background%>">
		<td align="left" class="h1"><%=relate_star[i][0]%><%=relate_star[i][1]%> --> <%=cell1.getStringCellValue()%></td>
		<td><%=cell.getStringCellValue()%></td>
	</tr>
<%
	}	
%>
	<tr class="tr0">
		<td align="center">ดาวมาตราฐาน</td>
		<td align="center"></td>
	</tr>
<%
	for(int k=1;k<9;k++){		
		String data="";
		for(int i=0;i<10;i++){		
			if(star_standard[k][i]==null){
			}else{
				data = data.concat(star_standard[k][i]+" ");
			}
		}
		if(star_standard[k][11]==null){star_standard[k][11]="";}
		String background="";
		int bar = (k-1)%2;
		if(bar==0){
			background = "tr1";
		} else background = "tr2";
%>
	<tr class="<%=background%>">
		<td align="left" class="h1"><%=k%> <%=star_standard[k][10]%> <%=star_standard[k][11]%></td>
		<td><%=data%></td>
	</tr>
<%
	}	
%>
</table>
</body>
</html>
