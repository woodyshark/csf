<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>
<%@ page import="org.apache.poi.hssf.usermodel.*,org.apache.poi.poifs.filesystem.*" %>
<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	 String file_name = "";String types="";
	try{
			Statement stmt = con.createStatement();
			types = request.getParameter("type"); if(types==null){types="ALL";}
			String types_name = ""; String where2 ="";
			if(types.equals("ALL")){
				types_name = "ทั้งหมด";
				where2 = " and type like '%' ";
			}else if(types.equals("C")){
				types_name="ลูกค้าขาย";
				where2 = " and type='C' ";
			}else if(types.equals("S")){
				types_name="ลูกค้าซื้อ";
				where2 = " and type='S' ";
			}else if(types.equals("O")){
				types_name="อื่นๆ";
				where2 = " and type='O' ";
			}else if(types.equals("1")){
				types_name="ญาติพี่น้อง";
				where2 = " and type='1' ";
			}else if(types.equals("2")){
				types_name="เพื่อน";
				where2 = " and type='2' ";
			}else if(types.equals("3")){
				types_name="สำนักงานต่างๆ";
				where2 = " and type='3' ";
			}
			ResultSet rs = stmt.executeQuery("select client_id,company_name,name,city,phone,mobile_phone from client where client_id<>0 "+where2+" order by type,city,company_name,name");
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
			cell.setCellValue(types_name);
			sheet.setColumnWidth((short) 0, (short) ((40 * 8) / ((double) 1 / 20)));
			cell.setCellStyle(style);
			int i=1;
			while(rs.next()){
				String client_id = rs.getString(1);
				String company_name = rs.getString(2);
				String name = rs.getString(3);
				String city = rs.getString(4);
				String phone = rs.getString(5);
				String mobile_phone = rs.getString(6);
				row = sheet.createRow((short)i);
				cell = row.createCell((short)0);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellValue(company_name);
				sheet.setColumnWidth((short) 0, (short) ((40 * 8) / ((double) 1 / 20)));
				cell.setCellStyle(style);
				cell = row.createCell((short)1);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellValue(name);
				sheet.setColumnWidth((short) 1, (short) ((35 * 8) / ((double) 1 / 20)));
				cell.setCellStyle(style);
				cell = row.createCell((short)2);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellValue(city);
				sheet.setColumnWidth((short) 2, (short) ((16 * 8) / ((double) 1 / 20)));
				cell.setCellStyle(style);
				cell = row.createCell((short)3);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellValue(phone);
				sheet.setColumnWidth((short) 3, (short) ((20 * 8) / ((double) 1 / 20)));
				cell.setCellStyle(style);
				cell = row.createCell((short)4);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);
				cell.setCellValue(mobile_phone);
				sheet.setColumnWidth((short) 4, (short) ((20 * 8) / ((double) 1 / 20)));
				cell.setCellStyle(style);
				i=i+1;
			}
			// Write the output to a file
			file_name = "client_seach"+Math.random() +".xls";
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
