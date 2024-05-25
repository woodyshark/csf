	<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		int todays = fromtodate.today();
		ResultSet rs1 = stmt.executeQuery("select count(*) from orders o,client c,employee e where o.client_id=c.client_id and o.employee_id=e.employee_id and o.next_date>="+todays+"  UNION all select count(*) from meet m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and m.next_date>="+todays);	
		int counter=0;
		while(rs1.next()){
			counter = counter+rs1.getInt(1);
		}
		rs1.close();
		ResultSet rs = stmt.executeQuery("select o.orders_no,o.year,o.next_date,'orders',c.company_name,c.name,e.first_name,e.last_name from orders o,client c,employee e where o.client_id=c.client_id and o.employee_id=e.employee_id and o.next_date>="+todays+"  UNION all select m.meet_no,m.year,m.next_date,'meet',c.company_name,c.name,e.first_name,e.last_name from meet m,client c,employee e where m.client_id=c.client_id and m.employee_id=e.employee_id and m.next_date>="+todays+" order by next_date,company_name,name");	
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
	function detail(types,order_no,year){
		if(types=="orders"){
			dialogUrl = "orders_detail.jsp?orders_no="+order_no+"&year="+year+"&close=yes";
		}else{
			dialogUrl = "meet_detail.jsp?meet_no="+order_no+"&year="+year+"&close=yes";
		}
		var detail = window.open(dialogUrl,"detail","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=1, height=450, width=450,resizable=0");
		detail.focus();
	}
	</script>
</head>
<body> 
<font  class="f1">การนัดพบครั้งต่อไป</font>
<p>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" >เลขที่ใบ</td>
		<td align="center" >วันที่นัดพบครั้งต่อไป</td>
		<td align="center" >ชื่อลูกค้า</td>
		<td align="center">ชื่อพนักงาน</td>
		<td width="60">&nbsp;</td>
	</tr>
<%
		int i = 0;
		while(rs.next()){
				String orders_no = rs.getString(1);
				String year = rs.getString(2);
				String next_date = rs.getString(3);
				String next_date_show="";
				try{
					next_date_show = next_date.substring(6,8)+"/"+next_date.substring(4,6)+"/"+next_date.substring(0,4);
				}catch(Exception e){}
				String type = rs.getString(4);
				String company_name = rs.getString(5)+"-->"+rs.getString(6);
				String name = rs.getString(7)+"  "+rs.getString(8);
				String background="";
				i=i+1;
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="left"><%=type%> <%=orders_no%>/<%=year%></Td>
					<td align="center" ><%=next_date_show%></td>
					<td align="left" ><%=company_name%></td>  
					<td align="center" ><%=name%></td>
					<td align="center" width="60"><a href="javascript:detail('<%=type%>',<%=orders_no%>,<%=year%>)">รายละเอียด</a></td>
				</tr>
<%
		}
%>
	</table>
</body>
</html>

<%
		rs.close();
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
 