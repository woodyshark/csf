<%@ page contentType="text/html;charset=UTF-8"%>

<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String mate_no = request.getParameter("mate_no");
		String year = request.getParameter("year");
		ResultSet rs = stmt.executeQuery("select m.mate_date,c.company_name,c.name,e.first_name,e.last_name,m.total,m.comment from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and  mate_no='"+mate_no+"' and year='"+year+"'");
		rs.next();
		String mate_date = rs.getString(1);
		String mate_date_show="";
		try{
			mate_date_show = mate_date.substring(6,8)+"/"+mate_date.substring(4,6)+"/"+mate_date.substring(0,4);
		}catch(Exception e){}
		String company_name = rs.getString(2)+"-->"+rs.getString(3);
		String name = rs.getString(4)+"  "+rs.getString(5);
		String total = rs.getString(6);
		String comment = rs.getString(7);
		rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
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
		form1.action = "material_paydata.jsp?mate_no=<%=mate_no%>&year=<%=year%>";
		form1.submit();
	}
	function cancel(){  
 		history.back();
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
<font  class="f1" >จ่ายเงินใบสั่งซื้อวัตถุดิบ-สินค้า</font><br>
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
	<tr class="tr1" >
		<td align="right" class="h1">รวมเงิน</td>
		<td align="left"><%=convertcomma.dtoa(total,"#,##0.00")%> บาท</td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">รูปแบบการจ่ายเงิน</td>
		<td><select name="pay_type" >
					<option value="L">จ่ายสด</option>
					<option value="I">โอนเงิน</option>
					<option value="C">จ่ายเช็ค</option>
		</select></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">วันที่จ่ายเงิน</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="pay_date_show" disabled><input type="hidden" name="pay_date">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">รายละเอียดการจ่ายเงิน</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="pay_detail"> </td>
	</tr>
	<tr class="tr1">
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
