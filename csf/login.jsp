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
			alert("��سҡ�͡���ͼ����");
			form1.username.focus();
			return;
		}	
		if (!hasInput(form1.password.value)){			
			var redObj = new Array(form1.password);
			setErrorColor(redObj);			
			alert("��سҡ�͡���ʼ�ҹ");
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
						<td colspan="2" align="center" class="P1">�������к�</td>
					</tr>
<%
			if (u!=null){ 
%>
					<tr>
						<td  colspan="2" align="left"><font color="red">���ͼ���� ���� ���ʼ�ҹ �Դ !! </font></td>
					</tr>
<% 
			}  
%>		
				<tr>
					<td align="right" class="h1">���ͼ����</td>
					<td><input type="text" size="25" maxlength="20" name="username" class="txt"></td>
				</tr>
				<tr>
					<td align="right" class="h1">���ʼ�ҹ</td>
					<td><input type="password" size="25" maxlength="20" name="password" class="txt"></td>
				</tr>
				<tr>
					<td></td>
					<td align="right"><input type = "button" class="butt" value="  �������к�  " onclick="sm()"></td>
				</tr>
			</table></td>
		</tr>
	</table>
</form>
</center>
</body>
</html>
