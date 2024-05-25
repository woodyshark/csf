<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String mate_no = request.getParameter("mate_no");
		String year = request.getParameter("year");
		String close = request.getParameter("close");if(close==null){close="";}
		ResultSet rs = stmt.executeQuery("select m.mate_date,c.company_name,c.name,e.first_name,e.last_name,m.total,m.discount,m.total_discount,m.comment,m.pay,m.pay_type,m.pay_date,m.pay_detail from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and  mate_no='"+mate_no+"' and year='"+year+"'");
		rs.next();
		String mate_date = rs.getString(1);
		String mate_date_show="";
		try{
			mate_date_show = mate_date.substring(6,8)+"/"+mate_date.substring(4,6)+"/"+mate_date.substring(0,4);
		}catch(Exception e){}
		String company_name = rs.getString(2)+"-->"+rs.getString(3);
		String name = rs.getString(4)+"  "+rs.getString(5);
		String total = rs.getString(6);
		String discount = rs.getString(7);
		String total_discount = rs.getString(8);
		String comment = rs.getString(9);
		String pay = rs.getString(10);
		String pay_name="";
		if(pay.equals("Y")){
			pay_name = "จ่ายแล้ว";
		}else{
			pay_name = "ยังไม่จ่าย";
		}
		String pay_type = rs.getString(11);
		String pay_type_name="";
		if(pay_type.equals("L")){
			pay_type_name = "จ่ายสด";
		}else if(pay_type.equals("I")){
			pay_type_name = "โอนเงิน";
		}else if(pay_type.equals("C")){
			pay_type_name = "จ่ายเช็ค";
		}
		String pay_date = rs.getString(12);
		String pay_date_show="";
		try{
			pay_date_show = pay_date.substring(6,8)+"/"+pay_date.substring(4,6)+"/"+pay_date.substring(0,4);
		}catch(Exception e){}
		String pay_detail = rs.getString(13);
		rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620"><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function cancel(){  
<%
	if(close.equals("yes")){
%>
		window.close();
<%
	}else{	
%>
 		history.back();
<%
	}
%>
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
		<td align="center" width="10%">จำนวน</td>
		<td align="center" width="30%" >รายการสินค้า</td>
		<td align="center" width="10%" >ราคาซื้อ</td>
		<td align="center" width="20%" >(ราคาขาย : หน่วยนับย่อย)</td>
		<td align="center" width="20%" >(ราคาขาย : หน่วยนับใหญ่)</td>
		<td align="center" width="10%" >จำนวนเงิน</td>
	</tr>
<%	
		rs = stmt.executeQuery("select g.name,m.quantity,m.price,m.price_unit,m.amount ,m.sale_low,m.sale_high,g.unit_low,g.unit_high from material_detail m,good g where m.good_id=g.good_id and  mate_no='"+mate_no+"' and year='"+year+"'");
		int i=0;
		while(rs.next()){
			i = i+1;
			String good_name = rs.getString(1);
			float quantity = rs.getFloat(2);
			float price = rs.getFloat(3);
			String price_unit = rs.getString(4);
			float amount = rs.getFloat(5);
			float sale_low = rs.getFloat(6);
			float sale_high = rs.getFloat(7);
			String unit_low = rs.getString(8);
			String unit_high = rs.getString(9);
			String price_unit_name="";
			if(price_unit.equals("1")){
				price_unit_name = unit_low;
			}else{
				price_unit_name = unit_high;
			}
			String sale_high_name="";
			if(unit_high.equals("")){
			}else{
				sale_high_name = "("+convertcomma.dtoa(Float.toString(sale_high),"#,##0.00")+" บาท ต่อ "+unit_high+")";
			}
			String background="";
			int bar = i%2;
			if(bar==0){
				background = "tr1";
			} else background = "tr2";
%>
	<tr class="<%=background%>" >
		<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity),"#,##0.0")%>  <%=price_unit_name%></td>
		<td align="left" ><%=good_name%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(price),"#,##0.00")%></td>
		<td align="right" >(<%=convertcomma.dtoa(Float.toString(sale_low),"#,##0.00")%> บาท ต่อ <%=unit_low%>)</td>
		<td align="right" ><%=sale_high_name%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(amount),"#,##0.00")%></td>
	</tr>
<%
		}
%>
	<tr class="tr0" >
		<td align="right" colspan="5">ราคาสินค้าก่อนหักส่วนลด</td>
		<td align="right"><%=convertcomma.dtoa(total,"#,##0.00")%></td>
	</tr>
	<tr class="tr1" >
		<td align="right" colspan="5">ส่วนลด</td>
		<td align="right"><%=convertcomma.dtoa(discount,"#,##0.00")%></td>
	</tr>
	<tr class="tr2" >
		<td align="right" colspan="5">ราคาสินค้าหลังหักส่วนลด</td>
		<td align="right"><%=convertcomma.dtoa(total_discount,"#,##0.00")%></td>
	</tr>
	<tr>
		<td align="center" colspan="6">
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
