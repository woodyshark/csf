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
		ResultSet rs = stmt.executeQuery("select o.orders_date,c.company_name,c.name,e.first_name,e.last_name,o.next_date,o.total,o.comment from orders o,client c,employee e where o.client_id=c.client_id and o.employee_id=e.employee_id and  orders_no='"+orders_no+"' and year='"+year+"'");
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
		String comment = rs.getString(8);
		rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<title>จ่ายเงินใบขายสินค้า</title>
<script language="JavaScript">
		function sm(){
		if (!hasInput(form1.pay_date.value)){			
			var redObj = new Array(form1.pay_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่จ่ายเงิน");
			form1.date_butt1.focus();
			return;
		}		
		if (document.form1.pay_type.options[document.form1.pay_type.selectedIndex].value == "C") {
			if (!hasInput(form1.pay_detail.value)){			
				var redObj = new Array(form1.pay_detail);
				setErrorColor(redObj);			
				alert("กรุณากรอกรายละเอียดการจ่ายเงิน");
				form1.pay_detail.focus();
				return;
			}
		}
		form1.action = "orders_paydata.jsp?orders_no=<%=orders_no%>&year=<%=year%>";
		form1.submit();
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
	function getCalendarInfo(strRtnId, strOpn){
		var dialogUrl = "../libs/calendar.jsp?o_rtnid_hd=" + strRtnId +"&o_opn_hd=" + strOpn ;
		var calendarwin = window.open(dialogUrl,"calendar","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=200, width=160,resizable=0");
		calendarwin.focus();
	}
	function setCalendarInfo(strRtnId, strDate){	
		if (strRtnId == 1) {	
			form1.pay_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.pay_date.value = strDate; 
		}
	}
</script>
</head>
<body>
<font  class="f1" >จ่ายเงินใบขายสินค้า</font><br>
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
	<tr class="tr2" >
		<td align="right" class="h1">รวมเงิน</td>
		<td align="left"><%=convertcomma.dtoa(total,"#,##0.00")%> บาท</td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รูปแบบการจ่ายเงิน</td>
		<td><select name="pay_type" >
					<option value="L">จ่ายสด</option>
					<option value="I">โอนเงิน</option>
					<option value="C">จ่ายเช็ค</option>
		</select></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">วันที่จ่ายเงิน</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="pay_date_show" disabled><input type="hidden" name="pay_date">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รายละเอียดการจ่ายเงิน</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="pay_detail"> </td>
	</tr>
		<tr class="tr2">
		<td ></td>
		<td align="right">
			<input type="button" name="sm1" value="    เพิ่ม   " class="butt"  onclick="sm()">
			<input type= "reset"  name="sm2" value="    ยกเลิก   " class="butt" onclick="cancel()">
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
