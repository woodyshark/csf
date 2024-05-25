<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		ResultSet rs=null;String counter="0";
		String client_id="";
		try{
			client_id = request.getParameter("client_id");
			ResultSet rs1 = stmt.executeQuery("select count(*) from meet m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and m.client_id='"+client_id+"'");	
			rs1.next();
			counter = rs1.getString(1);
			rs1.close();
			rs = stmt.executeQuery("select m.meet_no,m.year,m.meet_date,c.company_name,c.name,e.first_name,e.last_name,m.next_date from meet m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and (m.client_id='"+client_id+"' or m.client_id='0') order by m.year desc,m.meet_no desc");	
		}catch (Exception e){if(client_id==null){client_id="";}}
		int N = 5;
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
	function add(meet_no,year){
		document.form1.action="meet_addmeetdata.jsp?meet_no="+meet_no+"&year="+year;
		document.form1.submit();
	}
	function gopage(pages) {
		document.form1.action="meet_search.jsp?pages="+pages;
		document.form1.submit();
	}
	function detail(meet_no,year){
		var dialogUrl = "meet_detail.jsp?meet_no="+meet_no+"&year="+year+"&close=yes";
		var meet_addmeet = window.open(dialogUrl,"meet_detail","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=1, height=400, width=560,resizable=0");
		meet_addmeet.focus();
	}
	</script>
</head>
<body> 
<font  class="f1">ค้นหาใบเสนอราคา</font>
<form name="form1" method="post"  >
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="100">เลขที่ใบเสนอราคา</td>
		<td align="center"  width="100">ใบเสนอราคาลงวันที่</td>
		<td align="center" >ชื่อลูกค้า</td>
		<td align="center" width="100">ชื่อพนักงาน</td>
		<td width="60">&nbsp;</td>
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
					String background="";
					int bar = i%2;
					if(bar==0){
						background = "tr1";
					} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="center"><a href="javascript:add(<%=meet_no%>,<%=year%>)"><%=meet_no%>/<%=year%></a></Td>
					<td align="center" ><%=meet_date_shows%></td>
					<td align="center" ><%=company_name%></td>  
					<td align="center" ><%=name%></td>
					<td align="center" width="60"><a href="javascript:detail(<%=meet_no%>,<%=year%>)">รายละเอียด</a></td>
				</tr>
<%
				}
			}
		}catch (Exception e){}
%>
	<tr> 
          <td  colspan="4" align="center">
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
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
 