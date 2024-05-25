<%@ page contentType="text/html; charset=windows-874" %>
<%@ include file="libs/style.css" %>
<%@ include file="libs/script.js" %>

<% 
	String u= request.getParameter("u");
%>

<html> 
<head>
<title>
    Chot Shark Fins Co.,Ltd.
</title>
<script language="JavaScript">
	function sm() {
		if (!hasInput(form1.username.value)){			
			var redObj = new Array(form1.username);
			setErrorColor(redObj);			
			alert("กรุณากรอกชื่อผู้ใช้");
			form1.username.focus();
			return;
		}	
		if (!hasInput(form1.password.value)){			
			var redObj = new Array(form1.password);
			setErrorColor(redObj);			
			alert("กรุณากรอกรหัสผ่าน");
			form1.password.focus();
			return;
		}
		form1.action = "check_login.jsp";
		form1.submit();
	}
</script>
</head>
<body>
<center>
<form name = "form1"  method="post">
	<table width = "30%">
		<tr>
			<td><table width = "100%">
					<tr>
						<td colspan="2" align="center" class="P1">เข้าสู่ระบบ</td>
					</tr>
<%
			if (u!=null){ 
%>
					<tr>
						<td  colspan="2" align="left"><font color="red">ชื่อผู้ใช้ หรือ รหัสผ่าน ผิด !! </font></td>
					</tr>
<% 
			}  
%>		
				<tr>
					<td align="right" class="h1">ชื่อผู้ใช้</td>
					<td><input type="text" size="25" maxlength="20" name="username" class="txt"></td>
				</tr>
				<tr>
					<td align="right" class="h1">รหัสผ่าน</td>
					<td><input type="password" size="25" maxlength="20" name="password" class="txt"></td>
				</tr>
				<tr>
					<td></td>
					<td align="right"><input type = "button" class="butt" value="  เข้าสู่ระบบ  " onclick="sm()"></td>
				</tr>
			</table></td>
		</tr>
	</table>
</form>
</center>
</body>
</html>
