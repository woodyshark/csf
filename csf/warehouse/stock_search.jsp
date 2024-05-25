<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
</head>
<body> 
<font  class="f1">จำนวนสินค้าสินค้าคงเหลือ</font>
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="left" width="20%" >ชื่อสินค้า</td>
		<td align="center"  width="15%">ประเภทสินค้า</td>	
		<td align="center"  width="15%">ชนิด</td>
		<td align="center"  width="10%">จำนวนต่ำสุด </td>
		<td align="center" width="20%" >จำนวนทั้งหมดหน่วยย่อย</td>
		<td align="center" width="20%" >จำนวนทั้งหมดหน่วยใหญ่</td>
	</tr>
<%
		ResultSet rs = stmt.executeQuery("select count(*) from good where trans='C'");	
		rs.next();
		int counter = rs.getInt(1);
		rs.close();
	rs = stmt.executeQuery("select g.good_id,t.name,g.name,g.unit_low,g.min_quantity,g.trans,g.total_unit_low,g.unit_high,g.total_unit_high from good g,good_type t where g.trans<>'C' and g.good_type_id=t.good_type_id  order by  g.trans,t.name,g.total_unit_low desc,g.total_unit_high desc");
		int i=-1;
		while(rs.next()){
			i=i+1;
			String good_id = rs.getString(1);
			String name_type = rs.getString(2);
			String name = rs.getString(3);
			String unit_low = rs.getString(4);
			String min_quantity = rs.getString(5);
			String trans = rs.getString(6);
			String trans_name = "";
			if(trans.equals("Y")){
				trans_name="วัตถุดิบ";
			}else if(trans.equals("N")){
				trans_name="สินค้า";
			}
			String total_unit_low = rs.getString(7);
			String unit_high = rs.getString(8);
			String total_unit_high = rs.getString(9);
			String data1 ="";String data2="";
			if(total_unit_low.equals("0.0")&&total_unit_high.equals("0.0")){
			}else{
				data1 = "<font color='red'>";
				data2 = "</font>";
			}
			String background="";
			int bar =i%2;
			if(bar==0){
				background = "tr1";
			} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="left"><%=data1%><%=name%><%=data2%></Td>
					<td align="center" ><%=data1%><%=name_type%><%=data2%></td>
					<td align="center" ><%=data1%><%=trans_name%><%=data2%></td> 
					<td align="right" ><%=data1%><%=convertcomma.dtoa(min_quantity,"#,##0.0")%> <%=unit_low%><%=data2%></td> 
					<td align="right" ><%=data1%><%=convertcomma.dtoa(total_unit_low,"#,##0.0")%> <%=unit_low%><%=data2%></td>
					<td align="right"><%=data1%>
<%
					if(unit_high.equals("")){}else{
%>
						<%=convertcomma.dtoa(total_unit_high,"#,##0.0")%> <%=unit_high%>
<%
				}
%>
					<%=data2%></td>
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
		myman.returnConnection("may", con);	
%>
 