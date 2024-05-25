<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String client_id = request.getParameter("client_id");if(client_id==null){client_id="";}
		String good_id = request.getParameter("good_id");if(good_id==null){good_id="";}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<title>เพิ่มรายการสินค้า</title>
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
				new Array("F", form1.sale,"ราคาขาย", form1.sale, true,"","",10,2),
				new Array("F", form1.quantity,"จำนวน", form1.quantity, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.sale.focus();
			return;
		}
		if (form1.sale_unit.options[form1.sale_unit.selectedIndex].value == "") {
			if (!hasInput(form1.sale_unit.value)){			
				var redObj = new Array(form1.sale_unit);
				setErrorColor(redObj);			
				alert("กรุณากรอกหน่วยสินค้า");
				form1.sale_unit.focus();
				return;
			}		
		}
		if (form1.sale_unit.options[form1.sale_unit.selectedIndex].value == "2") {
			var pattern = new Array(
				new Array("N", form1.quantity,"จำนวน", form1.quantity, true,"","",10,2));
			if (!checkInput(pattern)) {
				form1.quantity.focus();
				return;
			}		
		}
		var totals = parseFloat(form1.totals.value);
		var rates = parseFloat(form1.rate.value);
		var quantity = parseFloat(form1.quantity.value);
		var totals_quantity = 0;
		if (form1.sale_unit.options[form1.sale_unit.selectedIndex].value == "1") {
			totals_quantity=quantity;
		}else{
			totals_quantity = quantity*rates;
		}
		if(totals<totals_quantity){
			var redObj = new Array(form1.quantity);
			setErrorColor(redObj);			
			alert("จำนวนสินค้าคงเหลือไม่เพียงพอ กรุณากรอกจำนวนน้อยกว่าสินค้าในคลังสินค้า");
			form1.quantity.focus();
			return;
		}
		form1.amount.value = form1.quantity.value*form1.sale.value;
		self.parent.opener.adddetail(form1.good_id.options[form1.good_id.selectedIndex].value, form1.good_id.options[form1.good_id.selectedIndex].text,form1.sale.value,form1.quantity.value,form1.amount.value,form1.sale_unit.options[form1.sale_unit.selectedIndex].value, form1.sale_unit.options[form1.sale_unit.selectedIndex].text);
		window.close();
	}
	function cancel(){  
 		window.close();
	}
	function changegood(aa){
		if (aa.options[aa.selectedIndex].value == "") {
		}else{
			var bb=aa.options[aa.selectedIndex].value;
			form1.action="orders_addgood.jsp?good_id="+bb;
			form1.submit();
		}
	}
	function changeunit(aa,sale_low2,sale_high2){
		if (aa.options[aa.selectedIndex].value == "1") {
			form1.sale.value=sale_low2;
		}else{
			form1.sale.value=sale_high2;
		}
		form1.quantity.value="";
		form1.amount.value="";
	}
	function qua_unit2(){
		var pattern = new Array(
				new Array("F", form1.sale,"ราคาขาย", form1.sale, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.sale.focus();
			return;
		}
		form1.amount.value = form1.quantity.value*form1.sale.value;
	}
	function qua_unit(){
		var pattern = new Array(
				new Array("F", form1.sale,"ราคาขาย", form1.sale, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.sale.focus();
			return;
		}
		var pattern = new Array(
				new Array("F", form1.quantity,"จำนวน", form1.quantity, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.quantity.focus();
			return;
		}		
		form1.amount.value = form1.quantity.value*form1.sale.value;

	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มรายการสินค้า</font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0"  width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ชื่อสินค้า *<input type="hidden" name="client_id" value="<%=client_id%>"></td>
		<td><select name="good_id" onchange="changegood(document.form1.good_id)">
					<option value="">กรุณาเลือก</option>
<%
		ResultSet rs1 = stmt.executeQuery("(select distinct (d .good_id), g.name as name2,t.name as name1 from material_detail d, good g,good_type t where d .quantity_stock <> 0 and d .good_id = g.good_id and g.trans = 'n' and g.good_type_id=t.good_type_id )union (select  distinct (d .good_id), g.name as name2,t.name as name1 from trans_detail d, good g,good_type t where d .quantity_stock <> 0 and d .good_id = g.good_id and g.trans = 'n' and g.good_type_id=t.good_type_id  )order by name1 asc,name2 asc");
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
		float sale=0;String sale_unit="";float sale_low=0;float sale_high=0;String selected1="";String selected2="";
		float sale_low2=0;float sale_high2=0;float totals = 0;
		float total_unit_low=0;float total_unit_high=0;String name="";String unit_low="";String unit_high="";float rate=0;
		if(good_id.equals("")){
		}else{
			ResultSet rs = stmt.executeQuery("select name,unit_low,unit_high,rate,total_unit_low,total_unit_high from good where good_id='"+good_id+"'");	
			rs.next();
			name = rs.getString(1);
			unit_low = rs.getString(2);
			unit_high = rs.getString(3);
			rate = rs.getFloat(4);
			total_unit_low = rs.getFloat(5);
			total_unit_high = rs.getFloat(6);
			if(unit_high.equals("")){	
				totals = total_unit_low;
			}else{
				totals = (total_unit_high*rate)+total_unit_low;
			}
			 rs = stmt.executeQuery("select d.sale,d.sale_unit,o.orders_date from orders_detail d,orders o where o.orders_no=d.orders_no and o.year=d.year and d.good_id='"+good_id+"' and o.client_id='"+client_id+"' order by orders_date desc,o.orders_no desc");
			if(rs.next()){
				sale = rs.getFloat(1);
				sale_unit = rs.getString(2);if(sale_unit==null){sale_unit="";}
			}else{
				rs = stmt.executeQuery("select price_unit,sale_low,sale_high from good where good_id='"+good_id+"'");	
				if(rs.next()){
					sale_unit = rs.getString(1);if(sale_unit==null){sale_unit="";}
					sale_low = rs.getFloat(2);
					sale_high = rs.getFloat(3);
					if(sale_unit.equals("1")){
						sale=sale_low;
					}else{
						sale=sale_high;
					}		 		
				}
			}
			if(sale_unit.equals("1")){
				selected1 = "selected";
			}else{
				selected2 = "selected";
			}
			rs = stmt.executeQuery("select sale_low,sale_high from good where good_id='"+good_id+"'");	
			if(rs.next()){
				sale_low2 = rs.getFloat(1);
				sale_high2 = rs.getFloat(2);
			}
			rs.close();
		}
%>
	<tr class="tr2">
		<td align="right" class="h1">ราคาขาย *</td>
		<td><input type="text" class="txt" size="10" maxlength="15" name="sale" value="<%=sale%>"  onKeyUp="qua_unit2()"> ต่อ 
			<select name="sale_unit"  onchange="changeunit(document.form1.sale_unit,<%=sale_low2%>,<%=sale_high2%>)">
<%
		if(unit_high.equals("")){
%>
					<option value="1"><%=unit_low%> (ราคาที่ตั้งไว้ <%=convertcomma.dtoa(Float.toString(sale_low2),"#,##0.00")%> บาท ต่อ <%=unit_low%>)</option>
<%
		}else{
%>
					<option value="">กรุณาเลือก</option>
					<option value="1" <%=selected1%>><%=unit_low%> (ราคาที่ตั้งไว้ <%=convertcomma.dtoa(Float.toString(sale_low2),"#,##0.00")%> บาท ต่อ <%=unit_low%>)</option>
					<option value="2" <%=selected2%>><%=unit_high%> (ราคาที่ตั้งไว้ <%=convertcomma.dtoa(Float.toString(sale_high2),"#,##0.00")%> บาท ต่อ <%=unit_high%>)</option>
<%
		}	
%>
			</select> 
		</td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">จำนวน</td>
		<td><input type="text" class="txt" size="5" maxlength="15" name="quantity" onKeyUp="qua_unit()"> มีสินค้าอยู่ <%=convertcomma.dtoa(Float.toString(total_unit_low),"#,##0.0")%> <%=unit_low%>  <% if(unit_high.equals("")){}else{%><%=convertcomma.dtoa(Float.toString(total_unit_high),"#,##0.0")%> <%=unit_high%><%}%><input type="hidden" name="totals" value="<%=totals%>"><input type="hidden" name="rate" value="<%=rate%>"> </td>
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
