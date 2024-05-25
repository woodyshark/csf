<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function sm(){
		if (!hasInput(form1.name.value)){			
			var redObj = new Array(form1.name);
			setErrorColor(redObj);			
			alert("กรุณากรอกชื่อสินค้า");
			form1.name.focus();
			return;
		}		
		if (document.form1.good_type_id.options[document.form1.good_type_id.selectedIndex].value == "" || document.form1.good_type_id.options[document.form1.good_type_id.selectedIndex].value == "edit") {
			if (!hasInput(form1.good_type_id.value)){			
				var redObj = new Array(form1.good_type_id);
				setErrorColor(redObj);			
				alert("กรุณากรอกประเภทสินค้า");
				form1.good_type_id.focus();
				return;
			}
		}
		if (!hasInput(form1.imp_date.value)){			
			var redObj = new Array(form1.imp_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่เริ่มใช้สินค้า");
			form1.date_butt1.focus();
			return;
		}		
		if (!hasInput(form1.unit_low.value)){			
			var redObj = new Array(form1.unit_low);
			setErrorColor(redObj);			
			alert("กรุณากรอกหน่วยนับย่อย");
			form1.unit_low.focus();
			return;
		}	
		var pattern = new Array(
				new Array("F", form1.rate,"อัตราส่วน", form1.rate, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.rate.focus();
			return;
		}		
		if( document.form1.rate.value>1){
			if (!hasInput(form1.unit_high.value)){			
				var redObj = new Array(form1.unit_high);
				setErrorColor(redObj);			
				alert("กรุณากรอกหน่วยนับใหญ่");
				form1.unit_high.focus();
				return;
			}
		}
		var pattern = new Array(
				new Array("F", form1.min_quantity,"จำนวนต่ำสุดที่ต้องมีในคลังสินค้า", form1.min_quantity, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.min_quantity.focus();
			return;
		}
		form1.action = "good_adddata.jsp";
		form1.submit();
	}
	function cancel(){  
 		window.location="good_search.jsp";
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
	function changetype(aa){
		if (aa.options[aa.selectedIndex].value == "edit") {
			var dialogUrl = "good_type.jsp";
			var good_type = window.open(dialogUrl,"good_type","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=225, width=400,resizable=0");
			good_type.focus();
		}
	}
	function addtype(id,name) {
			len = document.form1.good_type_id.length;
			document.form1.good_type_id.options[len-1] = null;
			newitem= new Option(name,id,false,false);
    		document.form1.good_type_id.options[len-1] = newitem;
			newitem= new Option("จัดการประเภทสินค้า","edit",false,true);
    		document.form1.good_type_id.options[len] = newitem;
			document.form1.good_type_id.options[len-1].selected = true;
			good_type.focus();
	}
	function updtype(id,name) {
			len = document.form1.good_type_id.length;
			for (k = 0; k < len; k++) {
				if (document.form1.good_type_id.options[k].value == id) updPos = k;
			}
			document.form1.good_type_id.options[updPos].text = name;
			document.form1.good_type_id.options[updPos].selected = true;
			good_type.focus();
	}
	function rate_unit_high(){
		var pattern = new Array(
				new Array("F", form1.rate,"อัตราส่วน", form1.rate, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.rate.focus();
			return;
		}
		if( document.form1.rate.value>1){	
			document.form1.unit_high.disabled = false;
			document.form1.unit_high.focus();
		}else{
			document.form1.unit_high.disabled = true;
			document.form1.unit_high.value = "";
		}
	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มทะเบียนสินค้า</font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ชื่อสินค้า *</td>
		<td><input type="text" class="txt" size="25" maxlength="50" name="name" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ประเภท	*</td>
		<td><select name="good_type_id" onchange = "changetype(document.form1.good_type_id)">
					<option value="">กรุณาเลือก</option>
<%
		ResultSet rs1 = stmt.executeQuery("select * from good_type");
		while(rs1.next()){
			String good_type_id = rs1.getString("good_type_id");
			String name = rs1.getString("name");
%>
					<option value="<%=good_type_id%>"><%=name%></option>
<%
		}	
		rs1.close();
%>
					<option value="edit">จัดการประเภทสินค้า</option>
				  </select>
		</td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">วันที่เริ่มใช้ *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="imp_date_show" disabled><input type="hidden" name="imp_date">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">รายละเอียด</td>
		<td><input type="text" class="txt" size="50" maxlength="200" name="description" > </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">หน่วยนับย่อย *</td> 
		<td><input type="text" class="txt" size="10" maxlength="50" name="unit_low" > ก.ก.</td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">อัตราส่วน *</td>
		<td><input type="text" class="txt" size="5" maxlength="10" name="rate" value="1" onKeyUp="rate_unit_high()"> 10 ก.ก. = 1 ถุง ให้ระบุ 10</td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">หน่วยนับใหญ่ *</td> 
		<td><input type="text" class="txt" size="10" maxlength="50" name="unit_high" disabled> ถุง</td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">จำนวนต่ำสุดที่ต้องมีในคลังสินค้า *</td>
		<td><input type="text" class="txt" size="5" maxlength="10" name="min_quantity" value="0"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชนิด</td>
		<td><select name="trans">
					<option value="Y">วัตถุดิบ</option>
					<option value="N" selected>สินค้า</option>
					<option value="C">ค่าใช้จ่าย</option>
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
