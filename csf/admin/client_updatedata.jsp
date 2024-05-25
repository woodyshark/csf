<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String  client_id = request.getParameter("client_id"); 
		String  company_name = request.getParameter("company_name"); 
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String postal_code = request.getParameter("postal_code");
		String  country = request.getParameter("country"); 
		String phone = request.getParameter("phone");
		String fax = request.getParameter("fax");
		String mobile_phone = request.getParameter("mobile_phone");
		String email = request.getParameter("email");
		String type = request.getParameter("type");
		String comment = request.getParameter("comment");
		stmt.executeUpdate( "update client set company_name='"+company_name+"', name='"+name+"', address='"+address+"', city='"+city+"', postal_code='"+postal_code+"',country='"+country+"',phone='"+phone+"',fax='"+fax+"',mobile_phone='"+mobile_phone+"',email='"+email+"',type='"+type+"',comment='"+comment+"' where client_id='"+client_id+"'");	
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head>
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="client_search.jsp";
 	 </script>
</head>
<body>
</body>
</html>
