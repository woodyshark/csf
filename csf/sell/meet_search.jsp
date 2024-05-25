<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String keyword="";String status="";String selected1="";String selected2="";
		String start_dd="";String start_mm="";String start_yy="";String end_dd="";String end_mm="";String end_yy="";
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
			start_dd = request.getParameter("start_dd"); if(start_dd==null){start_dd="";}
			start_mm = request.getParameter("start_mm"); if(start_mm==null){start_mm="";}
			start_yy = request.getParameter("start_yy"); if(start_yy==null){start_yy="";}	
			end_dd = request.getParameter("end_dd"); if(end_dd==null){end_dd="";}
			end_mm = request.getParameter("end_mm"); if(end_mm==null){end_mm="";}
			end_yy = request.getParameter("end_yy"); if(end_yy==null){end_yy="";}
			String where2 = fromtodate.where(start_dd,start_mm,start_yy,end_dd,end_mm,end_yy,"m.meet_date");
			ResultSet rs1 = stmt.executeQuery("select count(*) from meet m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id "+where1+ where2);	
			rs1.next();
			counter = rs1.getString(1);
			rs1.close();
			rs = stmt.executeQuery("select m.meet_no,m.year,m.meet_date,c.company_name,c.name,e.first_name,e.last_name,m.next_date from meet m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id "+where1+where2+" order by m.year desc,m.meet_no desc");	
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
	function add(){
		window.location="meet_add.jsp";
	}
	function gopage(pages) {
		document.form1.action="meet_search.jsp?pages="+pages;
		document.form1.submit();
	}
	function detail(meet_no,year){
		window.location="meet_detail.jsp?meet_no="+meet_no+"&year="+year;
	}
	</script>
</head>
<body> 
<font  class="f1">ค้นหาใบเสนอราคา</font>
<form action="meet_search.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="center">
				<strong>ค้นหา</strong> <input type="Text" class="txt" size="15" name="keyword" value="<%=keyword%>">
				<strong>โดย</strong> 
				<select name="status" >
					<option value="company_name" <%=selected1%>>ชื่อลูกค้า</option>
					<option value="employee_name" <%=selected2%>>ชื่อพนักงาน</option>
				</select>
				<strong>ตั้งแต่วันที่</strong> <input type="Text" class="txt" size="2" maxlength="2" name="start_dd" value="<%=start_dd%>"> /  <input type="Text" class="txt" size="2" maxlength="2" name="start_mm" value="<%=start_mm%>"> / <input type="Text" class="txt" size="4" maxlength="4" name="start_yy" value="<%=start_yy%>">  
				<strong>ถึงวันที่</strong> <input type="Text" class="txt" size="2" maxlength="2" name="end_dd" value="<%=end_dd%>"> /  <input type="Text" class="txt" size="2" maxlength="2" name="end_mm" value="<%=end_mm%>"> / <input type="Text" class="txt" size="4" maxlength="4" name="end_yy" value="<%=end_yy%>">
				<input type="submit" value="  ค้นหา  " class="butt">
				<input type="button" value="    เพิ่ม   "  class="butt" onclick="add()">
			</td>
		</tr>	 
	</table>
</form> 
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" width="12%">เลขที่ใบเสนอราคา</td>
		<td align="center"  width="12%">ใบเสนอราคาวันที่</td>
		<td align="center"  width="42%">ชื่อลูกค้า</td>
		<td align="center"  width="12%">ชื่อพนักงาน</td>
		<td align="center"  width="14%" >วันที่นัดพบครั้งต่อไป</td>
		<td  width="8%">&nbsp;</td>
	</tr>
<%
		try{		
			int i = -1;
			while(rs.next()){
				i = i+1;
				if ((i >= (currpage-1)*N) && (i <= (currpage-1)*N+N-1)){
					String meet_no = rs.getString(1);
					String year = rs.getString(2);
					String meet_dates = rs.getString(3);
					String meet_date_shows="";
					try{
						meet_date_shows = meet_dates.substring(6,8)+"/"+meet_dates.substring(4,6)+"/"+meet_dates.substring(0,4);
					}catch(Exception e){}
					String company_name = rs.getString(4)+"-->"+rs.getString(5);
					String name = rs.getString(6)+"  "+rs.getString(7);
					String next_dates = rs.getString(8);
					String next_date_shows="";
					try{
						next_date_shows = next_dates.substring(6,8)+"/"+next_dates.substring(4,6)+"/"+next_dates.substring(0,4);
					}catch(Exception e){}
					String background="";
					int bar = i%2;
					if(bar==0){
						background = "tr1";
					} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="center"><%=meet_no%>/<%=year%></Td>
					<td align="center" ><%=meet_date_shows%></td>
					<td align="left" ><%=company_name%></td>  
					<td align="center" ><%=name%></td>
					<td align="center" ><%=next_date_shows%></td>
					<td align="center" width="60"><a href="javascript:detail(<%=meet_no%>,<%=year%>)">รายละเอียด</a></td>
				</tr>
<%
				}
			}
		}catch (Exception e){}
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
</body>
</html>

<%
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
 