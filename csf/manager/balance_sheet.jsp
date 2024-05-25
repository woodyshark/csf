<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>
<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	 ResultSet rs = null;
	Date today = new Date();
	int year = 1900+today.getYear();
	int month = today.getMonth();
  	int date  = today.getDate();
	try{
		Statement stmt = con.createStatement();		
		rs = stmt.executeQuery("select sum(d.quantity_stock*d.price) from material_detail d,material m where d.mate_no=m.mate_no and d.year=m.year and d.quantity_stock<>0 and d.trans='N' UNION ALL select sum(d.quantity_stock*d.price) from trans_detail d,trans m where d.trans_no=m.trans_no and d.year=m.year and d.quantity_stock<>0 ");
		float inventory=0;
		while(rs.next()){
			inventory = inventory+rs.getFloat(1);
		}
		rs = stmt.executeQuery("select sum(d.quantity*d.sale) from orders o,orders_detail d where o.orders_no=d.orders_no and o.year=d.year and o.pay='N'");
		float account_receivable=0;
		while(rs.next()){
			account_receivable = account_receivable+rs.getFloat(1);
		}
		rs = stmt.executeQuery("select sum(d.quantity*d.price) from material m,material_detail d where m.mate_no=d.mate_no and m.year=d.year and m.pay='N'");
		float account_payable=0;
		while(rs.next()){
			account_payable = account_payable+rs.getFloat(1);
		}
		String cash = request.getParameter("cash");if(cash==null){cash="";}
		String other_receivable = request.getParameter("other_receivable");if(other_receivable==null){other_receivable="";}
		String debt = request.getParameter("debt");if(debt==null){debt="";}
		String common_stock = request.getParameter("common_stock");if(common_stock==null){common_stock="";}
		float cash1=0;float other_receivable1=0;float debt1=0;float common_stock1=0;float retained_earning=0;
		float total_assets=0;float total_liability=0;
		try{
			cash1 = Float.parseFloat(cash);
			other_receivable1 = Float.parseFloat(other_receivable);
			debt1 = Float.parseFloat(debt);
			common_stock1 = Float.parseFloat(common_stock);
			total_assets = cash1+account_receivable+inventory+other_receivable1;
			retained_earning = total_assets-account_payable-debt1-common_stock1;
			total_liability= account_payable+debt1+common_stock1+retained_earning;
		}catch (Exception e){}

%>
<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function sm(){
		var pattern = new Array(
				new Array("F", form1.cash,"เงินสด", form1.cash, true,"","",10,2),
				new Array("F", form1.other_receivable,"ลูกหนี้อื่นๆ", form1.other_receivable, true,"","",10,2),
				new Array("F", form1.debt,"หนี้สินระยะสั้น", form1.debt, true,"","",10,2),
				new Array("F", form1.common_stock,"ทุน", form1.common_stock, true,"","",10,2));
		if (!checkInput(pattern)) {
			form1.common_stock.focus();
			return;
		}
		form1.action="balance_sheet.jsp";
		form1.submit();
	}
	function cancel(){  
		window.location="balance_sheet.jsp";
	}
</script>
</head>
<body>
<font  class="f1" >งบดุล</font><br>
<form name="form1" method="post">
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr1">
		<td align="right" class="h1">เงินสด</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="cash" value="<%=cash%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ลูกหนี้อื่นๆ</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="other_receivable" value="<%=other_receivable%>"></td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">หนี้สินระยะสั้น</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="debt"  value="<%=debt%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">ทุน</td>
		<td><input type="text" class="txt" size="10" maxlength="10" name="common_stock" value="<%=common_stock%>"> </td>
	</tr>
	<tr class="tr1">
		<td align="center" colspan="2">
			<input type="button" name="sm1" value="    ตกลง   " class="butt" onclick="sm()">
			<input type= "reset"  name="sm2" value="    ยกเลิก   " class="butt" onclick="cancel()">
		</td>
	</tr>
</table>
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr0">
		<td align="center" colspan="4">งบดุล ณ วันที่ <%=date%>/<%=month%>/<%=year%></td>
	</tr>	
	<tr class="tr2">
		<td align="center" colspan="2"  width="50%"><font  class="f1" >สินทรัพย์</td>
		<td align="center" colspan="2"  width="50%"><font  class="f1" >หนี้สิน + ทุน</td>
	</tr>	
	<tr class="tr1">
		<td align="right" width="25%">เงินสด</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(cash1),"#,##0.00")%> บาท</td>
		<td align="right" width="25%">เจ้าหนี้การค้า</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(account_payable),"#,##0.00")%> บาท</td>
	</tr>
	<tr class="tr2">
		<td align="right" width="25%">ลูกหนี้การค้า</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(account_receivable),"#,##0.00")%> บาท</td>
		<td align="right" width="25%">หนี้สินระยะสั้น</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(debt1),"#,##0.00")%> บาท</td>
	</tr>
	<tr class="tr1">
		<td align="right" width="25%">สินค้าคงเหลือ</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(inventory),"#,##0.00")%> บาท</td>
		<td align="right" width="25%">ทุน</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(common_stock1),"#,##0.00")%> บาท</td>
	</tr>
	<tr class="tr2">
		<td align="right" width="25%">ลูกหนี้อื่นๆ</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(other_receivable1),"#,##0.00")%> บาท</td>
		<td align="right" width="25%">กำไรสะสม</td>
		<td align="right" width="25%"><font color="red"><%=convertcomma.dtoa(Float.toString(retained_earning),"#,##0.00")%></font> บาท</td>
	</tr>
	<tr class="tr0">
		<td align="right" width="25%">รวมสินทรัพย์</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(total_assets),"#,##0.00")%> บาท</td>
		<td align="right" width="25%">รวมหนี้สินและทุน</td>
		<td align="right" width="25%"><%=convertcomma.dtoa(Float.toString(total_liability),"#,##0.00")%> บาท</td>
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
