<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String orders_no = request.getParameter("orders_no");
		String year = request.getParameter("year");
		String close = request.getParameter("close");if(close==null){close="";}
		ResultSet rs = stmt.executeQuery("select o.orders_date,c.company_name,c.name,e.first_name,e.last_name,o.next_date,o.total,o.discount,o.total_discount,o.comment,o.pay,o.pay_type,o.pay_date,o.pay_detail from orders o,client c,employee e where o.client_id=c.client_id and o.employee_id=e.employee_id and  orders_no='"+orders_no+"' and year='"+year+"'");
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
		String total = rs.getString(7);
		String discount = rs.getString(8);
		String total_discount = rs.getString(9);
		String comment = rs.getString(10);
		String pay = rs.getString(11);
		String pay_name="";
		if(pay.equals("Y")){
			pay_name = "จ่ายแล้ว";
		}else{
			pay_name = "ยังไม่จ่าย";
		}
		String pay_type = rs.getString(12);
		String pay_type_name="";
		if(pay_type.equals("L")){
			pay_type_name = "จ่ายสด";
		}else if(pay_type.equals("I")){
			pay_type_name = "โอนเงิน";
		}else if(pay_type.equals("C")){
			pay_type_name = "จ่ายเช็ค";
		}
		String pay_date = rs.getString(13);
		String pay_date_show="";
		try{
			pay_date_show = pay_date.substring(6,8)+"/"+pay_date.substring(4,6)+"/"+pay_date.substring(0,4);
		}catch(Exception e){}
		String pay_detail = rs.getString(14);
		rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<title>รายละเอียดใบขายสินค้า</title>
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
<font  class="f1" >รายละเอียดใบขายสินค้า</font><br>
<form name="form1" method="post"  >
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr0">
		<td align="right" width="30%">เลขที่ใบขายสินค้า</td>
		<td><%=orders_no%>/<%=year%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ใบสั่งซื้อลงวันที่</td>
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
		<td align="center" width="20%">จำนวน</td>
		<td align="center" width="30%" >รายการสินค้า</td>
		<td align="center" width="30%" >ราคาขาย</td>
		<td align="center" width="20%" >จำนวนเงิน</td>
	</tr>
<%	
		rs = stmt.executeQuery("select g.name,o.quantity,o.sale,o.sale_unit,o.amount,g.unit_low,g.unit_high from orders_detail o,good g where o.good_id=g.good_id and  orders_no='"+orders_no+"' and year='"+year+"'");
		int i=0;
		while(rs.next()){
			i=i+1;
			String good_name = rs.getString(1);
			float quantity = rs.getFloat(2);
			float sale = rs.getFloat(3);
			String sale_unit = rs.getString(4);
			float amount = rs.getFloat(5);
			String unit_low = rs.getString(6);
			String unit_high = rs.getString(7);
			String sale_unit_name="";
			if(sale_unit.equals("1")){
				sale_unit_name = unit_low;
			}else{
				sale_unit_name = unit_high;
			}
			String background="";
			int bar = i%2;
			if(bar==0){
				background = "tr1";
			} else background = "tr2";
%>
	<tr class="<%=background%>" >
		<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity),"#,##0.0")%>  <%=sale_unit_name%></td>
		<td align="left" ><%=good_name%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(sale),"#,##0.00")%> บาท ต่อ <%=sale_unit_name%></td>
		<td align="right" ><%=convertcomma.dtoa(Float.toString(amount),"#,##0.00")%></td>
	</tr>
<%
		}
%>
	<tr class="tr0" >
		<td align="right" colspan="3">ราคาสินค้าก่อนหักส่วนลด</td>
		<td align="right"><%=convertcomma.dtoa(total,"#,##0.00")%></td>
	</tr>
	<tr class="tr1" >
		<td align="right" colspan="3">ส่วนลด</td>
		<td align="right"><%=convertcomma.dtoa(discount,"#,##0.00")%></td>
	</tr>
	<tr class="tr2" >
		<td align="right" colspan="3">ราคาสินค้าหลังหักส่วนลด</td>
		<td align="right"><%=convertcomma.dtoa(total_discount,"#,##0.00")%></td>
	</tr>
	<tr>
		<td align="center" colspan="4">
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
