<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String keyword = request.getParameter("keyword"); if(keyword==null){keyword="";}
		String status = request.getParameter("status"); if(status==null){status="name";}
		String type = request.getParameter("type"); if(type==null){type="ALL";}
		String selected1="";String selected2="";String selected11="";String selected12="";String selected13="";String selected14="";
		String selected15="";String selected16="";String selected17="";
		String where1="";String where2 = "";
		String keys = keysearch.search(keyword);
		if(status.equals("name")){
			selected1 = "selected";
			where1 = " and (company_name like '"+keys+"' or name like '"+keys+"') "; 
		}else if(status.equals("city")){
			selected2 = "selected";
			where1 = " and city like '"+keys+"' "; 
		}
		if(type.equals("ALL")){
			selected11 = "selected";
			where2 = " and type like '%' ";
		}else if(type.equals("C")){
			selected12 = "selected";
			where2 = " and type='C' ";
		}else if(type.equals("S")){
			selected13 = "selected";
			where2 = " and type='S' ";
		}else if(type.equals("O")){
			selected14 = "selected";
			where2 = " and type='O' ";
		}else if(type.equals("1")){
			selected15 = "selected";
			where2 = " and type='1' ";
		}else if(type.equals("2")){
			selected16 = "selected";
			where2 = " and type='2' ";
		}else if(type.equals("3")){
			selected17 = "selected";
			where2 = " and type='3' ";
		}
		ResultSet rs1 = stmt.executeQuery("select count(*) from client where client_id<>'0'  "+where1+where2);	
		rs1.next();
		String counter = rs1.getString(1);
		rs1.close();
		ResultSet rs = stmt.executeQuery("select client_id,company_name,name,city,phone,type,mobile_phone from client where client_id<>'0' "+where1+where2+" order by type,city,company_name,name");	
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
<head>  <meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
	function add(){
		window.location="client_add.jsp";
	}
	function print(){
		var dialogUrl = "excel_client_search.jsp?type=<%=type%>";
		var excel = window.open(dialogUrl,"excel","");
		excel.focus();
	}
	function gopage(pages) {
		document.form1.action="client_search.jsp?pages="+pages;
		document.form1.submit();
	}
	function update(clinet_id){
		window.location="client_update.jsp?client_id="+clinet_id;
	}
	</script>
</head>
<body> 
<font  class="f1">ค้นหาลูกค้า</font>
<form action="client_search.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="left"><input type="button" value=" พิมพ์ "  class="butt" onclick="print()"></td>
			<td align="center">
				<strong>ค้นหา</strong> <input type="Text" class="txt" size="15" name="keyword" value="<%=keyword%>">
				<strong>โดย</strong> 
				<select name="status" >
					<option value="name" <%=selected1%>>ชื่อผู้ติดต่อ</option>
					<option value="city" <%=selected2%>>จังหวัด</option>
				</select>
				<strong>ชนิดลูกค้า</strong>
				<select name="type">
					<option value="ALL" <%=selected11%>>ทั้งหมด</option>
					<option value="C" <%=selected12%>>ลูกค้าขาย</option>
					<option value="S" <%=selected13%>>ลูกค้าซื้อ</option>
					<option value="O" <%=selected14%>>อื่นๆ</option>				
					<option value="1" <%=selected15%>>ญาติพี่น้อง</option>
					<option value="2" <%=selected16%>>เพื่อน</option>
					<option value="3" <%=selected17%>>สำนักงานต่างๆ</option>
				</select>
				<input type="submit" value="  ค้นหา  " class="butt">
				<input type="button" value="    เพิ่ม   "  class="butt" onclick="add()">
			</td>
		</tr>	 
	</table>
</form> 
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="18%">ชื่อบริษัท</td>
		<td align="center"  width="17%">ชื่อผู้ติดต่อ</td>
		<td align="center"  width="7%">จังหวัด</td>
		<td align="center"  width="16%">โทรศัพท์</td>
		<td align="center"  width="14%">โทรศัพท์มือถือ</td>
		<td align="center"  width="10%">ชนิดลูกค้า</td>
		<td width="7%">&nbsp;</td>
	</tr>
	<form name="formdel" method="post" >
<%
		int i = -1;
		while(rs.next()){
			i = i+1;
			if ((i >= (currpage-1)*N) && (i <= (currpage-1)*N+N-1)){
				String client_id = rs.getString(1);
				String company_name = rs.getString(2);
				String name = rs.getString(3);
				String city = rs.getString(4);
				String phone = rs.getString(5);
				String types = rs.getString(6);
				String mobile_phone = rs.getString(7);
				String type_name = "";
				if(types.equals("C")){
					type_name="ลูกค้าขาย";
				}else if(types.equals("S")){
					type_name="ลูกค้าซื้อ";
				}else if(types.equals("O")){
					type_name="อื่นๆ";
				}else if(types.equals("1")){
					type_name="ญาติพี่น้อง";
				}else if(types.equals("2")){
					type_name="เพื่อน";
				}else if(types.equals("3")){
					type_name="สำนักงานต่างๆ";
				}
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="left"><%=company_name%></Td>
					<td align="left" ><%=name%></td>
					<td align="center" ><%=city%></td>
					<td align="left" ><%=phone%></td>  
 					<td align="left" ><%=mobile_phone%></td>  
					<td align="center" ><%=type_name%></td>  
					<td align="center" ><a href="javascript:update(<%=client_id%>)">ปรับปรุง</a></td>
				</tr>
<%
			}
		}
%>
	</form>	
	<tr> 
          <td  colspan="7" align="center">
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
 