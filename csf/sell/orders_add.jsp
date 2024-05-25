<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String orders_date = request.getParameter("orders_date");if(orders_date==null){orders_date="";}
		String orders_date_show = request.getParameter("orders_date_show");if(orders_date_show==null){orders_date_show="";}
		String client_id = request.getParameter("client_id");if(client_id==null){client_id="";}
		String next_date = request.getParameter("next_date");if(next_date==null){next_date="";}
		String next_date_show = request.getParameter("next_date_show");if(next_date_show==null){next_date_show="";}
		String comment = request.getParameter("comment");if(comment==null){comment="";}
		String disabled="";
		if(request.getParameter("good_id") != null){
			disabled = "disabled";
		}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function addgood(){	
		if (!hasInput(form1.orders_date.value)){			
			var redObj = new Array(form1.orders_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกใบสั่งซื้อลงวันที่");
			form1.date_butt1.focus();
			return;
		}		
		if (document.form1.client_id.options[document.form1.client_id.selectedIndex].value == "") {
			if (!hasInput(form1.client_id.value)){			
				var redObj = new Array(form1.client_id);
				setErrorColor(redObj);			
				alert("กรุณากรอกชื่อลูกค้า");
				form1.client_id.focus();
				return;
			}
		}
		if (!hasInput(form1.next_date.value)){			
			var redObj = new Array(form1.next_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่นัดพบครั้งต่อไป");
			form1.date_butt2.focus();
			return;
		}	
		data=document.form1.client_id.options[document.form1.client_id.selectedIndex].value;
		var dialogUrl = "orders_addgood.jsp?client_id="+data;
		var orders_addgood = window.open(dialogUrl,"orders_addgood","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=250, width=400,resizable=0");
		orders_addgood.focus();
	}
	function adddetail(good_id,good_name,sale,quantity,amount,price_unit,price_unit_name) {
		if(document.form1.good_id==null){
		}else{
			if(good_id==document.form1.good_id.value){
					alert("สินค้านี้มีอยู่แล้ว กรุณาเพิ่มรายการสินค้าใหม่");
					window.opener = null;
					form1.add.focus();
					return;
				}
			for(k=0; k<document.form1.good_id.length; k++){
				if(good_id==document.form1.good_id[k].value){
					alert("สินค้านี้มีอยู่แล้ว กรุณาเพิ่มรายการสินค้าใหม่");
					window.opener = null;
					form1.add.focus();
					return;
				}
			}
		}
		form1.orders_date_show.disabled=false;
		form1.next_date_show.disabled=false;	
		form1.client_id.disabled=false;		
		arrayOfObj = price_unit_name.split("(");		
		price_unit_names = arrayOfObj[0];
		form1.action="orders_add.jsp?good_id="+good_id+"&good_name="+good_name+"&sale="+sale+"&quantity="+quantity+"&amount="+amount+"&price_unit="+price_unit+"&price_unit_name="+price_unit_names;
		form1.submit();
	}
	function sm(){
		if (!hasInput(form1.orders_date.value)){			
			var redObj = new Array(form1.orders_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกใบสั่งซื้อลงวันที่");
			form1.date_butt1.focus();
			return;
		}		
		if (document.form1.client_id.options[document.form1.client_id.selectedIndex].value == "") {
			if (!hasInput(form1.client_id.value)){			
				var redObj = new Array(form1.client_id);
				setErrorColor(redObj);			
				alert("กรุณากรอกชื่อลูกค้า");
				form1.client_id.focus();
				return;
			}
		}
		if (!hasInput(form1.next_date.value)){			
			var redObj = new Array(form1.next_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่นัดพบครั้งต่อไป");
			form1.date_butt2.focus();
			return;
		}	
		var pattern = new Array(
				new Array("F", form1.discount,"ส่วนลด", form1.discount, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.discount.focus();
			return;
		}
		if( parseFloat(form1.discount.value)>parseFloat(form1.total.value)){		
			var redObj = new Array(form1.discount);
			setErrorColor(redObj);			
			alert("ส่วนลดไม่เกินราคาสินค้าก่อนหักส่วนลด");
			form1.discount.focus();
			return;
		}else{
			form1.total_discount.value = form1.total.value-form1.discount.value;
		}
		if (document.form1.pay_type.options[document.form1.pay_type.selectedIndex].value == "N") {
		}else{
			if (!hasInput(form1.pay_date.value)){			
				var redObj = new Array(form1.pay_date_show);
				setErrorColor(redObj);			
				alert("กรุณากรอกวันที่จ่ายเงิน");
				form1.date_butt3.focus();
				return;
			}		
		}
		form1.client_id.disabled=false;		
		form1.total_discount.disabled = false;
		form1.action="orders_adddata.jsp";
		form1.submit();
	}
	function del(){  
		window.location="orders_add.jsp";
	}
	function cancel(){  
		window.location="orders_search.jsp";
	}
	function getCalendarInfo(strRtnId, strOpn){
		var dialogUrl = "../libs/calendar.jsp?o_rtnid_hd=" + strRtnId +"&o_opn_hd=" + strOpn ;
		var calendarwin = window.open(dialogUrl,"calendar","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=200, width=160,resizable=0");
		calendarwin.focus();
	}
	function setCalendarInfo(strRtnId, strDate){	
		if (strRtnId == 1) {	
			form1.orders_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.orders_date.value = strDate; 
		}else if (strRtnId == 2) {	
			form1.next_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.next_date.value = strDate; 
		}else if (strRtnId == 3) {	
			form1.pay_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.pay_date.value = strDate; 
		}
	}
	function changepay(){
		if (document.form1.pay_type.options[document.form1.pay_type.selectedIndex].value == "N") {
			form1.date_butt3.disabled = true;
			form1.pay_detail.disabled = true;
			form1.pay_date_show.value = "";
			form1.pay_date.value = "";		
			form1.pay_detail.value = "";
		}else{
			form1.date_butt3.disabled = false;
			form1.pay_detail.disabled = false;
		}
	}
	function discount_total(){
		var pattern = new Array(
				new Array("F", form1.discount,"ส่วนลด", form1.discount, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.discount.focus();
			return;
		}
		if( parseFloat(form1.discount.value)>parseFloat(form1.total.value)){		
			var redObj = new Array(form1.discount);
			setErrorColor(redObj);			
			alert("ส่วนลดไม่เกินราคาสินค้าก่อนหักส่วนลด");
			form1.discount.focus();
			return;
		}else{
			form1.total_discount.value = form1.total.value-form1.discount.value;
		}
	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มใบขายสินค้า</font><br>
<form name="form1" method="post"  >
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr1">
		<td align="right" class="h1">ใบสั่งซื้อลงวันที่ *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="orders_date_show" disabled value="<%=orders_date_show%>"><input type="hidden" name="orders_date"  value="<%=orders_date%>">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชื่อลูกค้า *</td>
		<td><select name="client_id" <%=disabled%>>
					<option value="">กรุณาเลือก</option>
<%
		ResultSet rs1 = stmt.executeQuery("select client_id,company_name,name,city from client where type='C' order by city,company_name,name");
		while(rs1.next()){
			String client_ids = rs1.getString(1);
			String names = rs1.getString(2)+"-->"+rs1.getString(3);
			String citys = rs1.getString(4);
			String selected = "";
			if(client_id.equals(client_ids)){
				selected = "selected";
			}else{
				selected = "";
			}
%>
					<option value="<%=client_ids%>" <%=selected%>><%=citys%>--><%=names%></option>
<%
		}	
%>
				  </select>
		</td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">วันที่นัดพบครั้งต่อไป *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="next_date_show" disabled value="<%=next_date_show%>"><input type="hidden" name="next_date"  value="<%=next_date%>">  <input type="button" name="date_butt2" class="butt" value="..." onClick="getCalendarInfo(2,'opener')"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="comment"  value="<%=comment%>"> </td>
	</tr>
	<tr class="tr1">
		<td ></td>
		<td align="right">
			<input type="button" name="add" value="    เพิ่มรายการสินค้า   " class="butt"  onclick="addgood()">
		</td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" width="20%">จำนวน</td>
		<td align="center" width="30%" >รายการสินค้า</td>
		<td align="center" width="30%" >ราคาขาย</td>
		<td align="center" width="20%" >จำนวนเงิน</td>
	</tr>
<%	
		if(request.getParameter("good_id") != null){
			String[] good_id= request.getParameterValues("good_id");
			String[] good_name= request.getParameterValues("good_name");
			String[] sale= request.getParameterValues("sale");
			String[] quantity= request.getParameterValues("quantity");
			String[] amount= request.getParameterValues("amount");	
			String[] price_unit= request.getParameterValues("price_unit");
			String[] price_unit_name= request.getParameterValues("price_unit_name");
			float total=0;
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					total = total+Float.parseFloat(amount[k]);
					String background="";
					int bar = k%2;
					if(bar==0){
						background = "tr1";
					} else background = "tr2";
%>
	<tr class="<%=background%>" ><input type="hidden" name="price_unit_name"  value="<%=price_unit_name[k]%>">
		<td align="right" ><input type="hidden" name="quantity"  value="<%=quantity[k]%>"><input type="hidden" name="price_unit"  value="<%=price_unit[k]%>"><%=convertcomma.dtoa(quantity[k],"#,##0.0")%>  <%=price_unit_name[k]%></td>
		<td align="left" ><input type="hidden" name="good_id"  value="<%=good_id[k]%>" ><input type="hidden" name="good_name"  value="<%=good_name[k]%>" ><%=good_name[k]%></td>
		<td align="right" ><input type="hidden" name="sale"  value="<%=sale[k]%>"><%=convertcomma.dtoa(sale[k],"#,##0.00")%> บาท ต่อ <%=price_unit_name[k]%></td>
		<td align="right" ><input type="hidden" name="amount"  value="<%=amount[k]%>"><%=convertcomma.dtoa(amount[k],"#,##0.00")%></td>
	</tr>
<%
				}
%>
	<tr class="tr0" >
		<td align="right" colspan="3">ราคาสินค้าก่อนหักส่วนลด</td>
		<td align="right"><input type="hidden" name="total"  value="<%=total%>"><%=convertcomma.dtoa(Float.toString(total),"#,##0.00")%></td>
	</tr>
	<tr class="tr1" >
		<td align="right" colspan="3">ส่วนลด</td>
		<td align="right"><input type="text" class="txt" size="15" maxlength="15" name="discount"  onKeyUp="discount_total()" value="0" ></td>
	</tr>
	<tr class="tr2" >
		<td align="right" colspan="3">ราคาสินค้าหลังหักส่วนลด</td>
		<td align="right"><input type="text" class="txt" name="total_discount" size="15" maxlength="15" disabled value="<%=total%>"></td>
	</tr>
</table>
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr1">
		<td align="right" class="h1">รูปแบบการจ่ายเงิน</td>
		<td><select name="pay_type" onchange="changepay()">
					<option value="N">เครดิต</option>			
					<option value="L">จ่ายสด</option>
					<option value="I">โอนเงิน</option>
					<option value="C">จ่ายเช็ค</option>
		</select></td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">วันที่จ่ายเงิน</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="pay_date_show" disabled><input type="hidden" name="pay_date">  <input type="button" name="date_butt3" class="butt" value="..." onClick="getCalendarInfo(3,'opener')" disabled></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รายละเอียดการจ่ายเงิน</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="pay_detail" disabled> </td>
	</tr>
	<tr class="tr2">
		<td ></td>
		<td align="right">
			<input type="button" name="sm1" value="    เพิ่ม   " class="butt"  onclick="sm()">
			<input type= "reset"  name="sm2" value="    ลบ   " class="butt" onclick="del()">
			<input type= "button"  name="sm3" value="    ยกเลิก   " class="butt" onclick="cancel()">
		</td>
	</tr>
<%
			}		
		}
%>
</table>
</form>
</body>
</html>

<%
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
