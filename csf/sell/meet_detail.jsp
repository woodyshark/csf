<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String meet_no = request.getParameter("meet_no");
		String year = request.getParameter("year");
		String close = request.getParameter("close");if(close==null){close="";}
		ResultSet rs = stmt.executeQuery("select m.meet_date,c.company_name,c.name,e.first_name,e.last_name,m.next_date,m.question,m.solution,m.comment from meet m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and  meet_no='"+meet_no+"' and year='"+year+"'");
		rs.next();
		String meet_date = rs.getString(1);
		String meet_date_show="";
		try{
			meet_date_show = meet_date.substring(6,8)+"/"+meet_date.substring(4,6)+"/"+meet_date.substring(0,4);
		}catch(Exception e){}
		String company_name = rs.getString(2)+"-->"+rs.getString(3);
		String name = rs.getString(4)+"  "+rs.getString(5);
		String next_date = rs.getString(6);
		String next_date_show="";
		try{
			next_date_show = next_date.substring(6,8)+"/"+next_date.substring(4,6)+"/"+next_date.substring(0,4);
		}catch(Exception e){}		
		String question = rs.getString(7);
		String solution = rs.getString(8);
		String comment = rs.getString(9);
		rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function print(){
		var dialogUrl = "excel_meet_detail.jsp?meet_no=<%=meet_no%>&year=<%=year%>";
		var excel = window.open(dialogUrl,"excel","");
		excel.focus();
	}
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
<font  class="f1" >รายละเอียดใบเสนอราคา</font><br>
<form name="form1" method="post"  >
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr0">
		<td align="right" width="30%">เลขที่ใบเสนอสินค้า</td>
		<td><%=meet_no%>/<%=year%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ใบเสนอสินค้าลงวันที่</td>
		<td><%=meet_date_show%></td>
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
		<td align="right" class="h1">วันที่นัดพบครั้งต่อไป</td>
		<td><%=next_date_show%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ปัญหา</td>
		<td><%=question%></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">วิธีแก้ไข</td>
		<td><%=solution%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><%=comment%></td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="30%">รายการสินค้า</td>
		<td align="center">รายละเอียดการบรรจุ</td>
		<td align="center"  width="30%">ราคาขาย</td>
	</tr>
<%	
		rs = stmt.executeQuery("select g.name,m.sale,m.sale_unit,g.unit_low,g.unit_high,g.rate from meet_detail m,good g,good_type t where m.good_id=g.good_id and g.good_type_id=t.good_type_id and  meet_no='"+meet_no+"' and year='"+year+"' order by t.name,g.name");
		int i=0;
		while(rs.next()){
			i=i+1;
			String good_name = rs.getString(1);
			String sale = rs.getString(2);
			String sale_unit = rs.getString(3);
			String unit_low = rs.getString(4);
			String unit_high = rs.getString(5);
			String rate = rs.getString(6);
			String sale_unit_name="";
			if(sale_unit.equals("1")){
				sale_unit_name = unit_low;
			}else{
				sale_unit_name = unit_high;
			}
			String detail="";
			if(unit_high.equals("")){
			}else{
				detail = rate.concat(" ").concat(unit_low).concat(" ต่อ ").concat(" 1 ").concat(unit_high);
			}
			String background="";
			int bar = i%2;
			if(bar==0){
				background = "tr1";
			} else background = "tr2";
%>
	<tr class="<%=background%>" >
		<td align="left" ><%=good_name%></td>
		<td align="center"><%=detail%></td>
		<td align="left" ><%=convertcomma.dtoa(sale,"#,##0.00")%> บาท ต่อ <%=sale_unit_name%></td>
	</tr>
<%
		}
%>
	<tr>
		<td align="center" colspan="4">
			<input type= "button"  name="sm2" value="    พิมพ์   " class="butt" onclick="print()">
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
