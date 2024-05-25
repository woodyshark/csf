<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
%>

<html>
<head>  <meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function sm(){
		if (!hasInput(form1.company_name.value)){			
			var redObj = new Array(form1.company_name);
			setErrorColor(redObj);			
			alert("กรุณาชื่อบริษัท");
			form1.company_name.focus();
			return; 
		}		
		if (!hasInput(form1.name.value)){			
			var redObj = new Array(form1.name);
			setErrorColor(redObj);			
			alert("กรุณาชื่อผู้ติดต่อ");
			form1.name.focus();
			return;
		}		
		if (!hasInput(form1.city.value)){			
			var redObj = new Array(form1.city);
			setErrorColor(redObj);			
			alert("กรุณากรอกจังหวัด");
			form1.city.focus();
			return;
		}		
		if (!hasInput(form1.phone.value)){			
			var redObj = new Array(form1.phone);
			setErrorColor(redObj);			
			alert("กรุณากรอกโทรศัพท์");
			form1.phone.focus();
			return;
		}		
		if (!hasInput(form1.imp_date.value)){			
			var redObj = new Array(form1.imp_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่เริ่มติดต่อ");
			form1.date_butt1.focus();
			return;
		}		
		form1.action = "client_adddata.jsp";
		form1.submit();
	}
	function cancel(){  
 		window.location="client_search.jsp";
	}
	function getCalendarInfo(strRtnId, strOpn){
		var dialogUrl = "../libs/calendar.jsp?o_rtnid_hd=" + strRtnId +"&o_opn_hd=" + strOpn ;
		var calendarwin = window.open(dialogUrl,"calendar","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=200, width=160,resizable=0");
		calendarwin.focus();
	}
	function setCalendarInfo(strRtnId, strDate){	
		if (strRtnId == 1) {	
			form1.imp_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.imp_date.value = strDate; 
		}
	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มลูกค้า</font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ชื่อบริษัท *</td>
		<td><input type="text" class="txt" size="25" maxlength="100" name="company_name" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชื่อผู้ติดต่อ *</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="name" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ที่อยู่</td>
		<td><input type="text" class="txt" size="50" maxlength="200" name="address" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">จังหวัด *</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="city" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รหัสไปรษณีย์</td>
		<td><input type="text" class="txt" size="5" maxlength="10" name="postal_code" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ประเทศ</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="country" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">โทรศัพท์ *</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="phone" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">Fax</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="fax" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">โทรศัพท์มือถือ</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="mobile_phone" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">E-mail</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="email" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">วันที่เริ่มติดต่อ *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="imp_date_show" disabled><input type="hidden" name="imp_date">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชนิดลูกค้า</td>
		<td><select name="type" >
					<option value="C" selected>ลูกค้าขาย</option>
					<option value="S">ลูกค้าซื้อ</option>
					<option value="O">อื่นๆ</option>
					<option value="1">ญาติพี่น้อง</option>
					<option value="2">เพื่อน</option>
					<option value="3">สำนักงานต่างๆ</option>
		</select></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="comment" > </td>
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
