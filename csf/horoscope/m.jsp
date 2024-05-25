<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>
<%   
	String code1 = request.getParameter("code1"); 
%>
<html><head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
</head>
<body>
<font  class="f1" >m</font><br>
<form name="form1" method="post"  action="http://knowledgebase.dbd.go.th/dbd/Popup/companyprofile.aspx">
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr1">
		<td align="right" class="h1">id</td>
		<td><input type="text" class="txt" size="30" maxlength="30" name="RlicenseNo" > </td>
	</tr>
	<tr class="tr2">
		<td ></td>
		<td align="right">
			<input type="submit" name="sm1" value="    ตกลง   " class="butt">
			<input type= "reset"  name="sm2" value="    ยกเลิก   " class="butt">
		</td>
	</tr>
</table>
</form>
</body>
</html>
