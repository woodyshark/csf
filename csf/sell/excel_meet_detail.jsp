<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>
<%@ page import="org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*" %>
<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	 String file_name = "";String meet_no="";String year="";
	try{
		Statement stmt = con.createStatement();
		meet_no = request.getParameter("meet_no");
		year = request.getParameter("year");
		ResultSet rs = stmt.executeQuery("select m.meet_date,c.company_name,c.name from meet m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and  meet_no='"+meet_no+"' and year='"+year+"'");
		rs.next();
		String meet_date = rs.getString(1);
		String[] mon={"มกราคม","กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน","กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม"};
		String meet_date_show="";
		try{
			meet_date_show = "วันที่ "+meet_date.substring(6,8)+" "+mon[Integer.parseInt(meet_date.substring(4,6))-1]+" "+meet_date.substring(0,4);
		}catch(Exception e){}
		String company_name = rs.getString(2);
		String name = rs.getString(3);
		rs.close();
		rs = stmt.executeQuery("select count(*) from meet_detail m,good g,good_type t where m.good_id=g.good_id and g.good_type_id=t.good_type_id and  meet_no='"+meet_no+"' and year='"+year+"'");
		rs.next();
		int counter = rs.getInt(1);
		if(counter%2==0){
			counter = counter/2;
		}else{
			counter = (counter/2)+1;
		}
		rs = stmt.executeQuery("select g.name,m.sale,m.sale_unit,g.unit_low,g.unit_high,g.rate from meet_detail m,good g,good_type t where m.good_id=g.good_id and g.good_type_id=t.good_type_id and  meet_no='"+meet_no+"' and year='"+year+"' order by t.name,g.name");
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();	
		HSSFFont font = wb.createFont();
		font.setFontHeightInPoints((short)15);
		font.setFontName("AngsanaUPC");
		// Fonts are set into a style so create a new one to use.
		HSSFCellStyle style = wb.createCellStyle();
		style.setFont(font);
		HSSFRow row = sheet.createRow((short)0);
		HSSFCell cell = row.createCell((short)1);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("                               ใบเสนอราคา");
		cell.setCellStyle(style);
		row = sheet.createRow((short)1);
		cell = row.createCell((short)3);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue(meet_date_show);
		cell.setCellStyle(style);
		row = sheet.createRow((short)2);
		cell = row.createCell((short)0);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("เรียน "+company_name+"   "+name);
		cell.setCellStyle(style);
		row = sheet.createRow((short)3);
		cell = row.createCell((short)0);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("                      ข้าพเจ้ามีความยินดีที่จะเสนอราคาสินค้า ตามรายละเอียดและเงื่อนไขดังต่อไปนี้");
		cell.setCellStyle(style);
		int i=4;int j=0;int k=1;
		String good_name="";String sale="";String sale_unit="";String unit_low="";String unit_high="";String rate="";String sale_unit_name="";String detail="";
		while(rs.next()){
			good_name = rs.getString(1);
			sale = rs.getString(2);
			sale_unit = rs.getString(3);
			unit_low = rs.getString(4);
			unit_high = rs.getString(5);
			rate = rs.getString(6);
			if(sale_unit.equals("1")){
				sale_unit_name = unit_low;
			}else{
				sale_unit_name = unit_high;
			}
			if(unit_high.equals("")){
				detail="";
			}else{
				detail=" ("+convertcomma.dtoa(rate,"#,##0")+" "+unit_low+")";
			}
			row = sheet.createRow((short)i);
			cell = row.createCell((short)j);
			cell.setEncoding(HSSFCell.ENCODING_UTF_16);
			cell.setCellValue(good_name);
			sheet.setColumnWidth((short) j, (short) ((30 * 8) / ((double) 1 / 20)));
			cell.setCellStyle(style);
			cell = row.createCell((short)(j+1));
			cell.setEncoding(HSSFCell.ENCODING_UTF_16);
			cell.setCellValue(convertcomma.dtoa(sale,"#,##0")+" บาท ต่อ "+sale_unit_name+detail);
			sheet.setColumnWidth((short) (j+1), (short) ((35 * 8) / ((double) 1 / 20)));
			cell.setCellStyle(style);
			if(k==counter){
				j=2;i=3;
			}
			k=k+1;
			i=i+1;
		}
		i=i+1;
		row = sheet.createRow((short)i);
		cell = row.createCell((short)0);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("     หวังเป็นอย่างยิ่งที่จะได้รับการพิจารณาการสั่งซื้อจากท่าน ขอขอบพระคุณล่วงหน้ามา ณ โอกาสนี้ด้วย");
		cell.setCellStyle(style);
		i=i+1;
		row = sheet.createRow((short)i);
		cell = row.createCell((short)2);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("ภูมิพัฒน์ 0867656395,034841121");
		cell.setCellStyle(style);
		i=i+1;
		HSSFFont font2 = wb.createFont();
		font2.setFontHeightInPoints((short)10);
		font2.setFontName("AngsanaUPC");
		HSSFCellStyle style2 = wb.createCellStyle();
		style2.setFont(font2);
		row = sheet.createRow((short)i);
		cell = row.createCell((short)0);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("หมายเหตุ ราคาอาจเปลี่ยนแปลงได้โดยไม่แจ้งให้ทราบล่วงหน้า");
		cell.setCellStyle(style2);
		// Write the output to a file
		file_name = "meet_detail"+Math.random() +".xls";
		FileOutputStream fileOut = new FileOutputStream(Config.partdirectory()+file_name);
		wb.write(fileOut);
		fileOut.close();		
		rs.close();
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	

 %>
<html>
	<body bgcolor="#FFFFFF">
			<script language="javascript">
					function display() { 
						window.location = "../document/<%=file_name%>";
					}
					setTimeout('display()',1000);					
			</script>
	</body>
</html>
