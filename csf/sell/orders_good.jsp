<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String meet_date = request.getParameter("meet_date");if(meet_date==null){meet_date="";}
		String meet_date_show = request.getParameter("meet_date_show");if(meet_date_show==null){meet_date_show="";}
		String client_id = request.getParameter("client_id");if(client_id==null){client_id="";}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
	function print() {
		if (!hasInput(form1.meet_date.value)){			
			var redObj = new Array(form1.meet_date_show);
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
		for(k=0; k<document.form1.del.length; k++){
			good_id = document.form1.del[k].value;
			if(document.form1.del[k].checked==true){
				if (eval("document.form1.sale_unit"+good_id+".options[document.form1.sale_unit"+good_id+".selectedIndex].value == '1'")) {
					var pattern = new Array(
						new Array("F", eval("form1.sale_low"+good_id),"ราคาขาย",eval("form1.sale_low"+good_id), true,"","",10,2));
					if (!checkInput(pattern)) {
						eval("form1.sale_low"+good_id+".focus()");
						return;
					}
				}else if (eval("document.form1.sale_unit"+good_id+".options[document.form1.sale_unit"+good_id+".selectedIndex].value == '2'")) {
					var pattern = new Array(
						new Array("F", eval("form1.sale_high"+good_id),"ราคาขาย",eval("form1.sale_high"+good_id), true,"","",10,2));
					if (!checkInput(pattern)) {
						eval("form1.sale_high"+good_id+".focus()");
						return;
					}
				}else{
					if (!hasInput(eval("form1.sale_unit"+good_id+".value"))){			
						var redObj = new Array(eval("form1.sale_unit"+good_id));
						setErrorColor(redObj);			
						alert("กรุณากรอกหน่วยสินค้า");
						eval("form1.sale_unit"+good_id+".focus()");
						return;
					}		
				}		
			}
		}
		a= confirm("ยืนยัน! ต้องการพิมพ์");
		 if (a==true) {
			 document.form1.action="excel_orders_good.jsp";
			document.form1.submit();
		 }
   }
	function getCalendarInfo(strRtnId, strOpn){
		var dialogUrl = "../libs/calendar.jsp?o_rtnid_hd=" + strRtnId +"&o_opn_hd=" + strOpn ;
		var calendarwin = window.open(dialogUrl,"calendar","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=200, width=160,resizable=0");
		calendarwin.focus();
	}
	function setCalendarInfo(strRtnId, strDate){	
		if (strRtnId == 1) {	
			form1.meet_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.meet_date.value = strDate; 
		}
	}
	function changeunit(aa,sale_low1,sale_high1){
		if (aa.options[aa.selectedIndex].value == "1") {
			eval("document.form1." + sale_low1 + ".disabled=false");
			eval("document.form1."+sale_high1+".disabled=true");
		}else if (aa.options[aa.selectedIndex].value == "2") {
			eval("document.form1." + sale_low1 + ".disabled=true");
			eval("document.form1."+sale_high1+".disabled=false");
		}else{
			eval("document.form1." + sale_low1 + ".disabled=true");
			eval("document.form1."+sale_high1+".disabled=true");		
		}
	}
	function changeclient(aa){
		if (aa.options[aa.selectedIndex].value == "") {
		}else{
			var bb=aa.options[aa.selectedIndex].value;
			form1.meet_date_show.disabled=false;
			form1.action="orders_good.jsp?client_id="+bb;
			form1.submit();
		}
	}
	function changeok(cc,aa,sale_low1,sale_high1){
		if(cc){
			aa.disabled = false;
			if (aa.options[aa.selectedIndex].value == "1") {
				eval("document.form1." + sale_low1 + ".disabled=false");
				if(eval("document.form1."+sale_high1)==null){}else{eval("document.form1."+sale_high1+".disabled=true");}
			}else if (aa.options[aa.selectedIndex].value == "2") {
				eval("document.form1." + sale_low1 + ".disabled=true");
				if(eval("document.form1."+sale_high1)==null){}else{eval("document.form1."+sale_high1+".disabled=false");}
			}else{
				eval("document.form1." + sale_low1 + ".disabled=true");
				if(eval("document.form1."+sale_high1)==null){}else{eval("document.form1."+sale_high1+".disabled=true");}
			}
		}else{
 			aa.disabled = true;
			eval("document.form1." + sale_low1 + ".disabled=true");
				if(eval("document.form1."+sale_high1)==null){}else{eval("document.form1."+sale_high1+".disabled=true");}
		}
	}
	</script>
</head>
<body> 
<font  class="f1">เพิ่มใบสั่งสินค้า</font>
<form  name="form1" method="post">
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr>
		<td align="left" colspan="2">
			<input type="button" name="sm1" value=" พิมพ์ " class="butt"  onclick="print()">
		</td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ใบสั่งสินค้าลงวันที่ *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="meet_date_show" disabled value="<%=meet_date_show%>"><input type="hidden" name="meet_date"  value="<%=meet_date%>">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชื่อลูกค้า *</td>
		<td><select name="client_id" onchange="changeclient(document.form1.client_id)">
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
		<td></td>
		<td></td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" ></td>		
		<td align="center" >ชื่อสินค้า</td>
		<td align="center" >ย่อย : ใหญ่</td>
		<td align="center" >ราคาขาย : หน่วยนับ</td>	
		<td align="center" >ราคาขาย : หน่วยนับย่อย</td>	
		<td align="center" >ราคาขาย : หน่วยนับใหญ่</td>
	</tr>
<%
		if(client_id.equals("")){
		}else{
			ResultSet rs = stmt.executeQuery("(select distinct (d .good_id),g.good_type_id,g.name as name2,t.name as name1 from orders_detail d, orders o,good g,good_type t where o.orders_no = d .orders_no and o.year = d .year and d.good_id=g.good_id and g.good_type_id=t.good_type_id and client_id = '"+client_id+"' ) union( select distinct (d .good_id),g.good_type_id,g.name as name2,t.name as name1 from meet_detail d, meet o,good g,good_type t where o.meet_no = d .meet_no and o.year = d .year and d.good_id=g.good_id and g.good_type_id=t.good_type_id and client_id = '"+client_id+"') ORDER BY `name1` ASC, `name2` ASC");
//out.print("(select distinct (d .good_id),g.good_type_id,g.name as name2,t.name as name1 from orders_detail d, orders o,good g,good_type t where o.orders_no = d .orders_no and o.year = d .year and d.good_id=g.good_id and g.good_type_id=t.good_type_id and client_id = '"+client_id+"' ) union( select distinct (d .good_id),g.good_type_id,g.name as name2,t.name as name1 from meet_detail d, meet o,good g,good_type t where o.meet_no = d .meet_no and o.year = d .year and d.good_id=g.good_id and g.good_type_id=t.good_type_id and client_id = '"+client_id+"') ORDER BY `name1` ASC, `name2` ASC");
			String[] good_id = new String[1000];
			int j = -1;
			while(rs.next()){
				j = j+1;
				good_id[j] = rs.getString(1);
			}
			for(int k=0; k<j+1; k++){

				rs = stmt.executeQuery("(select d.sale,d.sale_unit,o.orders_date as dates,g.name,g.unit_low,g.unit_high,rate,d.orders_no as nos,g.sale_low,g.sale_high from orders_detail d,orders o,good g where o.orders_no=d.orders_no and o.year=d.year and d.good_id=g.good_id and d.good_id='"+good_id[k]+"' and o.client_id='"+client_id+"' ) union( select d.sale,d.sale_unit,o.meet_date as dates,g.name,g.unit_low,g.unit_high,rate,d.meet_no,g.sale_low,g.sale_high from meet_detail d,meet o,good g where o.meet_no=d.meet_no and o.year=d.year and d.good_id=g.good_id and d.good_id='"+good_id[k]+"' and o.client_id='"+client_id+"' order by dates desc)");
//out.print("111");
				if(rs.next()){
					float sale = rs.getFloat(1);
					String sale_unit = rs.getString(2);if(sale_unit==null){sale_unit="";}
					String name = rs.getString(4);
					String unit_low = rs.getString(5);
					String unit_high = rs.getString(6);if(unit_high==null){unit_high="";}
					String rate = rs.getString(7);		
					String sale_low = rs.getString(9);
					String sale_high = rs.getString(10);
					String sale_unit_name="";
					float sale_sale_low=0;
					float sale_sale_high=0;
					String selected1="";
					String selected2="";
					String disabled1="";
					String disabled2="";
					if(sale_unit.equals("1")){
						sale_unit_name = unit_low;
						sale_sale_low = sale;
						selected1 = "selected";
						disabled2 = "disabled";
					}else{
						sale_unit_name = unit_high;
						sale_sale_high = sale;
						selected2 = "selected";
						disabled1 = "disabled";
					}
					String detail="";
					if(unit_high.equals("")){
					}else{
						detail = convertcomma.dtoa(rate,"#,##0.0").concat(" ").concat(unit_low).concat(" ต่อ ").concat(" 1 ").concat(unit_high);
					}
					String background="";
					int bar = k%2;
					if(bar==0){
						background = "tr1";
					} else background = "tr2";
	%>
				<tr class="<%=background%>" ><input type="hidden" name="unit_low<%=good_id[k]%>" value="<%=unit_low%>"><input type="hidden" name="unit_high<%=good_id[k]%>" value="<%=unit_high%>"><input type="hidden" name="rate<%=good_id[k]%>" value="<%=rate%>">
					<td align="center" ><input type="checkbox" name="del" value="<%=good_id[k]%>" onclick="changeok(this.checked,document.form1.sale_unit<%=good_id[k]%>,'sale_low<%=good_id[k]%>','sale_high<%=good_id[k]%>')"></td>
					<td align="left"><%=name%></Td><input type="hidden" name="name<%=good_id[k]%>" value="<%=name%>">
					<td align="center" ><%=detail%></td> 
					<td align="center" ><select name="sale_unit<%=good_id[k]%>"  onchange="changeunit(document.form1.sale_unit<%=good_id[k]%>,'sale_low<%=good_id[k]%>','sale_high<%=good_id[k]%>')" disabled>
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
					</select> </td>	
					<td align="left" ><input type="text" name="sale_low<%=good_id[k]%>" size="5" value="<%=sale_sale_low%>" <%=disabled1%> disabled><%=convertcomma.dtoa(sale_low,"#,##0.0")%> บาท ต่อ <%=unit_low%></td> 
	<%
				if(unit_high.equals("")){
	%>
					<td align="center" ></td> 
	<%
				}else{
	%>
					<td align="left" ><input type="text" name="sale_high<%=good_id[k]%>" size="5" value="<%=sale_sale_high%>"  <%=disabled2%> disabled><%=convertcomma.dtoa(sale_high,"#,##0.0")%> บาท ต่อ <%=unit_high%></td> 
<%
				}		
%>
					
				</tr>
<%
				}
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
 