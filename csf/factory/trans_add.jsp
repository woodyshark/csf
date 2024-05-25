<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String trans_date = request.getParameter("trans_date");if(trans_date==null){trans_date="";}
		String trans_date_show = request.getParameter("trans_date_show");if(trans_date_show==null){trans_date_show="";}
		String mate_no = request.getParameter("mate_no");if(mate_no==null){mate_no="";}
		String comment = request.getParameter("comment");if(comment==null){comment="";}
		String trans_fin = request.getParameter("trans_fin");if(trans_fin==null){trans_fin="N";}
		String selected1=""; String selected2="";
		if(trans_fin.equals("N")){
			selected1 = "selected";
		}else if(trans_fin.equals("Y")){
			selected2 = "selected";
		}
		String disabled="";
		if(request.getParameter("good_id") != null){
			disabled = "disabled";
		}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620"><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function addgood(){	
		if (!hasInput(form1.trans_date.value)){			
			var redObj = new Array(form1.trans_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่วัตถุดิบแปรเป็นสินค้า");
			form1.date_butt1.focus();
			return;
		}		
		if (document.form1.mate_no.options[document.form1.mate_no.selectedIndex].value == "") {
			if (!hasInput(form1.mate_no.value)){			
				var redObj = new Array(form1.mate_no);
				setErrorColor(redObj);			
				alert("กรุณากรอกเลขที่ใบสั่งซื้อสินค้า");
				form1.mate_no.focus();
				return;
			}
		}
		data=document.form1.mate_no.options[document.form1.mate_no.selectedIndex].value;
		arrayOfObj = data.split("-");	
		good_trans_id = arrayOfObj[2];
		var dialogUrl = "trans_addgood.jsp?good_trans_id="+good_trans_id;
		var trans_addgood = window.open(dialogUrl,"trans_addgood","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=280, width=450,resizable=0");
		trans_addgood.focus();
	}
	function adddetail(good_id,good_name,price,sale_low,sale_high,quantity,amount,price_unit,price_unit_name,unit_low,unit_high) {
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
		form1.trans_date_show.disabled=false;
		form1.mate_no.disabled=false;
		form1.action="trans_add.jsp?good_id="+good_id+"&good_name="+good_name+"&price="+price+"&sale_low="+sale_low+"&sale_high="+sale_high+"&quantity="+quantity+"&amount="+amount+"&price_unit="+price_unit+"&price_unit_name="+price_unit_name+"&unit_low="+unit_low+"&unit_high="+unit_high+"";
		form1.submit();
	}
	function sm(){
		if (!hasInput(form1.trans_date.value)){			
			var redObj = new Array(form1.trans_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่วัตถุดิบแปรเป็นสินค้า");
			form1.date_butt1.focus();
		}		
		if (document.form1.mate_no.options[document.form1.mate_no.selectedIndex].value == "") {
			if (!hasInput(form1.mate_no.value)){			
				var redObj = new Array(form1.mate_no);
				setErrorColor(redObj);			
				alert("กรุณากรอกเลขที่ใบสั่งซื้อสินค้า");
				form1.mate_no.focus();
				return;
			}
		}
		var list = document.form1.mate_no.options[document.form1.mate_no.selectedIndex].value;
		arrayOfObj = list.split("-");	
		mate_no = arrayOfObj[0];
		year = arrayOfObj[1];
		good_id = arrayOfObj[2];
		quantity = arrayOfObj[3];
		form1.action="trans_adddata.jsp?mate_no="+mate_no+"&year_mate="+year+"&good_id_mate="+good_id+"&quantity_mate="+quantity;
		form1.submit();
	}
	function del(){  
		window.location="trans_add.jsp";
	}
	function cancel(){  
		window.location="trans_search.jsp";
	}
	function getCalendarInfo(strRtnId, strOpn){
		var dialogUrl = "../libs/calendar.jsp?o_rtnid_hd=" + strRtnId +"&o_opn_hd=" + strOpn ;
		var calendarwin = window.open(dialogUrl,"calendar","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=200, width=160,resizable=0");
		calendarwin.focus();
	}
	function setCalendarInfo(strRtnId, strDate){	
		if (strRtnId == 1) {	
			form1.trans_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.trans_date.value = strDate; 
		}
	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มวัตถุดิบแปรเป็นสินค้า</font><br>
<form name="form1" method="post"  >
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr1">
		<td align="right" class="h1">วันที่วัตถุดิบแปรเป็นสินค้า *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="trans_date_show" disabled value="<%=trans_date_show%>"><input type="hidden" name="trans_date"  value="<%=trans_date%>">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">เลขที่ใบสั่งซื้อ *</td>
		<td><select name="mate_no" <%=disabled%>>
					<option value="">กรุณาเลือก</option>
<%
		ResultSet rs1 = stmt.executeQuery("select m.mate_no,m.year,m.good_id,g.name,m.quantity,'ภูมิพัฒน์','' from material_detail m,good g where m.good_id=g.good_id and m.trans='Y' and m.trans_fin='N' order by m.year desc,m.mate_no desc");
		while(rs1.next()){
			String mate_nos = rs1.getString(1);
			String years = rs1.getString(2);
			String good_ids = rs1.getString(3);
			String names = rs1.getString(4);
			String quantitys = rs1.getString(5);
			String client_names = rs1.getString(6);
			String mate_dates = rs1.getString(7);
			String mate_dates_shows="";
			try{
				mate_dates_shows= mate_dates.substring(6,8)+"/"+mate_dates.substring(4,6)+"/"+mate_dates.substring(0,4);
			}catch(Exception e){}
			String selected = "";
			String mate_nos_eq = mate_nos.concat("-").concat(years).concat("-").concat(good_ids).concat("-").concat(quantitys);
			if(mate_nos_eq.equals(mate_no)){
				selected = "selected";
			}else{
				selected = "";
			}
%>
					<option value="<%=mate_nos%>-<%=years%>-<%=good_ids%>-<%=quantitys%>" <%=selected%>><%=mate_nos%>/<%=years%>--><%=mate_dates_shows%>--><%=client_names%>--><%=names%> จำนวน <%=quantitys%></option>
<%
		}	
%>
				  </select>     แปรรูปเสร็จหรือไม่
				  <select name="trans_fin">	
						<option value="N" <%=selected1%>>ยังไม่เสร็จ</option>
						<option value="Y" <%=selected2%>>เสร็จแล้ว</option>
					</select>
		</td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="comment"  value="<%=comment%>"> </td>
	</tr>
	<tr class="tr2">
		<td ></td>
		<td align="right">
			<input type="button" name="add" value="    เพิ่มรายการวัตถุดิบแปรเป็นสินค้า   " class="butt"  onclick="addgood()">
		</td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" width="10%">จำนวน</td>
		<td align="center" width="20%" >รายการสินค้า</td>
		<td align="center" width="20%" >ราคาซื้อ</td>
		<td align="center" width="20%" >(ราคาขาย : หน่วยนับย่อย)</td>
		<td align="center" width="20%" >(ราคาขาย : หน่วยนับใหญ่)</td>
		<td align="center" width="10%" >จำนวนเงิน</td>
	</tr>
<%	
		if(request.getParameter("good_id") != null){ 
			String[] good_id= request.getParameterValues("good_id");
			String[] good_name= request.getParameterValues("good_name");
			String[] price= request.getParameterValues("price");
			String[] sale_low= request.getParameterValues("sale_low");	
			String[] sale_high= request.getParameterValues("sale_high");
			String[] quantity= request.getParameterValues("quantity");
			String[] amount= request.getParameterValues("amount");	
			String[] price_unit= request.getParameterValues("price_unit");
			String[] price_unit_name= request.getParameterValues("price_unit_name");
			String[] unit_low= request.getParameterValues("unit_low");	
			String[] unit_high= request.getParameterValues("unit_high");	
			float total=0;
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					total = total+Float.parseFloat(amount[k]);
					String background="";
					int bar = k%2;
					if(bar==0){
						background = "tr1";
					} else background = "tr2";
					String sale_high_name="";
					if(unit_high[k].equals("")){
					}else{
						sale_high_name = "("+convertcomma.dtoa(sale_high[k],"#,##0.00")+" บาท ต่อ "+unit_high[k]+")";
					}
%>
	<tr class="<%=background%>" ><input type="hidden" name="price_unit_name"  value="<%=price_unit_name[k]%>"><input type="hidden" name="unit_low"  value="<%=unit_low[k]%>"><input type="hidden" name="unit_high"  value="<%=unit_high[k]%>">
		<td align="right" ><input type="hidden" name="quantity"  value="<%=quantity[k]%>"><input type="hidden" name="price_unit"  value="<%=price_unit[k]%>"><%=convertcomma.dtoa(quantity[k],"#,##0.0")%> <%=price_unit_name[k]%></td>
		<td align="left" ><input type="hidden" name="good_id"  value="<%=good_id[k]%>" ><input type="hidden" name="good_name"  value="<%=good_name[k]%>" ><%=good_name[k]%></td>
		<td align="right" ><input type="hidden" name="price"  value="<%=price[k]%>"><%=convertcomma.dtoa(price[k],"#,##0.00")%> บาท ต่อ <%=price_unit_name[k]%></td>
		<td align="right" ><input type="hidden" name="sale_low"  value="<%=sale_low[k]%>">(<%=convertcomma.dtoa(sale_low[k],"#,##0.00")%> บาท ต่อ <%=unit_low[k]%>)</td>
		<td align="right" ><input type="hidden" name="sale_high"  value="<%=sale_high[k]%>"><%=sale_high_name%></td>
		<td align="right" ><input type="hidden" name="amount"  value="<%=amount[k]%>"><%=convertcomma.dtoa(amount[k],"#,##0.00")%></td>
	</tr>
<%
				}
%>
	<tr class="tr0" >
		<td align="right" colspan="5">ราคาสินค้า</td>
		<td align="right"><input type="hidden" name="total"  value="<%=total%>"><%=convertcomma.dtoa(Float.toString(total),"#,##0.00")%></td>
	</tr>
	<tr>
		<td align="center" colspan="6">
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
