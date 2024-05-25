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
		String next_date = request.getParameter("next_date");if(next_date==null){next_date="";}
		String next_date_show = request.getParameter("next_date_show");if(next_date_show==null){next_date_show="";}
		String question = request.getParameter("question");if(question==null){question="";}
		String solution = request.getParameter("solution");if(solution==null){solution="";}
		String comment = request.getParameter("comment");if(comment==null){comment="";}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
	function add() {
		if (!hasInput(form1.meet_date.value)){			
			var redObj = new Array(form1.meet_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกใบเสนอราคาลงวันที่");
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
		a= confirm("ยืนยัน! ต้องการเพิ่ม");
		 if (a==true) {
			document.form1.action="meet_add2data.jsp";
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
		}else if (strRtnId == 2) {	
			form1.next_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.next_date.value = strDate; 
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
<font  class="f1">เพิ่มใบเสนอราคา</font>
<form  name="form1" method="post">
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr1">
		<td align="right" class="h1">ใบเสนอราคาลงวันที่ *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="meet_date_show" disabled value="<%=meet_date_show%>"><input type="hidden" name="meet_date"  value="<%=meet_date%>">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ชื่อลูกค้า *</td>
		<td><select name="client_id">
					<option value="">กรุณาเลือก</option>
					<option value="0">ใบเสนอราคามาตราฐาน</option>
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
		<td align="right" class="h1">ปัญหา</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="question"  value="<%=question%>"> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">วิธีแก้ไข</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="solution"  value="<%=solution%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><input type="text" class="txt" size="50" maxlength="1000" name="comment"  value="<%=comment%>"> </td>
	</tr>
	<tr class="tr1">
		<td></td>
		<td></td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" ><a href="javascript:add()"><font color="red">เพิ่ม</td>		
		<td align="center" >ประเภทสินค้า</td>	
		<td align="center" >ชื่อสินค้า</td>
		<td align="center" >ย่อย : ใหญ่</td>
		<td align="center" >หน่วยนับ</td>	
		<td align="center" >ราคาขาย : หน่วยนับย่อย</td>	
		<td align="center" >ราคาขาย : หน่วยนับใหญ่</td>
	</tr>
<%
		ResultSet rs = stmt.executeQuery("select g.good_id,g.name,g.unit_low,g.unit_high,g.rate,g.trans,t.name,g. price,g.price_unit,g.sale_low,g.sale_high from good g,good_type t where g.good_type_id=t.good_type_id and g.trans='N' order by t.name,g.name");	
		int i = -1;
		while(rs.next()){
			i = i+1;
				String good_id = rs.getString(1);
				String name = rs.getString(2);
				String unit_low = rs.getString(3);
				String unit_high = rs.getString(4);if(unit_high==null){unit_high="";}
				String rate = rs.getString(5);
				String transs = rs.getString(6);
				String good_type_name = rs.getString(7);
				String price = rs.getString(8);
				String price_unit = rs.getString(9); if(price_unit==null){price_unit="";}
				String price_unit_name="";
				if(price_unit.equals("1")){
					price_unit_name = unit_low;
				}else{
					price_unit_name = unit_high;
				}
				String sale_low = rs.getString(10);
				String sale_high = rs.getString(11);
				String detail="";
				if(unit_high.equals("")){
				}else{
					detail = convertcomma.dtoa(rate,"#,##0.0").concat(" ").concat(unit_low).concat(" ต่อ ").concat(" 1 ").concat(unit_high);
				}
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="center" ><input type="checkbox" name="del" value="<%=good_id%>" onclick="changeok(this.checked,document.form1.sale_unit<%=good_id%>,'sale_low<%=good_id%>','sale_high<%=good_id%>')"></td>
					<td align="center"><%=good_type_name%></Td>
					<td align="left"><%=name%></Td>
					<td align="center" ><%=detail%></td> 
					<td align="center" ><select name="sale_unit<%=good_id%>"  onchange="changeunit(document.form1.sale_unit<%=good_id%>,'sale_low<%=good_id%>','sale_high<%=good_id%>')" disabled>
<%
		String disabled1="";
		if(unit_high.equals("")){
%>
						<option value="1"><%=unit_low%></option>
<%
		}else{
			disabled1 = "disabled";
%>
						<option value="">กรุณาเลือก</option>
						<option value="1" ><%=unit_low%></option>
						<option value="2" selected><%=unit_high%></option>
<%
		}	
%>
					</select> </td>	
					<td align="left" ><input type="text" name="sale_low<%=good_id%>" size="5" value="<%=sale_low%>" <%=disabled1%> disabled><%=convertcomma.dtoa(sale_low,"#,##0.0")%> บาท ต่อ <%=unit_low%></td> 
	<%
				if(unit_high.equals("")){
	%>
					<td align="center" ></td> 
	<%
				}else{
	%>
					<td align="left" ><input type="text" name="sale_high<%=good_id%>" size="5" value="<%=sale_high%>" disabled><%=convertcomma.dtoa(sale_high,"#,##0.0")%> บาท ต่อ <%=unit_high%></td> 
<%
				}		
%>
					
				</tr>
<%
			}
%>
	</table>
</form> 
</body>
</html>

<%
		rs.close();
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
 