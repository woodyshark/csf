<%@ page contentType="text/html;charset=UTF-8"%>

<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String keyword="";String status="";String selected1="";String selected2="";String selected11="";String selected12="";String selected13="";
		String start_dd="";String start_mm="";String start_yy="";
		ResultSet rs=null;String counter="0";
		try{
			keyword = request.getParameter("keyword");
			status = request.getParameter("status"); if(status==null){status="company_name";}		
			String keys = keysearch.search(keyword);
			String where1="";
			if(status.equals("company_name")){
				selected1 = "selected";
				where1 = " and (c.company_name like '"+keys+"' or c.name like '"+keys+"') "; 
			}else if(status.equals("employee_name")){
				selected2 = "selected";
				where1 = " and e.first_name like '"+keys+"' "; 
			}		
			String pay = request.getParameter("pay"); if(pay==null){pay="all";}
			String where2="";
			if(pay.equals("all")){
				selected11 = "selected";
				where2 = " and m.pay like '%' "; 
			}else if(pay.equals("Y")){
				selected12 = "selected";
				where2 = " and m.pay like 'Y' ";
			}else if(pay.equals("N")){
				selected13 = "selected";
				where2 = " and m.pay like 'N' ";
			}
			start_dd = request.getParameter("start_dd"); if(start_dd==null){start_dd="";}
			start_mm = request.getParameter("start_mm"); if(start_mm==null){start_mm="";}
			start_yy = request.getParameter("start_yy"); if(start_yy==null){start_yy="";}	
			String where3 = fromtodate.where(start_dd,start_mm,start_yy,"","","","m.pay_date");
			ResultSet rs1 = stmt.executeQuery("select count(*) from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id "+where1+where2+where3);	
			rs1.next();
			counter = rs1.getString(1);
			rs1.close();
			rs = stmt.executeQuery("select m.mate_no,m.year,m.mate_date,c.company_name,c.name,e.first_name,e.last_name,m.total_discount,m.pay,m.pay_date from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id "+where1+where2+where3+" order by m.year desc,m.mate_no desc");	
		}catch (Exception e){if(keyword==null){keyword="";}}
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
		document.form1.action="material_account.jsp?pages="+pages;
		document.form1.submit();
	}
	function detail(mate_no,year){
		window.location="../factory/material_detail.jsp?mate_no="+mate_no+"&year="+year;
	}
	function paymoney(mate_no,year){
		window.location="material_pay.jsp?mate_no="+mate_no+"&year="+year;
	}
	</script>
</head>
<body> 
<font  class="f1">บัญชีใบสั่งซื้อวัตถุดิบ-สินค้า</font>
<form action="material_account.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="center">
				<strong>ค้นหา</strong> <input type="Text" class="txt" size="15" name="keyword" value="<%=keyword%>">
				<strong>โดย</strong> 
				<select name="status" >
					<option value="company_name" <%=selected1%>>ชื่อผู้ผลิต</option>
					<option value="employee_name" <%=selected2%>>ชื่อพนักงาน</option>
				</select><strong> รูปแบบการจ่ายเงิน </strong>
				<select name="pay" >
					<option value="all" <%=selected11%>>ทั้งหมด</option>
					<option value="Y" <%=selected12%>>จ่ายแล้ว</option>
					<option value="N" <%=selected13%>>ยังไม่จ่าย</option>
				</select>
				<strong>วันที่จ่ายเงิน</strong> <input type="Text" class="txt" size="2" maxlength="2" name="start_dd" value="<%=start_dd%>"> /  <input type="Text" class="txt" size="2" maxlength="2" name="start_mm" value="<%=start_mm%>"> / <input type="Text" class="txt" size="4" maxlength="4" name="start_yy" value="<%=start_yy%>">  
				<input type="submit" value="  ค้นหา  " class="butt">
			</td>
		</tr>	 
	</table>
</form> 
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="10%">เลขที่ใบสั่งซื้อ</td>
		<td align="center"  width="12%" >ใบสั่งซื้อลงวันที่</td>
		<td align="center" width="32%" >ชื่อผู้ผลิต</td>
		<td align="center" width="12%" >ชื่อพนักงาน</td>
		<td align="center" width="8%">ยอดเงิน</td>
		<td align="center" width="8%">สถานะ</td>
		<td align="center" width="10%">วันที่จ่ายเงิน</td>
		<td width="8%">&nbsp;</td>
	</tr>
<%
		try{
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
					String total = rs.getString(8);
					String pays = rs.getString(9);
					String pay_date = rs.getString(10);
					String pay_date_show="";int pays_dates=0;
					try{
						pays_dates = Integer.parseInt(pay_date);
						pay_date_show = pay_date.substring(6,8)+"/"+pay_date.substring(4,6)+"/"+pay_date.substring(0,4);
					}catch(Exception e){}
					int today_dates = fromtodate.today();
					String color="";
					if(pays_dates>=today_dates){
						color = "red";
					}else{
						color = "";
					}
					String background="";
					int bar = i%2;
					if(bar==0){
						background = "tr1";
					} else background = "tr2";
	%>	
				<tr class="<%=background%>" >
					<td align="center"><%=mate_no%>/<%=year%></Td>
					<td align="center" ><%=mate_date_show%></td>
					<td align="left" ><%=company_name%></td>  
					<td align="center" ><%=name%></td>
					<td align="right" ><%=convertcomma.dtoa(total,"#,##0.00")%></td>
<%
					if(pays.equals("N")){
%>
					<td align="center"><a href="javascript:paymoney(<%=mate_no%>,<%=year%>)">จ่ายเงิน</a></td>
<%
					}else{
%>
					<td align="center">จ่ายแล้ว</td>
<%
					}
%>					
					<td align="center"><font color="<%=color%>"><%=pay_date_show%></font></td>
					<td align="center"><a href="javascript:detail(<%=mate_no%>,<%=year%>)">รายละเอียด</a></td>
				</tr>
<%
				}
			}
		}catch (Exception e){}
%>
	<tr> 
          <td  colspan="8" align="center">
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
 