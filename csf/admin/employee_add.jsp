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
		if (!hasInput(form1.first_name.value)){			
			var redObj = new Array(form1.first_name);
			setErrorColor(redObj);			
			alert("กรุณากรอกชื่อ");
			form1.first_name.focus();
			return; 
		}		
		if (!hasInput(form1.sur_name.value)){			
			var redObj = new Array(form1.sur_name);
			setErrorColor(redObj);			
			alert("กรุณากรอกชื่อเล่น");
			form1.sur_name.focus();
			return;
		}		
		if (!hasInput(form1.city.value)){			
			var redObj = new Array(form1.city);
			setErrorColor(redObj);			
			alert("กรุณากรอกจังหวัด");
			form1.city.focus();
			return;
		}		
		if (!hasInput(form1.country.value)){			
			var redObj = new Array(form1.country);
			setErrorColor(redObj);			
			alert("กรุณากรอกประเทศ");
			form1.country.focus();
			return;
		}		
		if (!hasInput(form1.imp_date.value)){			
			var redObj = new Array(form1.imp_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่เข้าทำงาน");
			form1.date_butt1.focus();
			return;
		}		
		if (form1.position.options[form1.position.selectedIndex].value == "E") {
			form1.username.value="";
			form1.password.value="";
		}else{
			if (!hasInput(form1.username.value)){			
				var redObj = new Array(form1.username);
				setErrorColor(redObj);			
				alert("กรุณากรอกชื่อผู้ใช้");
				form1.username.focus();
				return;
			}
			if (!hasInput(form1.password.value)){			
				var redObj = new Array(form1.password);
				setErrorColor(redObj);			
				alert("กรุณากรอกรหัสผ่าน");
				form1.password.focus();
				return;
			}
		}
		form1.action = "employee_adddata.jsp";
		form1.submit();
	}
	function cancel(){  
 		window.location="employee_search.jsp";
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
		}else if (strRtnId == 2) {	
			form1.exp_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.exp_date.value = strDate; 
		}
	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มพนักงาน</font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ชื่อ *</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="first_name" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">นามสกุล</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="last_name" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ชื่อเล่น *</td>
		<td><input type="text" class="txt" size="10" maxlength="20" name="sur_name" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ที่อยู่</td>
		<td><input type="text" class="txt" size="50" maxlength="200" name="address" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">จังหวัด *</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="city" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">รหัสไปรษณีย์</td>
		<td><input type="text" class="txt" size="5" maxlength="10" name="postal_code" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ประเทศ *</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="country" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">โทรศัพท์</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="phone" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">Fax</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="fax" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">โทรศัพท์มือถือ</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="mobile_phone" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">E-mail</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="email" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">วันที่เข้างาน *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="imp_date_show" disabled><input type="hidden" name="imp_date">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ตำแหน่ง</td>
		<td><select name="position" >
					<option value="C">ACCOUNT</option>
					<option value="A">ADMIN</option>
					<option value="E" selected>EMPLOYEE</option>
					<option value="F">FACTORY</option>
					<option value="M">MANAGER</option>
					<option value="S">SELL</option>
					<option value="W">WAREHOUSE</option>
		</select></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชื่อผู้ใช้</td>
		<td><input type="text" class="txt" size="20" maxlength="20" name="username" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รหัสผ่าน</td>
		<td><input type="text" class="txt" size="20" maxlength="20" name="password" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="comment" > </td>
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
