<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String keyword="";String status="";String selected1="";String selected2="";String good_id="";String start="";
		String start_dd="";String start_mm="";String start_yy="";String end_dd="";String end_mm="";String end_yy="";
		ResultSet rs=null;String counter="0";String where1="";String where2="";String where3="";
		try{
			keyword = request.getParameter("keyword");
			status = request.getParameter("status"); if(status==null){status="company_name";}
			good_id = request.getParameter("good_id"); if(good_id==null){good_id="all";}
			String keys = keysearch.search(keyword);
			if(status.equals("company_name")){
				selected1 = "selected";
				where1 = " and (c.company_name like '"+keys+"' or c.name like '"+keys+"') "; 
			}else if(status.equals("employee_name")){
				selected2 = "selected";
				where1 = " and e.first_name like '"+keys+"' "; 
			}		
			start_dd = request.getParameter("start_dd"); if(start_dd==null){start_dd="";}
			start_mm = request.getParameter("start_mm"); if(start_mm==null){start_mm="";}
			start_yy = request.getParameter("start_yy"); if(start_yy==null){start_yy="";}	
			end_dd = request.getParameter("end_dd"); if(end_dd==null){end_dd="";}
			end_mm = request.getParameter("end_mm"); if(end_mm==null){end_mm="";}
			end_yy = request.getParameter("end_yy"); if(end_yy==null){end_yy="";}
			where2 = fromtodate.where(start_dd,start_mm,start_yy,end_dd,end_mm,end_yy,"m.mate_date");
			if(good_id.equals("all")){
				where3 = "";
			}else{
				where3 = " and d.good_id like '"+good_id+"' ";
			}
		}catch (Exception e){if(keyword==null){keyword="";start="true";}}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620"><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
</head>
<body> 
<font  class="f1">ค้นหาข้อมูลซื้อวัตถุดิบ-สินค้า</font>
<form action="customer_search.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="center">
				<strong>ค้นหา</strong> <input type="Text" class="txt" size="8" name="keyword" value="<%=keyword%>">
				<strong>โดย</strong> 
				<select name="status" >
					<option value="company_name" <%=selected1%>>ชื่อผู้ผลิต</option>
					<option value="employee_name" <%=selected2%>>ชื่อพนักงาน</option>
				</select> 
				<strong>ชื่อสินค้า</strong>  
				<select name="good_id">
					<option value="all">ทั้งหมด</option>
<%
		rs = stmt.executeQuery("select g.good_id,g.name from good g,good_type t where g.good_type_id=t.good_type_id and g.trans<>'C' order by t.name,g.name");
		while(rs.next()){
			String good_ids = rs.getString(1);
			String names = rs.getString(2);
			String selected="";
			if(good_id.equals(good_ids)){
				selected = "selected";
			}else{
				selected = "";
			}
%>
					<option value="<%=good_ids%>" <%=selected%>><%=names%></option>
<%
		}	
%>
				  </select>
				<strong>ตั้งแต่วันที่</strong> <input type="Text" class="txt" size="2" maxlength="2" name="start_dd" value="<%=start_dd%>"> /  <input type="Text" class="txt" size="2" maxlength="2" name="start_mm" value="<%=start_mm%>"> / <input type="Text" class="txt" size="4" maxlength="4" name="start_yy" value="<%=start_yy%>">  
				<strong>ถึงวันที่</strong> <input type="Text" class="txt" size="2" maxlength="2" name="end_dd" value="<%=end_dd%>"> /  <input type="Text" class="txt" size="2" maxlength="2" name="end_mm" value="<%=end_mm%>"> / <input type="Text" class="txt" size="4" maxlength="4" name="end_yy" value="<%=end_yy%>">
				<input type="submit" value="  ค้นหา  " class="butt">
			</td>
		</tr>	 
	</table>
</form> 
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="12%">เลขที่ใบสั่งซื้อ</td>
		<td align="center"  width="12%">ใบสั่งซื้อลงวันที่</td>
		<td align="center" width="29%">ชื่อผู้ผลิต</td>
		<td align="center" width="14%">ชื่อสินค้า</td>
		<td align="center" width="10%">จำนวน</td>
		<td align="center" width="8%">ราคา</td>
		<td align="center" width="12%">รวมเงิน</td>
	</tr>
<%			
		if(start.equals("true")){
		}else{
//out.print("select d.mate_no,d.year,(select DISTINCT mate_date from material m where m.mate_no=d.mate_no and m.year=d.year),(select DISTINCT company_name from client c,material m where c.client_id=m.client_id and m.mate_no=d.mate_no and m.year=d.year),(select DISTINCT name from client c,material m where c.client_id=m.client_id and m.mate_no=d.mate_no and m.year=d.year),(select DISTINCT name from good where good_id=d.good_id),(select DISTINCT unit_low from good where good_id=d.good_id),(select DISTINCT unit_high from good where good_id=d.good_id),d.quantity,d.price,d.price_unit,d.amount from client c,material_detail d,material m where m.client_id=c.client_id and m.mate_no=d.mate_no and m.year=d.year "+where1+where2+where3+" order by d.year desc,d.mate_no desc");

			rs = stmt.executeQuery("select d.mate_no,d.year,(select DISTINCT mate_date from material m where m.mate_no=d.mate_no and m.year=d.year),(select DISTINCT company_name from client c,material m where c.client_id=m.client_id and m.mate_no=d.mate_no and m.year=d.year),(select DISTINCT name from client c,material m where c.client_id=m.client_id and m.mate_no=d.mate_no and m.year=d.year),(select DISTINCT name from good where good_id=d.good_id),(select DISTINCT unit_low from good where good_id=d.good_id),(select DISTINCT unit_high from good where good_id=d.good_id),d.quantity,d.price,d.price_unit,d.amount from client c,material_detail d,material m where m.client_id=c.client_id and m.mate_no=d.mate_no and m.year=d.year "+where1+where2+where3+" order by d.year desc,d.mate_no desc");
		}
		float total_amount = 0;
		float total_quantity = 0;	
		try{
			int i = -1;
			while(rs.next()){
				i = i+1;
				String mate_no = rs.getString(1);
				String year = rs.getString(2);
				String mate_date = rs.getString(3);
				String mate_date_show="";
				try{
					mate_date_show = mate_date.substring(6,8)+"/"+mate_date.substring(4,6)+"/"+mate_date.substring(0,4);
				}catch(Exception e){}
				String company_name = rs.getString(4)+"-->"+rs.getString(5);
				String good_name = rs.getString(6);
				String unit_low = rs.getString(7);
				String unit_high = rs.getString(8);
				float quantity = rs.getFloat(9);
				total_quantity = total_quantity+quantity;
				float price = rs.getFloat(10);
				String price_unit = rs.getString(11);			
				String price_unit_name="";
				if(price_unit.equals("1")){
					price_unit_name = unit_low;
				}else{
					price_unit_name = unit_high;
				}
				float amount = rs.getFloat(12);
				total_amount = total_amount+amount;
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="center"><%=mate_no%>/<%=year%></Td>
					<td align="center" ><%=mate_date_show%></td>
					<td align="left" ><%=company_name%></td>  
					<td align="left" ><%=good_name%></td>
					<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity),"#,##0.0")%> <%=price_unit_name%></td>  
					<td align="right" ><%=convertcomma.dtoa(Float.toString(price),"#,##0.00")%></td>
					<td align="right" ><%=convertcomma.dtoa(Float.toString(amount),"#,##0.00")%></td>
				</tr>
<%
			}
		}catch (Exception e){}
%>	
		<tr class="tr0" > 
			<td  colspan="4"  ></td>
			<td align="right"><%=convertcomma.dtoa(Float.toString(total_quantity),"#,##0.0")%></td>
			<td></td>
			<td align="right"><%=convertcomma.dtoa(Float.toString(total_amount),"#,##0.00")%></td>
		</tr>
	</table>
</body>
</html>

<%
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
 