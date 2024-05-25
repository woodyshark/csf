<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String mate_no = request.getParameter("mate_no");
		String year = request.getParameter("year");
		ResultSet rs = stmt.executeQuery("select m.mate_date,c.company_name,c.name,e.first_name,e.last_name,m.comment from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and  mate_no='"+mate_no+"' and year='"+year+"'");
		rs.next();
		String mate_date = rs.getString(1);
		String mate_date_show="";
		try{
			mate_date_show = mate_date.substring(6,8)+"/"+mate_date.substring(4,6)+"/"+mate_date.substring(0,4);
		}catch(Exception e){}
		String company_name = rs.getString(2)+"-->"+rs.getString(3);
		String name = rs.getString(4)+"  "+rs.getString(5);
		String comment = rs.getString(6);
		rs.close();
%>

<html>
<title>รายละเอียดใบสั่งซื้อวัตถุดิบ-สินค้า</title>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function cancel(){  
		window.close();
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
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" >จำนวน</td>
		<td align="center" >รายการสินค้า</td>
	</tr>
<%	
		rs = stmt.executeQuery("select g.name,m.quantity,m.price_unit,g.unit_low,g.unit_high from material_detail m,good g where m.good_id=g.good_id and  mate_no='"+mate_no+"' and year='"+year+"'");
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
		<td align="center" colspan="5">
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
