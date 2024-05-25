<%@ page import="com.codestudio.util.*,libs.*,java.io.*,java.util.*,java.sql.*,java.text.*,java.util.Date" %>
<%@ include file="libs/style.css" %>
<%@ include file="libs/script.js" %>
<% 
		if ((session.getValue("employee_id") == null) || (session.getValue("first_name") == null) || (session.getValue("position") == null)){
%> 
			<script language="JavaScript">
					top.location="<%=Config.parthtml()%>";
			</script>
<%
		}else{
			session.setMaxInactiveInterval(3000);
		}
%>
  