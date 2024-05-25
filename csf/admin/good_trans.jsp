<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String good_id = request.getParameter("good_id");
		String good_type_id = request.getParameter("good_type_id");
%>

<html>
<title>เพิ่มรายการวัตถุดิบแปรเป็นสินค้า</title>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
<script language="JavaScript">
	function sm(){	
		if (form1.good_trans_id.options[form1.good_trans_id.selectedIndex].value == "") {
			if (!hasInput(form1.good_trans_id.value)){			
				var redObj = new Array(form1.good_trans_id);
				setErrorColor(redObj);			
				alert("กรุณากรอกชื่อสินค้า");
				form1.good_trans_id.focus();
				return;
			}		
		}
		name=form1.good_trans_id.options[form1.good_trans_id.selectedIndex].text;
		form1.action = "good_transdata.jsp?good_id=<%=good_id%>&name="+name;
		form1.submit();
	}
	function cancel(){  
 		window.close();
	}
</script>
</head>
<body>
<font  class="f1" >เพิ่มรายการวัตถุดิบแปรเป็นสินค้า</font><br>
<form name="form1" method="post"  >
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ชื่อสินค้า *</td>
		<td><select name="good_trans_id">
					<option value="">กรุณาเลือก</option>
<%
		ResultSet rs1 = stmt.executeQuery("select good_id,name from good where trans='N' order by name");
		while(rs1.next()){
			String good_ids = rs1.getString(1);
			String names = rs1.getString(2);
%>
					<option value="<%=good_ids%>"><%=names%></option>
<%
		}	
		rs1.close();
%>
				  </select>
		</td>
	</tr>
	<tr class="tr1">
		<td ></td>
		<td align="right">
			<input type="button" name="sm1" value="    เพิ่ม   " class="butt"  onclick="sm()">
			<input type= "reset"  name="sm2" value="    ยกเลิก   " class="butt" onclick="cancel()">
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
