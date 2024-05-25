<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String orders_no = request.getParameter("orders_no");
		String year = request.getParameter("year");
		ResultSet rs = stmt.executeQuery("select o.orders_date,c.company_name,c.name,e.first_name,e.last_name,o.next_date,o.total_discount,o.comment,o.pay,o.pay_type,o.pay_date,o.pay_detail from orders o,client c,employee e where o.client_id=c.client_id and o.employee_id=e.employee_id and  orders_no='"+orders_no+"' and year='"+year+"'");
		rs.next();
		String orders_date = rs.getString(1);
		String orders_date_show="";
		try{
			orders_date_show = orders_date.substring(6,8)+"/"+orders_date.substring(4,6)+"/"+orders_date.substring(0,4);
		}catch(Exception e){}
		String company_name = rs.getString(2)+"-->"+rs.getString(3);
		String name = rs.getString(4)+"  "+rs.getString(5);
		String next_date = rs.getString(6);
		String next_date_show="";
		try{
			next_date_show = next_date.substring(6,8)+"/"+next_date.substring(4,6)+"/"+next_date.substring(0,4);
		}catch(Exception e){}		
		float total = rs.getFloat(7);
		String comment = rs.getString(8);
		String pay = rs.getString(9);
		String pay_name="";
		if(pay.equals("Y")){
			pay_name = "จ่ายแล้ว";
		}else{
			pay_name = "ยังไม่จ่าย";
		}
		String pay_type = rs.getString(10);
		String pay_type_name="";
		if(pay_type.equals("L")){
			pay_type_name = "จ่ายสด";
		}else if(pay_type.equals("I")){
			pay_type_name = "โอนเงิน";
		}else if(pay_type.equals("C")){
			pay_type_name = "จ่ายเช็ค";
		}
		String pay_date = rs.getString(11);
		String pay_date_show="";
		try{
			pay_date_show = pay_date.substring(6,8)+"/"+pay_date.substring(4,6)+"/"+pay_date.substring(0,4);
		}catch(Exception e){}
		String pay_detail = rs.getString(12);
		float total_amount = 0;
		rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<title>รายละเอียดใบขายสินค้า</title>
<script language="JavaScript">
	function cancel(){  
 		history.back();
	}
</script>
</head>
<body>
<font  class="f1" >รายละเอียดใบขายสินค้า</font><br>
<form name="form1" method="post"  >
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr0">
		<td align="right" width="30%">เลขที่ใบขายสินค้า</td>
		<td><%=orders_no%>/<%=year%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1" width="30%">ใบสั่งซื้อลงวันที่</td>
		<td><%=orders_date_show%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชื่อลูกค้า</td>
		<td><%=company_name%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ชื่อพนักงาน</td>
		<td><%=name%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1" width="30%">วันที่นัดพบครั้งต่อไป</td>
		<td><%=next_date_show%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><%=comment%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">การจ่ายเงิน</td>
		<td><%=pay_name%></td>
	</tr>
<tr class="tr1">
		<td align="right" class="h1">รูปแบบการจ่ายเงิน</td>
		<td><%=pay_type_name%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">วันที่จ่ายเงิน</td>
		<td><%=pay_date_show%> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รายละเอียดการจ่ายเงิน</td>
		<td><%=pay_detail%> </td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" >จำนวน</td>
		<td align="center" >รายการสินค้า</td>
		<td align="center" >ราคาขาย</td>
		<td align="center" >จำนวนเงิน</td>
		<td align="center" >--></td>
		<td align="center" >เลขที่ใบสั่งซื้อ</td>
		<td align="center" >จำนวน</td>
		<td align="center" >ราคาซื้อ</td>
		<td align="center" >จำนวนเงิน</td>
	</tr>
<%	
		ResultSet rs1 = stmt.executeQuery("select count(*) from orders_detail o,good g where o.good_id=g.good_id and  orders_no='"+orders_no+"' and year='"+year+"'");
		rs1.next();
		int counter = rs1.getInt(1);
		rs1.close();
		rs = stmt.executeQuery("select g.good_id, g.name,o.quantity,o.sale,o.amount,o.sale_unit,g.unit_low,g.unit_high,g.rate from orders_detail o,good g where o.good_id=g.good_id and  orders_no='"+orders_no+"' and year='"+year+"'");
		String[] good_id = new String[counter];
		String[] good_name = new String[counter];
		float[] quantity = new float[counter];
		float[] unit_price = new float[counter];
		float[] amount = new float[counter];
		String[] price_unit = new String[counter];
		String[] unit_low = new String[counter];
		String[] unit_high = new String[counter];
		float[] rate = new float[counter];	
		int i=-1;
		while(rs.next()){
			i=i+1;
			good_id[i] = rs.getString(1);
			good_name[i] = rs.getString(2);
			quantity[i] = rs.getFloat(3);
			unit_price[i] = rs.getFloat(4);
			amount[i] = rs.getFloat(5);
			price_unit[i] = rs.getString(6);
			unit_low[i] = rs.getString(7);
			unit_high[i] = rs.getString(8);
			rate[i] = rs.getFloat(9);
		}
		if	(good_id != null && good_id.length > 0) {
			for(int k=0; k<good_id.length; k++){
				String price_unit_name="";
				if(price_unit[k].equals("1")){
					price_unit_name = unit_low[k];
				}else{
					price_unit_name = unit_high[k];
				}
%>
	<tr class="tr2" >
		<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity[k]),"#,##0.0")%> <%=price_unit_name%></td>
		<td align="left" ><%=good_name[k]%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(unit_price[k]),"#,##0.00")%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(amount[k]),"#,##0.00")%></td>
		<td colspan="5"></td>
<%
				rs = stmt.executeQuery("select s.mate_no, s.year, md.price, s.quantity, 'mate_no',md.price_unit from stock_mate s, material_detail md where s.mate_no = md.mate_no and s.year = md.year and s.good_id = md.good_id and s.orders_no_year = '"+orders_no+"/"+year+"' and s.good_id='"+good_id[k]+"' union all select s.trans_no, s.year, md.price, s.quantity,'trans_no',md.price_unit from stock_tran s, trans_detail md where s.trans_no = md.trans_no and s.year = md.year and s.good_id = md.good_id and s.orders_no_year = concat('"+orders_no+"','/','"+year+"') and s.good_id='"+good_id[k]+"'");
				while(rs.next()){
					String mate_no1 = rs.getString(1);
					String year1 = rs.getString(2);
					float unit_price1 = rs.getFloat(3);
					float quantity1 = rs.getFloat(4);				
					String type1 = rs.getString(5);
					String price_unit1 = rs.getString(6);
					String price_unit_name1="";
					if(price_unit1.equals("1")){
						price_unit_name1 = unit_low[k];
					}else{
						price_unit_name1 = unit_high[k];
					}		
					float unit_price_low=0;
					if(price_unit1.equals(price_unit[k])){
						unit_price_low=unit_price1;
					}else{
						unit_price_low=unit_price1/rate[k];
					}
					float total1 = quantity1*unit_price_low;
					total_amount = total_amount+total1;		
%>
	<tr class="tr1" >
		<td colspan="5"></td>
		<td align="left" ><%=type1%>  <%=mate_no1%>/<%=year1%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity1),"#,##0.0")%> <%=price_unit_name1%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(unit_price_low),"#,##0")%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(total1),"#,##0.00")%></td>
	</tr>
<%
				}
			}
		}
%>
	<tr class="tr0" >
		<td align="right" colspan="3">ขายรวมเงิน</td>
		<td align="right"><%=convertcomma.dtoa(Float.toString(total),"#,##0.00")%></td>
		<td align="center" colspan="2">ส่วนต่างรวมเงิน <%=convertcomma.dtoa(Float.toString(total-total_amount),"#,##0.00")%></td>
		<td align="right" colspan="2">ทุนรวมเงิน</td>
		<td align="right"><%=convertcomma.dtoa(Float.toString(total_amount),"#,##0.00")%></td>
	</tr>
	<tr>
		<td align="center" colspan="9">
			<input type= "button"  name="sm1" value="    ยกเลิก   " class="butt" onclick="cancel()">
		</td>
	</tr>
</table>
</form>
</body>
</html>

<%
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
