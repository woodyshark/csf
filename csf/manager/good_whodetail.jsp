<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();			
		String mate_no = request.getParameter("mate_no");
		String year = request.getParameter("year");
//out.print("select m.mate_date,c.company_name,c.name,e.first_name,e.last_name,m.total_discount,m.comment,m.pay,m.pay_type,m.pay_date,m.pay_detail from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and  mate_no='"+mate_no+"' and year='"+year+"'");	

		ResultSet rs = stmt.executeQuery("select m.mate_date,c.company_name,c.name,e.first_name,e.last_name,m.total_discount,m.comment,m.pay,m.pay_type,m.pay_date,m.pay_detail from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and  mate_no='"+mate_no+"' and year='"+year+"'");	
		rs.next();
		String mate_date = rs.getString(1);
		String mate_date_show="";
		try{
			mate_date_show = mate_date.substring(6,8)+"/"+mate_date.substring(4,6)+"/"+mate_date.substring(0,4);
		}catch(Exception e){}
		String company_name = rs.getString(2)+"-->"+rs.getString(3);
		String name = rs.getString(4)+"  "+rs.getString(5);
		float total = rs.getFloat(6);
		String comment = rs.getString(7);
		String pay = rs.getString(8);
		String pay_name="";
		if(pay.equals("Y")){
			pay_name = "จ่ายแล้ว";
		}else{
			pay_name = "ยังไม่จ่าย";
		}
		String pay_type = rs.getString(9);
		String pay_type_name="";
		if(pay_type.equals("L")){
			pay_type_name = "จ่ายสด";
		}else if(pay_type.equals("I")){
			pay_type_name = "โอนเงิน";
		}else if(pay_type.equals("C")){
			pay_type_name = "จ่ายเช็ค";
		}
		String pay_date = rs.getString(10);
		String pay_date_show="";
		try{
			pay_date_show = pay_date.substring(6,8)+"/"+pay_date.substring(4,6)+"/"+pay_date.substring(0,4);
		}catch(Exception e){}
		String pay_detail = rs.getString(11);
		float total_amount = 0;float total_pay=0;
		rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function cancel(){  
		history.back();
	}
</script>
</head>
<body>
<font  class="f1" >รายละเอียดใบสั่งซื้อวัตถุดิบ-สินค้า</font><br>
<form name="form1" method="post"  >
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr0">
		<td align="right" width="30%">เลขที่ใบสั่งซื้อวัตถุดิบ-สินค้า</td>
		<td><%=mate_no%>/<%=year%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ใบสั่งซื้อลงวันที่</td>
		<td><%=mate_date_show%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชื่อผู้ผลิต</td>
		<td><%=company_name%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ชื่อพนักงาน</td>
		<td><%=name%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><%=comment%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">การจ่ายเงิน</td>
		<td><%=pay_name%></td>
	</tr>
<tr class="tr2">
		<td align="right" class="h1">รูปแบบการจ่ายเงิน</td>
		<td><%=pay_type_name%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">วันที่จ่ายเงิน</td>
		<td><%=pay_date_show%> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">รายละเอียดการจ่ายเงิน</td>
		<td><%=pay_detail%> </td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center">จำนวน</td>
		<td align="center">รายการสินค้า</td>
		<td align="center">ราคาซื้อ</td>
		<td align="center">รวมเงิน</td>
		<td align="center" width="3%">--></td>
		<td align="center">วันที่</td>
		<td align="center">ชื่อลูกค้า</td>
		<td align="center">ราคาขาย</td>
		<td align="center">จำนวน</td>
		<td align="center">รวมเงิน</td>
		<td align="center">การเงิน</td>
	</tr>
<%	
		ResultSet rs1 = stmt.executeQuery("select count(*) from material_detail m,good g where m.good_id=g.good_id and  mate_no='"+mate_no+"' and year='"+year+"'");
		rs1.next();
		int counter = rs1.getInt(1);
		rs1.close();
		
		rs = stmt.executeQuery("select g.good_id,g.name,m.quantity,m.price,m.amount,m.price_unit,g.unit_low,g.unit_high,g.rate from material_detail m,good g where m.good_id=g.good_id and  mate_no='"+mate_no+"' and year='"+year+"'");
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
		<td colspan="6"></td>
	</tr>
	<%
				rs = stmt.executeQuery("select d.quantity,g.name,d.price,d.price_unit from trans_detail d,trans t,good g where d.trans_no=t.trans_no and d.year=t.year and d.good_id=g.good_id and t.good_id='"+good_id[k]+"' and t.mate_no='"+mate_no+"' and t.year_mate='"+year+"'");
				float price2=0;
				while(rs.next()){
					float quantity2 = rs.getFloat(1);
					String name2 = rs.getString(2);
					price2 = rs.getFloat(3);
					String price_unit2 = rs.getString(4);
					String price_unit_name2="";
					if(price_unit2.equals("1")){
						price_unit_name2 = unit_low[k];
					}else{
						price_unit_name2 = unit_high[k];
					}
%>
	<tr class="tr2" >
		<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity2),"#,##0.0")%> <%=price_unit_name2%></td>
		<td align="left" ><%=name2%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(price2),"#,##0.00")%></td>
	</tr>
<%
				}
//out.print("select c.company_name,s.quantity,s.sale,s.out_date,'', o.pay, o.pay_type,s.sale_unit,o.pay_date from stock_mate s,client c,orders o where s.client_id=c.client_id and s.good_id='"+good_id[k]+"' and s.mate_no='"+mate_no+"' and s.year='"+year+"' AND LTRIM(o.orders_no)+ '/' + o.year = s.orders_no_year  union all select c.company_name,s.quantity,s.sale,s.out_date,g.name, o.pay, o.pay_type,s.sale_unit,o.pay_date from stock_tran s,client c,trans t,good g,orders o where s.client_id=c.client_id and s.trans_no=t.trans_no and s.year=t.year and s.good_id=g.good_id and t.quantity='"+quantity[k]+"' and t.good_id='"+good_id[k]+"' and t.mate_no='"+mate_no+"' and t.year_mate='"+year+"' AND LTRIM(o.orders_no)+ '/' + o.year = s.orders_no_year order by s.out_date");

				rs = stmt.executeQuery("(select c.company_name,s.quantity,s.sale,s.out_date as data,'', o.pay, o.pay_type,s.sale_unit,o.pay_date from stock_mate s,client c,orders o where s.client_id=c.client_id and s.good_id='"+good_id[k]+"' and s.mate_no='"+mate_no+"' and s.year='"+year+"' AND concat(trim(o.orders_no),'/',o.year) = s.orders_no_year)  union all (select c.company_name,s.quantity,s.sale,s.out_date as data,g.name, o.pay, o.pay_type,s.sale_unit,o.pay_date from stock_tran s,client c,trans t,good g,orders o where s.client_id=c.client_id and s.trans_no=t.trans_no and s.year=t.year and s.good_id=g.good_id and t.quantity='"+quantity[k]+"' and t.good_id='"+good_id[k]+"' and t.mate_no='"+mate_no+"' and t.year_mate='"+year+"' AND concat(trim(o.orders_no),'/',o.year) = s.orders_no_year)  order by data ASC");
				while(rs.next()){
					String company_name1 = rs.getString(1);
					String quantity1 = rs.getString(2);
					float quantity1_float = Float.parseFloat(quantity1);
					String sale1 = rs.getString(3);
					float sale1_float = Float.parseFloat(sale1);
					String out_date1 = rs.getString(4);
					String out_date1_show="";
					try{
						out_date1_show = out_date1.substring(6,8)+"/"+out_date1.substring(4,6)+"/"+out_date1.substring(0,4);
					}catch(Exception e){}
					String good_name1 = rs.getString(5);
					String pay1 = rs.getString(6);
					String pay_type1 = rs.getString(7);
					String pay_name1="";
					if(pay1.equals("N")){
						pay_name1="";
					}else{
						if(pay_type1.equals("L")){
							pay_name1 = "จ่ายสด";
						}else if(pay_type1.equals("I")){
							pay_name1 = "โอนเงิน";
						}else if(pay_type1.equals("C")){
							pay_name1 = "จ่ายเช็ค";
						}
					}
					String sale_unit1 = rs.getString(8);
					String sale_unit_name1="";
					if(sale_unit1.equals("1")){
						sale_unit_name1 = unit_low[k];
					}else{
						sale_unit_name1 = unit_high[k];
					}		
					float unit_price_low=0;
					if(sale_unit1.equals(price_unit[k])){
						if(good_name1.equals("")){
							unit_price_low=unit_price[k];
						}else{
							unit_price_low=price2;						
						}
					}else{
						unit_price_low=unit_price[k]/rate[k];
					}
					float total1 = quantity1_float*unit_price_low;
					total_amount = total_amount+total1;		
					String pay_date1 = rs.getString(9);
					int pays_dates1=0;
					try{
						pays_dates1 = Integer.parseInt(pay_date1);
					}catch(Exception e){}
					int today_dates = fromtodate.today();
					if(pay1.equals("Y")){
						if(pays_dates1<=today_dates){
							total_pay = total_pay+total1;
						}
					}
%>
	<tr class="tr1" >
		<td colspan="5"></td>
		<td align="left" ><%=out_date1_show%>  <%=good_name1%></td>
		<td align="left" ><%=company_name1%></td>	
		<td align="right" ><%=convertcomma.dtoa(Float.toString(sale1_float),"#,##0.00")%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity1_float),"#,##0.0")%> <%=sale_unit_name1%>(x<%=convertcomma.dtoa(Float.toString(unit_price_low),"#,##0")%>)</td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(total1),"#,##0.00")%></td>
		<td align="center" ><%=pay_name1%></td>
	</tr>
<%
				}
			}
		}
%>
	<tr class="tr0" >
		<td align="right" colspan="3">ราคาสินค้าหลังหักส่วนลด</td>
		<td align="right"><%=convertcomma.dtoa(Float.toString(total),"#,##0.00")%></td>
		<td align="center" colspan="3">ส่วนต่างรวมเงิน <%=convertcomma.dtoa(Float.toString(total-total_amount),"#,##0.00")%></td>
		<td align="right" colspan="2">ทุนรวมเงิน</td>
		<td align="right"><%=convertcomma.dtoa(Float.toString(total_amount),"#,##0.00")%></td>
		<td align="right"><%=convertcomma.dtoa(Float.toString(total_pay),"#,##0.00")%></td>
	</tr>
	<tr>
		<td align="center" colspan="11">
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
