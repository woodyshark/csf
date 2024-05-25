<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String keyword="";String status="";String selected1="";String selected2="";
		ResultSet rs=null;String counter="0";
		String[] mate_nos = new String[1000];
		String[] years = new String[1000];
		String[] types = new String[1000];
		int j = -1;
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
			int today_dates = fromtodate.today();
			rs = stmt.executeQuery("(select s.mate_no, s.year, 'pay' from stock_mate s, client c, orders o where s.client_id = c.client_id and concat(trim(o.orders_no),'/',o.year)  = s.orders_no_year and ((o.pay='y' and o.pay_date>'"+today_dates+"') or o.pay = 'n')) union all select t .mate_no, t .year, 'pay' from stock_tran s, client c, trans t, good g, orders o where s.client_id = c.client_id and s.trans_no = t .trans_no and s.year = t .year and s.good_id = g.good_id and concat(trim(o.orders_no),'/',o.year)  = s.orders_no_year and ((o.pay='y' and o.pay_date>'"+today_dates+"') or o.pay = 'n') union all select d .mate_no, d .year, 'stock' from material_detail d, good g where d .quantity_stock <> 0 and d .good_id = g.good_id and g.trans = 'n' union all select t .mate_no, t .year_mate, 'stock' from trans_detail d, good g, trans t where d .quantity_stock <> 0 and d .good_id = g.good_id and g.trans = 'n' and d .trans_no = t .trans_no and d .year = t .year union all (select d .mate_no, d .year, 'stock' from material_detail d where d .trans_fin = 'n' and d .trans = 'y')");
			while(rs.next()){
				j = j+1;
				 mate_nos[j] = rs.getString(1);
				years[j] = rs.getString(2);
				types[j] = rs.getString(3);
			}
			ResultSet rs1 = stmt.executeQuery("select count(*) from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id "+where1);	
			rs1.next();
			counter = rs1.getString(1);
			rs1.close();
			rs = stmt.executeQuery("select m.mate_no,m.year,m.mate_date,c.company_name,c.name,e.first_name,e.last_name,m.pay,m.total_discount from material m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id "+where1+" order by m.year desc,m.mate_no desc");	
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
		document.form1.action="good_who.jsp?pages="+pages;
		document.form1.submit();
	}
	function detail(mate_no,year){
		window.location="good_whodetail.jsp?mate_no="+mate_no+"&year="+year;
	}
	</script>
</head>
<body> 
<font  class="f1">ค้นหาสินค้าอยู่ที่ใคร</font>
<form action="good_who.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="center">
				<strong>ค้นหา</strong> <input type="Text" class="txt" size="15" name="keyword" value="<%=keyword%>">
				<strong>โดย</strong> 
				<select name="status" >
					<option value="company_name" <%=selected1%>>ชื่อผู้ผลิต</option>
					<option value="employee_name" <%=selected2%>>ชื่อพนักงาน</option>
				</select>
				<input type="submit" value="  ค้นหา  " class="butt">
			</td>
		</tr>	 
	</table>
</form> 
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" width="12%">เลขที่ใบสั่งซื้อ</td>
		<td align="center"  width="12%">ใบสั่งซื้อลงวันที่</td>
		<td align="center" width="38%">ชื่อผู้ผลิต</td>
		<td align="center" width="8%">สินค้าคลัง</td>
		<td align="center" width="7%" >การเงิน</td>
		<td align="center"  width="8%">ยอดเงิน</td>
		<td align="center" width="7%">สถานะ</td>
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
					String texts="";
					for(int k=0;k<=j;k++){
						if(mate_no.equals(mate_nos[k]) && year.equals(years[k])  && types[k].equals("stock")){
							texts = "<font color=\"red\">มี</font>";
							break;
						}else{
							texts = "ไม่มี";
						}
					}
					String pay_texts="";
					for(int k=0;k<=j;k++){
						if(mate_no.equals(mate_nos[k]) && year.equals(years[k])  && types[k].equals("pay")){
							pay_texts = "<font color=\"red\">ไม่ครบ</font>";
							break;
						}else{
							pay_texts = "ครบแล้ว";
						}
					}
					String mate_date = rs.getString(3);
					String mate_date_show="";
					try{
						mate_date_show = mate_date.substring(6,8)+"/"+mate_date.substring(4,6)+"/"+mate_date.substring(0,4);
					}catch(Exception e){}
					String company_name = rs.getString(4)+"-->"+rs.getString(5);
					String name = rs.getString(6)+"  "+rs.getString(7);
					String pay = rs.getString(8);
					String total_discount = rs.getString(9);
					String pay_names="";
					if(pay.equals("N")){
						pay_names = "<font color=\"red\">ยังไม่จ่าย</font>";
					}else{
						pay_names = "จ่ายแล้ว";
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
					<td align="center" ><%=texts%></td>
					<td align="center" ><%=pay_texts%></td>
					<td align="right" ><%=convertcomma.dtoa(total_discount,"#,##0.00")%></td>
					<td align="center" ><%=pay_names%></td>
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
 