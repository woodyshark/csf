<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		ResultSet rs1 = stmt.executeQuery("select count(*) from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and m.stock='N'");	
		rs1.next();
		String counter = rs1.getString(1);
		rs1.close();
		ResultSet rs = stmt.executeQuery("select m.mate_no,m.year,m.mate_date,c.company_name,c.name,e.first_name,e.last_name from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and m.stock='N' order by m.year desc,m.mate_no desc");	
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
		document.formin.action="stock_in.jsp?pages="+pages;
		document.formin.submit();
	}
	function detail(mate_no,year){
		var dialogUrl = "stock_in_detail.jsp?mate_no="+mate_no+"&year="+year;
		var material_detail = window.open(dialogUrl,"material_detail","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=1, height=300, width=550,resizable=0");
		material_detail.focus();
	}
	function stockin() {
		a= confirm("ยืนยัน! ต้องการสินค้าเข้า");
		 if (a==true) {
			document.formin.action="stock_inadd.jsp";
			document.formin.submit();
		 }
   }
	</script>
</head>
<body> 
<font  class="f1">จัดการสินค้าเข้า</font><p>
<form name="formin" method="post" >
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" width="60" ><a href="javascript:stockin()">สินค้าเข้า</td>
		<td align="center" width="80">เลขที่ใบสั่งซื้อ</td>
		<td align="center" width="80" >ใบสั่งซื้อลงวันที่</td>
		<td align="center" >ชื่อผู้ผลิต</td>
		<td align="center"  width="100">ชื่อพนักงาน</td>
		<td width="60">&nbsp;</td>
	</tr>
<%
		int i = -1;
		while(rs.next()){
			i = i+1;
			if ((i >= (currpage-1)*N) && (i <= (currpage-1)*N+N-1)){
				String mate_no = rs.getString(1);
				String year = rs.getString(2);
				String mate_date = rs.getString(3);
				String mate_date_show="";
				try{
					mate_date_show = mate_date.substring(6,8)+"/"+mate_date.substring(4,6)+"/"+mate_date.substring(0,4);
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
					<td align="center" ><input type="checkbox" name="stockin" value="<%=mate_no%>/<%=year%>"></td>
					<td align="center"><%=mate_no%>/<%=year%></Td>
					<td align="center" ><%=mate_date_show%></td>
					<td align="left" ><%=company_name%></td>  
					<td align="center" ><%=name%></td>
					<td align="center" width="60"><a href="javascript:detail(<%=mate_no%>,<%=year%>)">รายละเอียด</a></td>
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
 