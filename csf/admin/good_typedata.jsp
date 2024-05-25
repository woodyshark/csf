<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String  good_type_id = request.getParameter("good_type_id"); 
		String name = request.getParameter("name");
		if(good_type_id==null){
			ResultSet rs = stmt.executeQuery("select max(good_type_id)+1 from good_type");
			rs.next();
			String counter = rs.getString(1);
			if(counter==null){
				counter="1";
			}
			rs.close();
			stmt.executeUpdate("insert into good_type values("+counter+",'"+name+"')");
%>
<script>
			self.parent.opener.addtype('<%=counter%>','<%=name%>');
</script>
<%
		}else{
			stmt.executeUpdate( "update good_type set name='"+name+"' where good_type_id='"+good_type_id+"'");	
%>
<script>
			self.parent.opener.updtype('<%=good_type_id%>','<%=name%>');
</script>
<%
		}
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.close();
 	 </script>
</head>
<body>
</body>
</html>
