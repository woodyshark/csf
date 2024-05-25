<%@ page contentType="text/html; charset=windows-874" %>
<%@ include file="session.jsp" %>

<html>
<head>
</head>
<body>
<div align="left" class="P1"> 
<%
     if (session.getValue("position").equals("A")) { 
%>
		ADMIN
<%
	}else if (session.getValue("position").equals("M")) { 
%>
		MANAGER
<%
	}else if (session.getValue("position").equals("C")) { 
%>
		ACCOUNT
<%
	}else if (session.getValue("position").equals("S")) { 
%>
		SELL
<%
	}else if (session.getValue("position").equals("W")) { 
%>
		WAREHOUSE
<%
	}else if (session.getValue("position").equals("F")) { 
%>
		FACTORY
<%
	}else if (session.getValue("position").equals("E")) { 
%>
		EMPLOYEE
<%
	}
%>
</div>
</body>
</html>
