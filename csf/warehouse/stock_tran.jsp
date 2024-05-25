<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		ResultSet rs1 = stmt.executeQuery("select count(*) from trans t,employee e,material m,client c,good g where t.employee_id=e.employee_id and t.mate_no=m.mate_no and m.client_id=c.client_id and t.year_mate=m.year and t.good_id=g.good_id and t.stock='N'");	
		rs1.next();
		String counter = rs1.getString(1);
		rs1.close();
		ResultSet rs = stmt.executeQuery("select t.trans_no,t.year,t.trans_date,t.mate_no,e.first_name,e.last_name,c.company_name,g.name,t.quantity,t.year_mate from trans t,employee e,material m,client c,good g where t.employee_id=e.employee_id and t.mate_no=m.mate_no and m.client_id=c.client_id and t.year_mate=m.year and t.good_id=g.good_id and t.stock='N' order by t.year desc,t.trans_no desc");
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
		document.formin.action="stock_tran.jsp?pages="+pages;
		document.formin.submit();
	}
	function detail(trans_no,year){
		var dialogUrl = "stock_tran_detail.jsp?trans_no="+trans_no+"&year="+year;
		var stock_in_tran_detail = window.open(dialogUrl,"stock_in_tran_detail","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=400, width=550,resizable=0");
		stock_in_tran_detail.focus();
	}
	function stockin() {
		a= confirm("ยืนยัน! ต้องการสินค้าเข้า");
		 if (a==true) {
			document.formin.action="stock_tranadd.jsp";
			document.formin.submit();
		 }
   }
	</script>
</head>
<body> 
<font  class="f1">จัดการสินค้าแปรรูปเข้า</font><p>
<form name="formin" method="post" >
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" width="60" ><a href="javascript:stockin()">สินค้าเข้า</td>
		<td align="center"  width="80">เลขที่วัตถุดิบ</td>
		<td align="center"  width="80">วัตถุดิบลงวันที่</td>
		<td align="center"  width="80">เลขที่ใบสั่งซื้อ</td>
		<td align="center" >ชื่อผู้ผลิต</td>
		<td align="center" width="100">สินค้า</td>
		<td align="center"  width="60">จำนวน</td>
		<td align="center">ชื่อพนักงาน</td>
		<td width="60">&nbsp;</td>
	</tr>
<%
		int i = -1;
		while(rs.next()){
			i = i+1;
			if ((i >= (currpage-1)*N) && (i <= (currpage-1)*N+N-1)){
					String trans_no = rs.getString(1);
					String year = rs.getString(2);
					String trans_dates = rs.getString(3);
					String trans_date_shows="";
					try{
						trans_date_shows = trans_dates.substring(6,8)+"/"+trans_dates.substring(4,6)+"/"+trans_dates.substring(0,4);
					}catch(Exception e){}
					String mate_no = rs.getString(4);
					String name = rs.getString(5)+"  "+rs.getString(6);		
					String company_name = rs.getString(7);
					String good_name = rs.getString(8);
					float quantity = rs.getFloat(9);
					String year_mate = rs.getString(10);
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="center" ><input type="checkbox" name="stockin" value="<%=trans_no%>/<%=year%>"></td>
					<td align="center"><%=trans_no%>/<%=year%></Td>
					<td align="center" ><%=trans_date_shows%></td>
					<td align="center" ><%=mate_no%>/<%=year_mate%></td>  
					<td align="left" ><%=company_name%></td>				
					<td align="left" ><%=good_name%></td>			
					<td align="right" ><%=quantity%></td>	
					<td align="center" ><%=name%></td>	
					<td align="center" width="60"><a href="javascript:detail(<%=trans_no%>,<%=year%>)">รายละเอียด</a></td>
				</tr>
<%
			}
		}
%>
	<tr> 
          <td  colspan="9" align="center">
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
		rs.close();
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
 