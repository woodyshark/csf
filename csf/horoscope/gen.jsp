<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>
<%   
	String code1 = request.getParameter("code1"); 
%>
<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
</head>
<body>
<font  class="f1" >คาราโอเกะ</font><br>
<form name="form1" method="post"  action="gening.jsp">
<table cellpadding="3" cellspacing="2" border="0" width="100%">
	<tr class="tr1">
		<td align="right" class="h1">ชื่อเพลง</td>
		<td><input type="text" class="txt" size="30" maxlength="30" name="title" > </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">นักร้อง</td>
		<td><input type="text" class="txt" size="30" maxlength="30" name="artist" value=""> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">รหัส</td>
		<td><input type="text" class="txt" size="20" maxlength="20" name="code" value="<%=code1%>"> </td>
	</tr>
	<tr class="tr2">
		<td align="right" class="h1">sub type</td>
		<td><input type="text" class="txt" size="20" maxlength="20" name="sub_type" value="MPG"> </td>
	</tr>
	<tr class="tr1">
		<td align="right" class="h1">file</td>
		<td><input type="text" class="txt" size="30" maxlength="30" name="file" value="mpg"> </td>
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
