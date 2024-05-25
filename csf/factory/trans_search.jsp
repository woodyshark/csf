<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String keyword1="";String keyword2="";String status="";String selected1="";String selected2="";
		String start_dd="";String start_mm="";String start_yy="";String end_dd="";String end_mm="";String end_yy="";
		ResultSet rs=null;String counter="0";
		try{
			keyword1 = request.getParameter("keyword1");
			keyword2 = request.getParameter("keyword2"); if(keyword2==null){keyword2="";}
			status = request.getParameter("status"); if(status==null){status="trans_no";}
			String keyword11 = keysearch.search(keyword1);
			String keyword22 = keysearch.search(keyword2);
			String where1="";
			if(status.equals("trans_no")){
				selected1 = "selected";
				where1 = " where t.trans_no like '"+keyword11+"' and t.year like '"+keyword22+"' "; 
			}else if(status.equals("mate_no")){
				selected2 = "selected";
				where1 = " where t.mate_no like '"+keyword11+"' and t.year_mate like '"+keyword22+"' "; 
			}		
			start_dd = request.getParameter("start_dd"); if(start_dd==null){start_dd="";}
			start_mm = request.getParameter("start_mm"); if(start_mm==null){start_mm="";}
			start_yy = request.getParameter("start_yy"); if(start_yy==null){start_yy="";}	
			end_dd = request.getParameter("end_dd"); if(end_dd==null){end_dd="";}
			end_mm = request.getParameter("end_mm"); if(end_mm==null){end_mm="";}
			end_yy = request.getParameter("end_yy"); if(end_yy==null){end_yy="";}
			String where2 = fromtodate.where(start_dd,start_mm,start_yy,end_dd,end_mm,end_yy,"t.trans_date");
			ResultSet rs1 = stmt.executeQuery("select count(*) from trans t "+where1+where2);	
			rs1.next();
			counter = rs1.getString(1);
			rs1.close();
//out.print("select t.trans_no,t.year,t.trans_date,t.mate_no,(select first_name from employee where employee_id=t.employee_id),(select last_name from employee where employee_id=t.employee_id),'Chot SharkFins',(select name from good where good_id=t.good_id),t.quantity,t.year_mate from trans t "+where1+where2+" order by t.year desc,t.trans_no desc");

			rs = stmt.executeQuery("select t.trans_no,t.year,t.trans_date,t.mate_no,(select first_name from employee where employee_id=t.employee_id),(select last_name from employee where employee_id=t.employee_id),(select company_name from client c,material m where c.client_id=m.client_id and m.mate_no=t.mate_no and m.year=t.year),(select name from good where good_id=t.good_id),t.quantity,t.year_mate from trans t "+where1+where2+" order by t.year desc,t.trans_no desc");
		}catch (Exception e){if(keyword1==null){keyword1="";}}
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
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620"><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
	function add(){
		window.location="trans_add.jsp";
	}
	function gopage(pages) {
		document.form1.action="trans_search.jsp?pages="+pages;
		document.form1.submit();
	}
	function detail(trans_no,year){
		window.location="trans_detail.jsp?trans_no="+trans_no+"&year="+year;
	}
	</script>
</head>
<body> 
<font  class="f1">ค้นหาวัตถุดิบแปรเป็นสินค้า</font>
<form action="trans_search.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="center">	
				<select name="status" >
					<option value="trans_no" <%=selected1%>>เลขที่วัตถุดิบ</option>
					<option value="mate_no" <%=selected2%>>เลขที่ใบสั่งซื้อ</option>
				</select> 
				<input type="Text" class="txt" size="7" name="keyword1" value="<%=keyword1%>"> / <input type="Text" class="txt" size="4" name="keyword2" value="<%=keyword2%>">
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
		<td align="center"  width="80">เลขที่วัตถุดิบ</td>
		<td align="center"  width="80">วัตถุดิบลงวันที่</td>
		<td align="center"  width="80">เลขที่ใบสั่งซื้อ</td>
		<td align="center" >ชื่อผู้ผลิต</td>
		<td align="center" width="100">สินค้า</td>
		<td align="center"  width="60">จำนวน</td>
		<td align="center" width="100">ชื่อพนักงาน</td>
		<td width="60">&nbsp;</td>
	</tr>
<%
		try{
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
					<td align="center"><%=trans_no%>/<%=year%></Td>
					<td align="center" ><%=trans_date_shows%></td>
					<td align="center" ><%=mate_no%>/<%=year_mate%></td>  
					<td align="center" ><%=company_name%></td>				
					<td align="center" ><%=good_name%></td>			
					<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity),"#,##0.0")%></td>	
					<td align="center" ><%=name%></td>	
					<td align="center" width="60"><a href="javascript:detail(<%=trans_no%>,<%=year%>)">รายละเอียด</a></td>
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
 