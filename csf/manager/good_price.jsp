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
	<title>Untitled</title>
	<script language="JavaScript">
	function sm() {
		for(k=0; k<document.form1.del.length; k++){
			good_id = document.form1.del[k].value;
			var pattern = new Array(
				new Array("F", eval("form1.price"+good_id),"ราคาซื้อ",eval("form1.price"+good_id), true,"","",10,2));
			if (!checkInput(pattern)) {
				eval("form1.price"+good_id+".focus()");
				return;
			}
			var pattern = new Array(
				new Array("F", eval("form1.sale_low"+good_id),"ราคาขาย",eval("form1.sale_low"+good_id), true,"","",10,2));
			if (!checkInput(pattern)) {
				eval("form1.sale_low"+good_id+".focus()");
				return;
			}
			var pattern = new Array(
				new Array("F", eval("form1.sale_high"+good_id),"ราคาขาย",eval("form1.sale_high"+good_id), true,"","",10,2));
			if (!checkInput(pattern)) {
				eval("form1.sale_high"+good_id+".focus()");
				return;
			}	
		}
		a= confirm("ยืนยัน! ต้องการปรับปรุงราคาสินค้า");
		 if (a==true) {
			document.form1.action="good_pricedata.jsp";
			document.form1.submit();
		 }
   }
	function cancel(){  
		window.location="good_price.jsp";
	}
	</script>
</head>
<body> 
<font  class="f1">จัดการราคาสินค้า</font>
<form  name="form1" method="post">
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr>
		<td align="right" colspan="3">
			<input type="button" name="sm1" value="    จัดการ   " class="butt"  onclick="sm()">
			<input type= "button"  name="sm3" value="    ยกเลิก   " class="butt" onclick="cancel()">
		</td>
	</tr>
</table>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" >ประเภทสินค้า</td>	
		<td align="center" >ชื่อสินค้า</td>
		<td align="center" >ราคาซื้อ : หน่วยนับ</td>	
		<td align="center" >ย่อย : ใหญ่</td>
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
				<tr class="<%=background%>" ><input type="hidden" name="del" value="<%=good_id%>">
					<td align="center"><%=good_type_name%></Td>
					<td align="left"><%=name%></Td>
					<td align="left"><input type="text" name="price<%=good_id%>" size="5" value="<%=price%>"> <%=convertcomma.dtoa(price,"#,##0")%> บาท ต่อ <%=price_unit_name%></Td>					
					<td align="center" ><%=detail%></td> 
					<td align="left" ><input type="text" name="sale_low<%=good_id%>" size="5" value="<%=sale_low%>"> <%=convertcomma.dtoa(sale_low,"#,##0")%> บาท ต่อ <%=unit_low%></td> 
	<%
				if(unit_high.equals("")){
	%>
					<td align="center" ></td> 
	<%
				}else{
	%>
					<td align="left" ><input type="text" name="sale_high<%=good_id%>" size="5" value="<%=sale_high%>"> <%=convertcomma.dtoa(sale_high,"#,##0")%> บาท ต่อ <%=unit_high%></td> 
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
 