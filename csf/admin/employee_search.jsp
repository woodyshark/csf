<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String status = request.getParameter("status"); if(status==null){status="ALL";}
		String key="";String selected1="";String selected2="";String selected3="";String selected4="";String selected5="";String selected6="";String selected7="";String selected8="";
		if(status.equals("ALL")){
			selected1 = "selected";
			key = "%";
		}else if(status.equals("C")){
			selected2 = "selected";
			key = "C";
		}else if(status.equals("A")){
			selected3 = "selected";
			key = "A";
		}else if(status.equals("E")){
			selected4 = "selected";
			key = "E";
		}else if(status.equals("F")){
			selected5 = "selected";
			key = "F";
		}else if(status.equals("M")){
			selected6 = "selected";
			key = "M";
		}else if(status.equals("S")){
			selected7 = "selected";
			key = "S";
		}else if(status.equals("W")){
			selected8 = "selected";
			key = "W";
		}
		ResultSet rs1 = stmt.executeQuery("select count(*) from employee where position like '"+key+"'");	
		rs1.next();
		String counter = rs1.getString(1);
		rs1.close();
		ResultSet rs = stmt.executeQuery("select employee_id,first_name,sur_name,position,status from employee where position like '"+key+"' order by status desc,position,first_name");	
		int N = 20;
		String pages = request.getParameter("pages");if(pages==null){pages="";}
		int numrow = Integer.parseInt(counter);
		int numpage = numrow / N;
		int numpr = numrow % N;
		if(numpr==0){
		}else{
			numpage = numpage+1;
		}
		int currpage=0;
		if (pages == ""){
			currpage = 1; 
		}else{ 
			currpage = Integer.parseInt(pages);
		}
%>

<html>
<head>  <meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
	function add(){
		window.location="employee_add.jsp";
	}
	function gopage(pages) {
		document.form1.action="employee_search.jsp?pages="+pages;
		document.form1.submit();
	}
	function update(employee_id){
		window.location="employee_update.jsp?employee_id="+employee_id;
	}
	</script>
</head>
<body> 
<font  class="f1">ค้นหาพนักงาน</font>
<form action="employee_search.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="center">
				<strong>ตำแหน่ง</strong>
				<select name="status">
					<option value="ALL" <%=selected1%>>ALL</option>
					<option value="C" <%=selected2%>>ACCOUNT</option>
					<option value="A" <%=selected3%>>ADMIN</option>
					<option value="E" <%=selected4%>>EMPLOYEE</option>
					<option value="F" <%=selected5%>>FACTORY</option>
					<option value="M" <%=selected6%>>MANAGER</option>
					<option value="S" <%=selected7%>>SELL</option>
					<option value="W" <%=selected8%>>WAREHOUSE</option>
				</select>
				<input type="submit" value="  ค้นหา  " class="butt">
				<input type="button" value="    เพิ่ม   "  class="butt" onclick="add()">
			</td>
		</tr>	 
	</table>
</form> 
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center" width="30%">ชื่อ</td>
		<td align="center" width="15%">ชื่อเล่น</td>
		<td align="center" width="10%">ตำแหน่ง</td>
		<td align="center" width="10%">สถานะ</td>
		<td width="10%">&nbsp;</td>
	</tr>
	<form name="formdel" method="post" >
<%
		int i = -1;
		while(rs.next()){
			i = i+1;
			if ((i >= (currpage-1)*N) && (i <= (currpage-1)*N+N-1)){
				String employee_id = rs.getString(1);
				String first_name = rs.getString(2);
				String sur_name = rs.getString(3);
				String position = rs.getString(4);
				String position_name = "";
				if(position.equals("A")){
					position_name="ADMIN";
				}else if(position.equals("M")){
					position_name="MANAGER";
				}else if(position.equals("C")){
					position_name="ACCOUNT";
				}else if(position.equals("S")){
					position_name="SELL";
				}else if(position.equals("W")){
					position_name="WAREHOUSE";
				}else if(position.equals("F")){
					position_name="FACTORY";
				}else if(position.equals("E")){
					position_name="EMPLOYEE";
				}
				String status1 = rs.getString(5);
				String status_name = "";
				if(status1.equals("Y")){
					status_name = "อยู่";
				}else{
					status_name = "ไม่อยู่";
				}
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="left" ><%=first_name%></td>
					<td align="left" ><%=sur_name%></td>
					<td align="center" ><%=position_name%></td>  
					<td align="center" ><%=status_name%></td>  
					<td align="center" ><a href="javascript:update(<%=employee_id%>)">ปรับปรุง</a></td>
				</tr>
<%
			}
		}
%>
	</form>	
	<tr> 
          <td  colspan="5" align="center">
<%
		if (numpage > 0){
			out.println("<B>หน้าที่</B> &nbsp");
		}else{ 
			out.println("ไม่พบรายการที่ค้นหา<BR>");
		}
		for(int k = 1;k<= numpage;k++){
			if(k != currpage){
				out.print("<a href='javascript:gopage(" + k + ")'>" + k +"</a>");
			}else{
				out.print(k);
			}
			if (k != numpage){ 
				out.print(" | ");
			}
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
 