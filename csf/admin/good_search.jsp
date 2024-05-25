<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String keyword = request.getParameter("keyword"); if(keyword==null){keyword="";}
		String status = request.getParameter("status"); if(status==null){status="g.name";}
		String trans = request.getParameter("trans"); if(trans==null){trans="ALL";}
		String selected1="";String selected2="";String selected11="";String selected12="";String selected13="";String selected14="";
		String where1="";String where2 = "";
		String keys = keysearch.search(keyword);
		if(status.equals("g.name")){
			selected1 = "selected";
			where1 = " and g.name like '"+keys+"' "; 
		}else if(status.equals("t.name")){
			selected2 = "selected";
			where1 = " and t.name like '"+keys+"' "; 
		}
		if(trans.equals("ALL")){
			selected11 = "selected";
			where2 = " and g.trans like '%' ";
		}else if(trans.equals("Y")){
			selected12 = "selected";
			where2 = " and g.trans='Y' ";
		}else if(trans.equals("N")){
			selected13 = "selected";
			where2 = " and g.trans='N' ";
		}else if(trans.equals("C")){
			selected14 = "selected";
			where2 = " and g.trans='C' ";
		}
		ResultSet rs1 = stmt.executeQuery("select count(*) from good g,good_type t where g.good_type_id=t.good_type_id "+where1+where2);	
		rs1.next();
		String counter = rs1.getString(1);
		rs1.close();
		ResultSet rs = stmt.executeQuery("select g.good_id,g.name,g.unit_low,g.unit_high,g.rate,g.trans,t.name,g. price,g.price_unit,g.sale_low,g.sale_high from good g,good_type t where g.good_type_id=t.good_type_id "+where1+where2+" order by g.trans,t.name,g.name");	
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
		window.location="good_add.jsp";
	}
	function gopage(pages) {
		document.form1.action="good_search.jsp?pages="+pages;
		document.form1.submit();
	}
	function update(good_id){
		window.location="good_update.jsp?good_id="+good_id;
	}
	function price(good_id){
		var dialogUrl = "good_price.jsp?good_id="+good_id;
		var good_price = window.open(dialogUrl,"good_price","toolbar=0, location=0, directories=0, status=0, menubar=0, scrollbars=0, height=400, width=500,resizable=0");
		good_price.focus();
	}
	</script>
</head>
<body> 
<font  class="f1">ค้นหาทะเบียนสินค้า</font>
<form action="good_search.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="center">
				<strong>ค้นหา</strong> <input type="Text" class="txt" size="15" name="keyword" value="<%=keyword%>">
				<strong>โดย</strong> 
				<select name="status" >
					<option value="g.name" <%=selected1%>>ชื่อสินค้า</option>
					<option value="t.name" <%=selected2%>>ประเภทสินค้า</option>
				</select>
				<strong>ชนิด</strong>
				<select name="trans">
					<option value="ALL" <%=selected11%>>ทั้งหมด</option>	
					<option value="Y" <%=selected12%>>วัตถุดิบ</option>
					<option value="N" <%=selected13%>>สินค้า</option>
					<option value="C" <%=selected14%>>ค่าใช้จ่าย</option>
				</select>
				<input type="submit" value="  ค้นหา  " class="butt">
				<input type="button" value="    เพิ่ม   "  class="butt" onclick="add()">
			</td>
		</tr>	 
	</table>
</form> 
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" width="110" >ชื่อสินค้า</td>
		<td align="center"  width="80">ประเภทสินค้า</td>	
		<td align="center"  width="40">ชนิด</td>
		<td align="center"  width="70">ราคาซื้อ</td>
		<td align="center"  width="130">ราคาขาย : หน่วยนับย่อย</td>	
		<td align="center"  width="130">ราคาขาย : หน่วยนับใหญ่</td>
		<td align="center"  width="60">ย่อย : ใหญ่</td>
		<td width="60">&nbsp;</td>
		<td width="60">&nbsp;</td>
	</tr>
	<form name="formdel" method="post" >
<%
		int i = -1;
		while(rs.next()){
			i = i+1;
			if ((i >= (currpage-1)*N) && (i <= (currpage-1)*N+N-1)){
				String good_id = rs.getString(1);
				String name = rs.getString(2);
				String unit_low = rs.getString(3);
				String unit_high = rs.getString(4);if(unit_high==null){unit_high="";}
				String rate = rs.getString(5);
				String transs = rs.getString(6);
				String good_type_name = rs.getString(7);
				String price = rs.getString(8);
				String price_unit = rs.getString(9); if(price_unit==null){price_unit="";}
				String price_unit_name="";
				if(price_unit.equals("1")){
					price_unit_name = unit_low;
				}else{
					price_unit_name = unit_high;
				}
				String sale_low = rs.getString(10);
				String sale_high = rs.getString(11);
				String transs_name = "";
				if(transs.equals("Y")){
					transs_name="วัตถุดิบ";
				}else if(transs.equals("N")){
					transs_name="สินค้า";
				}else if(transs.equals("C")){
					transs_name="ค่าใช้จ่าย";
				}
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="left"><%=name%></Td>
					<td align="center" ><%=good_type_name%></td>
					<td align="center" ><%=transs_name%></td> 
					<td align="right" ><%=convertcomma.dtoa(price,"#,##0")%> : <%=price_unit_name%></td> 
					<td align="right" ><%=convertcomma.dtoa(sale_low,"#,##0")%> : <%=unit_low%></td> 
	<%
				if(unit_high.equals("")){
	%>
					<td align="center" ></td> 
	<%
				}else{
	%>
					<td align="right" ><%=convertcomma.dtoa(sale_high,"#,##0")%> : <%=unit_high%></td> 
<%
				}		
%>
					<td align="right" ><%=rate%></td> 
					<td align="center" ><a href="javascript:price(<%=good_id%>)">ราคาสินค้า</a></td>
					<td align="center"><a href="javascript:update(<%=good_id%>)">ปรับปรุง</a></td>
				</tr>
<%
			}
		}
%>
	</form>	
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
 