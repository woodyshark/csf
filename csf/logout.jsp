<%@ include file="session.jsp" %>
<% 
		session.removeValue("employee_id");
		session.removeValue("first_name");
		session.removeValue("position");

%> 
			<script language="JavaScript">
					top.location="<%=Config.parthtml()%>";
			</script>
