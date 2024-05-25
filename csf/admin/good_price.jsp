<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String good_id = request.getParameter("good_id");
		ResultSet rs = stmt.executeQuery("select name,unit_low,unit_high,rate from good where good_id='"+good_id+"'");	
		rs.next();
		String name = rs.getString(1);
		String unit_low = rs.getString(2);
		String unit_high = rs.getString(3);
		String rate = rs.getString(4);
		rs.close();
%>

<html>
<title>จัดการราคาสินค้า</title>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function sm(){	
		if (!hasInput(form1.good_date.value)){			
			var redObj = new Array(form1.good_date_show);
			setErrorColor(redObj);			
			alert("กรุณากรอกวันที่เริ่มใช้ราคา");
			form1.date_butt1.focus();
			return;
		}		
		var pattern = new Array(
				new Array("F", form1.price,"ราคาซื้อ", form1.price, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.price.focus();
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
		var pattern = new Array(
				new Array("F", form1.sale_low,"ราคาขายต่อ<%=unit_low%>", form1.sale_low, true,"","",10,2),
				new Array("F", form1.sale_high,"ราคาขายต่อ<%=unit_high%>", form1.sale_high, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.sale_low.focus();
			return;
		}
		form1.action = "good_pricedata.jsp?good_id=<%=good_id%>";
		form1.submit();
	}
	function cancel(){  
 		window.close();
	}
	function getCalendarInfo(strRtnId, strOpn){
		var dialogUrl = "../libs/calendar.jsp?o_rtnid_hd=" + strRtnId +"&o_opn_hd=" + strOpn ;
		var calendarwin = window.open(dialogUrl,"calendar","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=200, width=160,resizable=0");
		calendarwin.focus();
	}
	function setCalendarInfo(strRtnId, strDate){	
		if (strRtnId == 1) {	
			form1.good_date_show.value = strDate.substring(6,8)+"/"+strDate.substring(4,6)+"/"+strDate.substring(0,4); 
			form1.good_date.value = strDate; 
		}
	}
	function gopage(pages) {
		document.form1.action="good_price.jsp?good_id=<%=good_id%>&pages="+pages;
		document.form1.submit();
	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มราคาสินค้า-------><%=name%></font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr1">
		<td align="right" class="h1">วันที่เริ่มใช้ราคา *</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="good_date_show" disabled><input type="hidden" name="good_date">  <input type="button" name="date_butt1" class="butt" value="..." onClick="getCalendarInfo(1,'opener')"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ราคาซื้อ *</td>
		<td><input type="text" class="txt" size="10" maxlength="15" name="price" > ต่อ 
			<select name="price_unit">
<%
		if(unit_high.equals("")){
%>
					<option value="1"><%=unit_low%></option>
<%
		}else{
%>
					<option value="">กรุณาเลือก</option>
					<option value="1"><%=unit_low%></option>
					<option value="2"><%=unit_high%></option>
<%
		}	
%>
			</select>
		</td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">ราคาขายต่อ<%=unit_low%> *</td>
		<td><input type="text" class="txt" size="10" maxlength="15" name="sale_low" > </td>
	</tr>
<%
		if(unit_high.equals("")){
		}else{
%>
	<tr class="tr1">
		<td align="right" class="h1">ราคาขายต่อ<%=unit_high%> *</td> 
		<td><input type="text" class="txt" size="10" maxlength="15" name="sale_high"> <%=rate%> <%=unit_low%> ต่อ 1 <%=unit_high%> </td>
	</tr>
<%
		}	
%>
	<tr class="tr2">
		<td align="right" class="h1">หมายเหตุ</td>
		<td><input type="text" class="txt" size="30" maxlength="1000" name="comment" > </td>
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
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="90">วันที่เริ่มใช้สินค้า</td>
		<td align="center"  width="50">ราคาซื้อ</td>
		<td align="center"  width="85">ราคาขายต่อ <%=unit_low%></td>
<%
				if(unit_high.equals("")){	
				}else{
%>	
		<td align="center"  width="85">ราคาขายต่อ <%=unit_high%></td>
<%
				}	
%>
		<td align="center"  width="80">หมายเหตุ</td>
	</tr>
<%
		ResultSet rs1 = stmt.executeQuery("select count(*) from good_price where good_id='"+good_id+"'");	
		rs1.next();
		String counter = rs1.getString(1);
		rs1.close();
		int N = 5;
		String pages = request.getParameter("pages");if(pages==null){pages="";}
		int numrow = Integer.parseInt(counter);
		int numpage = numrow / N;
		int numpr = numrow % N;
		if(numpr==0){}else{numpage = numpage+1;}
		int currpage=0;
		if (pages == ""){currpage = 1; }else{ currpage = Integer.parseInt(pages);}
		rs = stmt.executeQuery("select good_date,price,price_unit,sale_low,sale_high,comment from good_price where good_id='"+good_id+"' order by good_date desc");		
		int i = -1;
		while(rs.next()){
			i = i+1;
			if ((i >= (currpage-1)*N) && (i <= (currpage-1)*N+N-1)){
				String good_date = rs.getString(1);
				String good_date_show="";
				try{
					 good_date_show = good_date.substring(6,8)+"/"+good_date.substring(4,6)+"/"+good_date.substring(0,4);
				}catch(Exception e){}
				String price = rs.getString(2);
				String price_unit = rs.getString(3);
				String price_unit_name="";
				if(price_unit.equals("1")){
					price_unit_name = unit_low;
				}else{
					price_unit_name = unit_high;
				}
				String sale_low = rs.getString(4);
				String sale_high = rs.getString(5);
				String comment = rs.getString(6);
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
%>	
				<tr class="<%=background%>" >
					<td align="center"><%=good_date_show%></Td>
					<td align="right" ><%=convertcomma.dtoa(price,"#,##0")%> : <%=price_unit_name%></td>
					<td align="right" ><%=convertcomma.dtoa(sale_low,"#,##0")%> : <%=unit_low%></td>
<%
				if(unit_high.equals("")){	
				}else{
%>	
					<td align="right" ><%=convertcomma.dtoa(sale_high,"#,##0")%> : <%=unit_high%></td>
<%
				}	
%>
					<td align="center" ><%=comment%></td>  
				</tr>
<%
			}
		}
		rs.close();
%>
	<tr> 
          <td  colspan="5" align="center">
<%
		if (numpage > 0){out.println("<B>หน้าที่</B> &nbsp");}else{ out.println("ไม่พบรายการที่ค้นหา<BR>");}
		for(int k = 1;k<= numpage;k++){
			if(k != currpage){out.print("<a href='javascript:gopage(" + k + ")'>" + k +"</a>");}else{out.print(k);}
			if (k != numpage){ out.print(" | ");}
		}
%>
            </td>
		</tr>
</table>
</body>
</html>

<%
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
