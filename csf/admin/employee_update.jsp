<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String employee_id = request.getParameter("employee_id");
		ResultSet    rs = stmt.executeQuery( "select  *  from  employee  where employee_id = '"+employee_id+"'");	
		rs.next();
		String  first_name = rs.getString("first_name");
		String  last_name = rs.getString("last_name");
		String  sur_name = rs.getString("sur_name"); 
		String  address = rs.getString("address");
		String  city  = rs.getString("city");
		String  postal_code = rs.getString("postal_code");
		String  country = rs.getString("country");
		String  phone = rs.getString("phone");
		String  fax = rs.getString("fax"); 
		String  mobile_phone = rs.getString("mobile_phone");
		String  email  = rs.getString("email");
		String  imp_date = rs.getString("imp_date");
		String  exp_date = rs.getString("exp_date");
		String imp_date_show="";String exp_date_show="";
		try{
			 imp_date_show = imp_date.substring(6,8)+"/"+imp_date.substring(4,6)+"/"+imp_date.substring(0,4);
			 exp_date_show = exp_date.substring(6,8)+"/"+exp_date.substring(4,6)+"/"+exp_date.substring(0,4); 
		}catch(Exception e){}
		String  status = rs.getString("status"); 
		String selected11="";String selected12="";String disabled="";
		if(status.equals("Y")){
			disabled = "disabled";
			selected11 = "selected";
		}else{
			disabled = "";
			selected12 = "selected";
		}
		String  position = rs.getString("position");
		String selected1="";String selected2="";String selected3="";String selected4="";String selected5="";String selected6="";String selected7="";
		 if(position.equals("C")){
			selected1 = "selected";
		}else if(position.equals("A")){
			selected2 = "selected";
		}else if(position.equals("E")){
			selected3 = "selected";
		}else if(position.equals("F")){
			selected4 = "selected";
		}else if(status.equals("M")){
			selected5 = "selected";
		}else if(position.equals("S")){
			selected6 = "selected";
		}else if(position.equals("W")){
			selected7 = "selected";
		}
		String  username  = rs.getString("username");
		String  password = rs.getString("password");
		String  comment = rs.getString("comment");
        rs.close();
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
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
		if (form1.status.options[form1.status.selectedIndex].value == "Y") {
			form1.exp_date.value="";
			form1.exp_date_show.value="";
		}else{
			if (!hasInput(form1.exp_date.value)){			
				var redObj = new Array(form1.exp_date);
				setErrorColor(redObj);			
				alert("กรุณากรอกวันที่ออกทำงาน");
				form1.date_butt2.focus();
				return;
			}		
		}
		if (form1.position.options[form1.position.selectedIndex].value == "E") {
			form1.username.value="";
			form1.password.value="";
		}else{
			if (!hasInput(form1.username.value)){			
				var redObj = new Array(form1.username);
				setErrorColor(redObj);			
				alert("กรุณากรอกรหัสผู้ใช้");
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
		form1.action = "employee_updatedata.jsp?employee_id=<%=employee_id%>";
		form1.submit();
	}
	function cancel(){  
 		history.back();
	}
	function status_change(){
			if (form1.status.options[form1.status.selectedIndex].value == "Y") {
				form1.date_butt2.disabled = true;
				form1.exp_date.value="";
				form1.exp_date_show.value="";
			}else{
				form1.date_butt2.disabled = false;
			}
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
<font  class="f1" >ปรับปรุงพนักงาน</font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0"  width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ชื่อ *</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="first_name"  value="<%=first_name%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">นามสกุล</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="last_name"   value="<%=last_name%>" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ชื่อเล่น *</td>
		<td><input type="text" class="txt" size="10" maxlength="20" name="sur_name"  value="<%=sur_name%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ที่อยู่</td>
		<td><input type="text" class="txt" size="50" maxlength="200" name="address"   value="<%=address%>"> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">จังหวัด *</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="city"   value="<%=city%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">รหัสไปรษณีย์</td>
		<td><input type="text" class="txt" size="5" maxlength="10" name="postal_code"   value="<%=postal_code%>"> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ประเทศ *</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="country"  value="<%=country%>" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">โทรศัพท์</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="phone"  value="<%=phone%>" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">Fax</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="fax"  value="<%=fax%>" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">โทรศัพท์มือถือ</td>
		<td><input type="text" class="txt" size="15" maxlength="50" name="mobile_phone"  value="<%=mobile_phone%>" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">E-mail</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="email"   value="<%=email%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">วันที่เข้างาน *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="imp_date_show" disabled   value="<%=imp_date_show%>"><input type="hidden" name="imp_date"   value="<%=imp_date%>"> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">สถานะ</td>
		<td><select name="status"  onchange="status_change()">
					<option value="Y" <%=selected11%>>อยู่</option>
					<option value="N" <%=selected12%>>ไม่อยู่</option>
		</select></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">วันที่ออกงาน</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="exp_date_show" disabled value="<%=exp_date_show%>"><input type="hidden" name="exp_date"    value="<%=exp_date%>">  <input type="button" name="date_butt2" class="butt" value="..." onClick="getCalendarInfo(2,'opener')" <%=disabled%>> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ตำแหน่ง</td>
		<td><select name="position" >
					<option value="C" <%=selected1%>>ACCOUNT</option>
					<option value="A" <%=selected2%>>ADMIN</option>
					<option value="E" <%=selected3%>>EMPLOYEE</option>
					<option value="F" <%=selected4%>>FACTORY</option>
					<option value="M" <%=selected5%>>MANAGER</option>
					<option value="S" <%=selected6%>>SELL</option>
					<option value="W" <%=selected7%>>WAREHOUSE</option>
		</select></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">รหัสผู้ใช้</td>
		<td><input type="text" class="txt" size="20" maxlength="20" name="username"   value="<%=username%>" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รหัสผ่าน</td>
		<td><input type="text" class="txt" size="20" maxlength="20" name="password"  value="<%=password%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="comment"  value="<%=comment%>" > </td>
	</tr>
	<tr class="tr1">
		<td ></td>
		<td align="right">
			<input type="button" name="sm1" value="    ปรับปรุง   " class="butt"  onclick="sm()">
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
