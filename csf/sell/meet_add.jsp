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
		String disabled="";
		if(request.getParameter("good_id") != null){
			disabled = "disabled";
		}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function addgood(){	
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
		data=document.form1.client_id.options[document.form1.client_id.selectedIndex].value;
		var dialogUrl = "meet_addgood.jsp?client_id="+data;
		var meet_addgood = window.open(dialogUrl,"meet_addgood","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=250, width=400,resizable=0");
		meet_addgood.focus();
	}
	function addmeet(){	
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
		data=document.form1.client_id.options[document.form1.client_id.selectedIndex].value;
		var dialogUrl = "meet_addmeet.jsp?client_id="+data;
		var meet_addmeet = window.open(dialogUrl,"meet_addmeet","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=1, height=250, width=560,resizable=0");
		meet_addmeet.focus();
	}
	function adddetail(good_id,good_name,sale,price_unit,price_unit_name,rate,unit_low,unit_high) {
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
		form1.meet_date_show.disabled=false;
		form1.next_date_show.disabled=false;	
		form1.client_id.disabled=false;	
		arrayOfObj = price_unit_name.split("(");		
		price_unit_names = arrayOfObj[0];
		form1.action="meet_add.jsp?good_id="+good_id+"&good_name="+good_name+"&sale="+sale+"&price_unit="+price_unit+"&price_unit_name="+price_unit_names+"&rate="+rate+"&unit_low="+unit_low+"&unit_high="+unit_high;
		form1.submit();
	}
	function adddetail2(doc2) {		
		form1.meet_date_show.disabled=false;
		form1.next_date_show.disabled=false;	
		form1.client_id.disabled=false;	
		form1.action="meet_add.jsp?"+doc2;
		form1.submit();
	}
	function sm(){
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
		form1.client_id.disabled=false;		
		form1.action="meet_adddata.jsp";
		form1.submit();
	}
	function del(){  
		window.location="meet_add.jsp";
	}
	function cancel(){  
		window.location="meet_search.jsp";
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
</script>
</head>
<body>
<font  class="f1" >เพิ่มใบเสนอราคา</font><br>
<form name="form1" method="post"  >
<table  width="100%"  cellpadding="3" cellspacing="2" border="0">
	<tr class="tr1">
		<td align="right" class="h1">ใบเสนอราคาลงวันที่ *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="meet_date_show" disabled value="<%=meet_date_show%>"><input type="hidden" name="meet_date"  value="<%=meet_date%>">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
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
		<td ></td>
		<td align="right">
			<input type="button" name="sm1" value=" คัดลอกใบเสนอราคา " class="butt"  onclick="addmeet()" <%=disabled%>><input type="button" name="sm1" value=" เพิ่มรายการสินค้า " class="butt"  onclick="addgood()">
		</td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="30%">รายการสินค้า</td>
		<td align="center">รายละเอียดการบรรจุ</td>
		<td align="center"  width="30%">ราคาขาย</td>
	</tr>
<%	
		if(request.getParameter("good_id") != null){
			String[] good_id= request.getParameterValues("good_id");
			String[] good_name= request.getParameterValues("good_name");
			String[] sale= request.getParameterValues("sale");
			String[] price_unit= request.getParameterValues("price_unit");
			String[] price_unit_name= request.getParameterValues("price_unit_name");
			String[] rate= request.getParameterValues("rate");	
			String[] unit_low= request.getParameterValues("unit_low");
			String[] unit_high= request.getParameterValues("unit_high");	
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					String detail="";
					if(unit_high[k].equals("")){
					}else{
						detail = rate[k].concat(" ").concat(unit_low[k]).concat(" ต่อ ").concat(" 1 ").concat(unit_high[k]);
					}
					String background="";
					int bar = k%2;
					if(bar==0){
						background = "tr1";
					} else background = "tr2";
%>
	<tr class="<%=background%>" ><input type="hidden" name="price_unit_name"  value="<%=price_unit_name[k]%>"><input type="hidden" name="price_unit"  value="<%=price_unit[k]%>"><input type="hidden" name="rate"  value="<%=rate[k]%>"><input type="hidden" name="unit_low"  value="<%=unit_low[k]%>"><input type="hidden" name="unit_high"  value="<%=unit_high[k]%>">
		<td align="left" ><input type="hidden" name="good_id"  value="<%=good_id[k]%>" ><input type="hidden" name="good_name"  value="<%=good_name[k]%>" ><%=good_name[k]%></td>
		<td align="center"><%=detail%></td>
		<td align="left" ><input type="text" name="sale" size="5" value="<%=sale[k]%>"><%=convertcomma.dtoa(sale[k],"#,##0.00")%> บาท ต่อ <%=price_unit_name[k]%></td>	</tr>
<%
				}
%>
	<tr>
		<td align="center" colspan="3">
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
