<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		ResultSet rs1 = stmt.executeQuery("select count(*) from orders o,client c,employee e where o.client_id=c.client_id and o.employee_id=e.employee_id and o.stock='N'");	
		rs1.next();
		String counter = rs1.getString(1);
		rs1.close();
		ResultSet rs = stmt.executeQuery("select o.orders_no,o.year,o.orders_date,c.company_name,c.name,e.first_name,e.last_name from orders o,client c,employee e where o.client_id=c.client_id and o.employee_id=e.employee_id and o.stock='N' order by o.year desc,o.orders_no desc");	
		int N = 20;
		String pages = request.getParameter("pages");if(pages==null){pages="";}
		int numrow = Integer.parseInt(counter);
		int numpage = numrow / N;
		int numpr = numrow % N;
		if(numpr==0){}else{numpage = numpage+1;}
		int currpage=0;
		if (pages == ""){currpage = 1; }else{ currpage = Integer.parseInt(pages);}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
	function gopage(pages) {
		document.formout.action="stock_out.jsp?pages="+pages;
		document.formout.submit();
	}
	function detail(orders_no,year){
		var dialogUrl = "stock_out_detail.jsp?orders_no="+orders_no+"&year="+year;
		var stock_out_detail = window.open(dialogUrl,"stock_out_detail","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=1, height=350, width=550,resizable=0");
		stock_out_detail.focus();
	}
	function stockout() {
		a= confirm("ยืนยัน! ต้องการสินค้าออก");
		 if (a==true) {
			document.formout.action="stock_outadd.jsp";
			document.formout.submit();
		 }
   }
	</script>
</head>
<body> 
<font  class="f1">จัดการสินค้าออก</font><p>
<form name="formout" method="post" >
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="60"><a href="javascript:stockout()">สินค้าออก</td>
		<td align="center" width="100">เลขที่ใบขายสินค้า</td>
		<td align="center" width="80" >ใบสั่งซื้อลงวันที่</td>
		<td align="center" >ชื่อลูกค้า</td>
		<td align="center"  width="100">ชื่อพนักงาน</td>
		<td width="60">&nbsp;</td>
	</tr>
<%
		int i = -1;
		while(rs.next()){
			i = i+1;
			if ((i >= (currpage-1)*N) && (i <= (currpage-1)*N+N-1)){
				String orders_no = rs.getString(1);
				String year = rs.getString(2);
				String orders_date = rs.getString(3);
				String orders_date_show="";
				try{
					orders_date_show = orders_date.substring(6,8)+"/"+orders_date.substring(4,6)+"/"+orders_date.substring(0,4);
				}catch(Exception e){}
				String company_name = rs.getString(4)+"-->"+rs.getString(5);
				String name = rs.getString(6)+"  "+rs.getString(7);
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="center" ><input type="checkbox" name="stock_out" value="<%=orders_no%>"></td>
					<td align="center"><%=orders_no%>/<%=year%><input type="hidden" name="year" value="<%=year%>"></Td>
					<td align="center" ><%=orders_date_show%></td>
					<td align="left" ><%=company_name%></td>  
					<td align="center" ><%=name%></td>
					<td align="center" width="60"><a href="javascript:detail(<%=orders_no%>,<%=year%>)">รายละเอียด</a></td>
				</tr>
<%
			}
		}
%>
	<tr> 
          <td  colspan="6" align="center">
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
</form>
</body>
</html>

<%
		rs.close();
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
 