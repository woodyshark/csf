<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>
<%@ page import="org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*" %>

<%
	SQLManager myman = SQLManager.getInstance();
	Connection con = myman.requestConnection("csf");  
	String file_name = "";String client_id="";
	try {
		Statement stmt = con.createStatement();
		String meet_date = request.getParameter("meet_date"); 
		String[] mon={"มกราคม","กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน","กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม"};
		String meet_date_show="";
		try{
			meet_date_show = "วันที่ "+meet_date.substring(6,8)+" "+mon[Integer.parseInt(meet_date.substring(4,6))-1]+" "+meet_date.substring(0,4);
		}catch(Exception e){}
		client_id = request.getParameter("client_id");
		ResultSet rs = stmt.executeQuery("select name from client where client_id='"+client_id+"'");
		rs.next();
		String client_name = rs.getString(1);
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();	
		HSSFFont font = wb.createFont();
		font.setFontHeightInPoints((short)14);
		font.setFontName("AngsanaUPC");
		// Fonts are set into a style so create a new one to use.
		HSSFCellStyle style = wb.createCellStyle();
		style.setFont(font);
		HSSFRow row = sheet.createRow((short)0);
		HSSFCell cell = row.createCell((short)0);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("ใบสั่งสินค้า    "+client_name);
		sheet.setColumnWidth((short) 0, (short) ((30 * 8) / ((double) 1 / 20)));
		cell.setCellStyle(style);
		row = sheet.createRow((short)0);
		cell = row.createCell((short)3);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue(meet_date_show);
		sheet.setColumnWidth((short) 3, (short) ((30 * 8) / ((double) 1 / 20)));
		cell.setCellStyle(style);
		row = sheet.createRow((short)1);
		cell = row.createCell((short)0);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("ชื่อสินค้า");
		sheet.setColumnWidth((short) 0, (short) ((30 * 8) / ((double) 1 / 20)));
		cell.setCellStyle(style);
		cell = row.createCell((short)1);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("ขนาดบรรจุ");
		sheet.setColumnWidth((short) 1, (short) ((30 * 8) / ((double) 1 / 20)));
		cell.setCellStyle(style);
		cell = row.createCell((short)2);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("ราคาสินค้า");
		sheet.setColumnWidth((short) 2, (short) ((30 * 8) / ((double) 1 / 20)));
		cell.setCellStyle(style);
		cell = row.createCell((short)3);
		cell.setEncoding(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue("จำนวน");
		sheet.setColumnWidth((short) 3, (short) ((30 * 8) / ((double) 1 / 20)));
		cell.setCellStyle(style);
		int i=2;
		if(request.getParameter("del") != null){
			String[] good_id= request.getParameterValues("del");
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					String name = request.getParameter("name"+good_id[k]);
					String sale_unit = request.getParameter("sale_unit"+good_id[k]);
					String sale_low = request.getParameter("sale_low"+good_id[k]);
					String sale_high = request.getParameter("sale_high"+good_id[k]);
					String unit_low = request.getParameter("unit_low"+good_id[k]);
					String unit_high = request.getParameter("unit_high"+good_id[k]);
					String rate = request.getParameter("rate"+good_id[k]);
					String sale="";String unit="";
					if(sale_unit.equals("1")){
						sale = sale_low;
						unit = unit_low;
					}else{
						sale = sale_high;
						unit = unit_high;
					}
					String detail="";
					if(unit_high.equals("")){
					}else{
						detail = rate.concat(" ").concat(unit_low).concat(" ต่อ ").concat(" 1 ").concat(unit_high);
					}
					row = sheet.createRow((short)i);
					cell = row.createCell((short)0);
					cell.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell.setCellValue(name);
					sheet.setColumnWidth((short) 0, (short) ((30 * 8) / ((double) 1 / 20)));
					cell.setCellStyle(style);
					cell = row.createCell((short)1);
					cell.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell.setCellValue(detail);
					sheet.setColumnWidth((short) 1, (short) ((30 * 8) / ((double) 1 / 20)));
					cell.setCellStyle(style);
					cell = row.createCell((short)2);
					cell.setEncoding(HSSFCell.ENCODING_UTF_16);
					cell.setCellValue(sale+" บาท ต่อ "+unit);
					sheet.setColumnWidth((short) 2, (short) ((30 * 8) / ((double) 1 / 20)));
					cell.setCellStyle(style);
					i=i+1;
				}
			}	
		}
		// Write the output to a file
		file_name = "orders_sell"+Math.random() +".xls";
		FileOutputStream fileOut = new FileOutputStream(Config.partdirectory()+file_name);
		wb.write(fileOut);
		fileOut.close();		
		stmt.close();
	}catch(Exception e){out.println(e);} 
	 myman.returnConnection("csf", con);		
 %>

<html>
	<body bgcolor="#FFFFFF">
			<script language="javascript">
					function display() { 
						var dialogUrl ="../document/<%=file_name%>";
						var excel = window.open(dialogUrl,"excel","");
						excel.focus();
						window.location="orders_good.jsp?client_id=<%=client_id%>";
					}
					setTimeout('display()',1000);					
			</script>
	</body>
</html>
