<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String good_type_id = request.getParameter("good_type_id");if(good_type_id==null){good_type_id="";}
		String name = "";
		if(good_type_id.equals("")){
		}else{
			ResultSet rs = stmt.executeQuery("select name from good_type where good_type_id='"+good_type_id+"'");
			rs.next();
			name = rs.getString(1);
		}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<title>จัดการประเภทสินค้า</title>
<script language="JavaScript">
	function cancel(){  
		window.close();
	}
	function select(data){  
		form1.action = "good_type.jsp?good_type_id="+data;
		form1.submit();
	}
	function sm(types){
		if (!hasInput(form1.name.value)){			
			var redObj = new Array(form1.name);
			setErrorColor(redObj);			
			alert("กรุณากรอกประเภทสินค้า");
			form1.name.focus();
			return;
		}
		if(types=="add"){
			form1.action = "good_typedata.jsp";
		}else if(types=="update"){
			form1.action = "good_typedata.jsp?good_type_id=<%=good_type_id%>";
		}
		form1.submit();
	}
</script>
</head>
<body>
<font  class="f1" >ประเภทสินค้า</font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0"  width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ประเภทสินค้า *</td>
		<td><input type="text" class="txt" size="20" maxlength="50" name="name" value="<%=name%>"> </td>
	</tr>
	<tr class="tr2">
		<td ></td>
		<td align="right">
<%
		if(good_type_id.equals("")){
%>
			<input type="button" name="sm1" value="    เพิ่ม   " class="butt"  onclick="sm('add')">
<%
		}else{
%>
			<input type="button" name="sm2" value="    ปรับปรุง   " class="butt"  onclick="sm('update')">
<%
		}	
%>
			<input type= "button"  name="sm3" value="    ยกเลิก   " class="butt" onclick="cancel()">
		</td>
	</tr>
</table>
<table width="100%">
<%	
		int count=0;
		ResultSet rs1 = stmt.executeQuery("select * from good_type");
		while(rs1.next()){
			String good_type_ids = rs1.getString("good_type_id");
			String name1 = rs1.getString("name");
			count=count+1;
			if ((count%5)==1){ 
%>
				<tr> 
<%
			}
%>
					<td align="center"> <a href="javascript:select(<%=good_type_ids%>)"><%=name1%></a></td>
<%
			if ((count%5)==0) { 
%> 
				</tr> 
<%   
			}
		}   
 %>
</table>
</form>
</body>
</html>

<%
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
