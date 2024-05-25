<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String trans_no = request.getParameter("trans_no");
		String year = request.getParameter("year");
		ResultSet rs = stmt.executeQuery("select t.mate_no,t.trans_date,t.comment,e.first_name,e.last_name,g.name,t.quantity,t.year_mate,c.company_name from trans t,employee e,good g,material m,client c where t.mate_no=m.mate_no and t.year_mate=m.year and m.client_id=c.client_id and  t.employee_id=e.employee_id and t.good_id=g.good_id and t.trans_no='"+trans_no+"' and t.year='"+year+"'");
		rs.next();
		String mate_no = rs.getString(1);
		String trans_date = rs.getString(2);
		String trans_date_show="";
		try{
			trans_date_show = trans_date.substring(6,8)+"/"+trans_date.substring(4,6)+"/"+trans_date.substring(0,4);
		}catch(Exception e){}
		String comment = rs.getString(3);
		String name = rs.getString(4)+"  "+rs.getString(5);
		String good_name1 = rs.getString(6);
		String quantity1 = rs.getString(7);
		String year_mate = rs.getString(8);
		String company_name = rs.getString(9);
		rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function cancel(){  
		window.close();
	}
</script>
</head>
<body>
<font  class="f1" >รายละเอียดวัตถุดิบแปรเป็นสินค้า</font><br>
<form name="form1" method="post"  >
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr0">
		<td align="right" width="30%">เลขที่วัตถุดิบแปรเป็นสินค้า</td>
		<td><%=mate_no%>/<%=year%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1" width="30%">วันที่วัตถุดิบแปรเป็นสินค้า</td>
		<td><%=trans_date_show%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">เลขที่ใบสั่งซื้อ</td>
		<td><%=mate_no%>/<%=year_mate%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1" width="30%">ชื่อผู้ผลิต</td>
		<td><%=company_name%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1" width="30%">สินค้าที่แปรรูป</td>
		<td><%=good_name1%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">จำนวน</td>
		<td><%=quantity1%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชื่อพนักงาน</td>
		<td><%=name%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><%=comment%></td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" >จำนวน</td>
		<td align="center" >รายการสินค้า</td>
	</tr>
<%	
		rs = stmt.executeQuery("select g.name,t.quantity,t.price_unit,g.unit_low,g.unit_high from trans_detail t,good g where t.good_id=g.good_id and  trans_no='"+trans_no+"' and year='"+year+"'");
		int i=0;
		while(rs.next()){
			i=i+1;
			String good_name = rs.getString(1);
			String quantity = rs.getString(2);
			String price_unit = rs.getString(3);
			String unit_low = rs.getString(4);
			String unit_high = rs.getString(5);
			String price_unit_name="";
			if(price_unit.equals("1")){
				price_unit_name = unit_low;
			}else{
				price_unit_name = unit_high;
			}
			String background="";
			int bar = i%2;
			if(bar==0){
				background = "tr1";
			} else background = "tr2";
%>
	<tr class="<%=background%>" >
		<td align="right" ><%=quantity%> <%=price_unit_name%></td>
		<td align="center" ><%=good_name%></td>
	</tr>
<%
		}
%>
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
