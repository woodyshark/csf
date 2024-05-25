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
		function sm(){
		if(document.all.datarow == null){
		}else{
			if (document.all.datarow.length) {	 
				for(i=0;i<document.all.datarow.length;i++){
					var pattern = new Array(
							new Array("F", form1.quantity_stock[i],"กรุณากรอกจำนวนสินค้าคงเหลือ", form1.quantity_stock[i], true,"","",5,2));
					if (!checkInput(pattern)) {
						form1.quantity_stock[i].focus();
						return;
					}
				}
			} else {	
				var pattern = new Array(
							new Array("F", form1.quantity_stock,"กรุณากรอกจำนวนสินค้าคงเหลือ", form1.quantity_stock, true,"","",5,2));
				if (!checkInput(pattern)) {
					form1.quantity_stock.focus();
				return;
				}
			}	
		}
		form1.action="stock_managedata.jsp";
		form1.submit();
	}
	function cancel(){  
		window.location="stock_manage.jsp";
	}
</script>
</head>
<body> 
<font  class="f1">จัดการสินค้าคงเหลือ</font>
<form name="form1" method="post"  >
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" ></td>
		<td align="center" >เลขที่ใบสั่งซื้อ</td>
		<td align="center" >ชื่อสินค้า</td>
		<td align="center">จำนวนสินค้า</td>
		<td align="center" >จำนวนสินค้าคงเหลือ</td>
	</tr>
<%
		ResultSet rs = stmt.executeQuery("(select d .mate_no as no, d .year, d .good_id, g.name, d .quantity,d .quantity_stock,'mate_no',d.price_unit,g.unit_low,g.unit_high,g.rate,g.good_type_id from material_detail d, good g where d .quantity_stock <> 0 and d .good_id = g.good_id and g.trans = 'n') union all (select d .trans_no as no, d .year, d .good_id, g.name, d .quantity,d .quantity_stock,'trans_no',d.price_unit,g.unit_low,g.unit_high,g.rate,g.good_type_id from trans_detail d, good g where d .quantity_stock <> 0 and d .good_id = g.good_id and g.trans = 'n') ORDER BY `good_type_id` ASC, `good_id` ASC, `no` ASC");
		int i = -1;
		while(rs.next()){
			i = i+1;
			String mate_no = rs.getString(1);
			String year = rs.getString(2);
			String good_id = rs.getString(3);
			String name = rs.getString(4);
			float quantity = rs.getFloat(5);
			float quantity_stock = rs.getFloat(6);
			String type = rs.getString(7);
			String price_unit = rs.getString(8);
			String unit_low = rs.getString(9);
			String unit_high = rs.getString(10);
			String rate = rs.getString(11);
			String price_unit_name="";
			if(price_unit.equals("1")){
					price_unit_name = unit_low;
				}else{
					price_unit_name = unit_high;
				}
			String background="";
			int bar = i%2;
			if(bar==0){
				background = "tr1";
			} else background = "tr2";
	%>
				<tr  id="datarow" class="<%=background%>" >
					<td align="center"><%=type%><input type="hidden" name="type"  value="<%=type%>"></Td>					
					<td align="center"><%=mate_no%>/<%=year%><input type="hidden" name="mate_no"  value="<%=mate_no%>"><input type="hidden" name="year"  value="<%=year%>"></Td>
					<td align="left" ><%=name%><input type="hidden" name="good_id"  value="<%=good_id%>"></td>  
					<td align="left" ><%=convertcomma.dtoa(Float.toString(quantity),"#,##0.0")%> <%=price_unit_name%><input type="hidden" name="quantity"  value="<%=convertcomma.dtoa(Float.toString(quantity),"#,##0.0")%>"><input type="hidden" name="price_unit"  value="<%=price_unit%>"><input type="hidden" name="unit_low"  value="<%=unit_low%>"><input type="hidden" name="unit_high"  value="<%=unit_high%>"><input type="hidden" name="rate"  value="<%=rate%>"></td>
					<td align="left" ><input type="text" class="txt" name="quantity_stock" size="6"  value="<%=convertcomma.dtoa(Float.toString(quantity_stock),"###0.0")%>">  <%=price_unit_name%></td>  
				</tr>
<%
		}
%>
	<tr>
		<td align="center" colspan="5">
			<input type="button" name="sm1" value="    จัดการ   " class="butt"  onclick="sm()">
			<input type= "button"  name="sm3" value="    ยกเลิก   " class="butt" onclick="cancel()">
		</td>
	</tr>
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
 