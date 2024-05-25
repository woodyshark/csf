<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String good_trans_id = request.getParameter("good_trans_id");if(good_trans_id==null){good_trans_id="";}
		String good_id = request.getParameter("good_id");if(good_id==null){good_id="";}
%>

<html>
<title>เพิ่มรายการสินค้า</title>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function sm(){	
		if (form1.good_id.options[form1.good_id.selectedIndex].value == "") {
			if (!hasInput(form1.good_id.value)){			
				var redObj = new Array(form1.good_id);
				setErrorColor(redObj);			
				alert("กรุณากรอกชื่อสินค้า");
				form1.good_id.focus();
				return;
			}		
		}
		var pattern = new Array(
				new Array("F", form1.price,"ราคาซื้อ", form1.price, true,"","",10,2),
				new Array("F", form1.quantity,"จำนวน", form1.quantity, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.price.focus();
			return;
		}
		var pattern = new Array(
				new Array("F", form1.sale_low,"ราคาขายต่อ", form1.sale_low, true,"","",10,2),
				new Array("F", form1.sale_high,"ราคาขายต่อ", form1.sale_high, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.sale_low.focus();
			return;
		}
		if (form1.price_unit.options[form1.price_unit.selectedIndex].value == "") {
			if (!hasInput(form1.price_unit.value)){			
				var redObj = new Array(form1.price_unit);
				setErrorColor(redObj);			
				alert("กรุณากรอกหน่วยสินค้า");
				form1.price_unit.focus();
				return;
			}		
		}
		if (form1.price_unit.options[form1.price_unit.selectedIndex].value == "2") {
			var pattern = new Array(
				new Array("N", form1.quantity,"จำนวน", form1.quantity, true,"","",10,2));
			if (!checkInput(pattern)) {
				form1.quantity.focus();
				return;
			}		
		}
		form1.amount.value = form1.quantity.value*form1.price.value;
		self.parent.opener.adddetail(form1.good_id.options[form1.good_id.selectedIndex].value, form1.good_id.options[form1.good_id.selectedIndex].text,form1.price.value,form1.sale_low.value,form1.sale_high.value,form1.quantity.value,form1.amount.value,form1.price_unit.options[form1.price_unit.selectedIndex].value, form1.price_unit.options[form1.price_unit.selectedIndex].text,form1.unit_low.value,form1.unit_high.value);
		window.close();
	}
	function cancel(){  
 		window.close();
	}
	function changegood(aa){
		if (aa.options[aa.selectedIndex].value == "") {
		}else{
			var bb=aa.options[aa.selectedIndex].value;
			form1.action="trans_addgood.jsp?good_id="+bb;
			form1.submit();
		}
	}
	function qua_unit2(){
		var pattern = new Array(
				new Array("F", form1.price,"หน่วยละซื้อ", form1.price, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.price.focus();
			return;
		}
		form1.amount.value = form1.quantity.value*form1.price.value;
	}
	function qua_unit(){
		var pattern = new Array(
				new Array("F", form1.price,"หน่วยละซื้อ", form1.price, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.price.focus();
			return;
		}
		var pattern = new Array(
				new Array("F", form1.quantity,"จำนวน", form1.quantity, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.quantity.focus();
			return;
		}		
		form1.amount.value = form1.quantity.value*form1.price.value;
	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มรายการสินค้า</font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0"  width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ชื่อสินค้า *<input type="hidden" name="good_trans_id" value="<%=good_trans_id%>"></td>
		<td><select name="good_id" onchange="changegood(document.form1.good_id)">
					<option value="">กรุณาเลือก</option>
<%
		ResultSet rs1 = stmt.executeQuery("select t.good_trans_id,g.name from good_trans t,good g where t.good_trans_id=g.good_id and t.good_id='"+good_trans_id+"' order by g.name");
		while(rs1.next()){
			String good_ids = rs1.getString(1);
			String names = rs1.getString(2);
			String selected="";
			if(good_id.equals(good_ids)){
				selected = "selected";
			}else{
				selected = "";
			}
%>
					<option value="<%=good_ids%>" <%=selected%>><%=names%></option>
<%
		}	
		rs1.close();
%>
				  </select>
		</td>
	</tr>
<%
		float price=0;String price_unit="";float sale_low=0;float sale_high=0;String price_unit_name="";String selected1="";String selected2="";
		float total_unit_low=0;float total_unit_high=0;
		String name="";String unit_low="";String unit_high="";String rate="";
		if(good_id.equals("")){
		}else{
			ResultSet rs = stmt.executeQuery("select name,unit_low,unit_high,rate,total_unit_low,total_unit_high from good where good_id='"+good_id+"'");	
			rs.next();
			name = rs.getString(1);
			unit_low = rs.getString(2);
			unit_high = rs.getString(3);
			rate = rs.getString(4);
			total_unit_low = rs.getFloat(5);
			total_unit_high = rs.getFloat(6);
			rs = stmt.executeQuery("select price,price_unit,sale_low,sale_high from good where good_id='"+good_id+"'");	
			if(rs.next()){
				price = rs.getFloat(1);
				price_unit = rs.getString(2);if(price_unit==null){price_unit="";}
				sale_low = rs.getFloat(3);
				sale_high = rs.getFloat(4);
			}
			if(price_unit.equals("1")){
				price_unit_name = unit_low;
				selected1 = "selected";
			}else{
				price_unit_name = unit_high;
				selected2 = "selected";
			}
			rs.close();
		}
%>
	<tr class="tr2">
		<td align="right" class="h1">ราคาซื้อ *</td>
		<td><input type="text" class="txt" size="10" maxlength="15" name="price" value="<%=price%>"  onKeyUp="qua_unit2()"> ต่อ 
			<select name="price_unit">
<%
		if(unit_high.equals("")){
%>
					<option value="1"><%=unit_low%></option>
<%
		}else{
%>
					<option value="">กรุณาเลือก</option>
					<option value="1" <%=selected1%>><%=unit_low%></option>
					<option value="2" <%=selected2%>><%=unit_high%></option>
<%
		}	
%>
			</select> ราคาที่ตั้งไว้ <%=convertcomma.dtoa(Float.toString(price),"#,##0.00")%> บาท ต่อ <%=price_unit_name%>
		</td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">(ราคาขายต่อ<%=unit_low%> *<input type="hidden" name="unit_low" value="<%=unit_low%>"></td>
		<td><input type="text" class="txt" size="10" maxlength="15" name="sale_low" value="<%=sale_low%>" > ราคาที่ตั้งไว้ <%=convertcomma.dtoa(Float.toString(sale_low),"#,##0.00")%> บาท)</td>
	</tr>
<%
		if(unit_high.equals("")){
%>
		<input type="hidden" name="unit_high" value="<%=unit_high%>"><input type="hidden"  name="sale_high" value="<%=sale_high%>">
<%
		}else{
%>
	<tr class="tr1">
		<td align="right" class="h1">(ราคาขายต่อ<%=unit_high%> *<input type="hidden" name="unit_high" value="<%=unit_high%>"></td> 
		<td><input type="text" class="txt" size="10" maxlength="15" name="sale_high" value="<%=sale_high%>"> <%=rate%> <%=unit_low%> ต่อ 1 <%=unit_high%> ราคาที่ตั้งไว้ <%=convertcomma.dtoa(Float.toString(sale_high),"#,##0.00")%> บาท)</td>
	</tr>
<%
		}	
%>

	<tr class="tr2">
		<td align="right" class="h1">จำนวน</td>
		<td><input type="text" class="txt" size="5" maxlength="15" name="quantity" onKeyUp="qua_unit()"> มีสินค้าอยู่ <%=convertcomma.dtoa(Float.toString(total_unit_low),"#,##0.0")%> <%=unit_low%>  <% if(unit_high.equals("")){}else{%><%=convertcomma.dtoa(Float.toString(total_unit_high),"#,##0.0")%> <%=unit_high%><%}%></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รวมเงิน</td>
		<td><input type="text" class="txt" size="20" maxlength="20" name="amount" disabled> </td>
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
