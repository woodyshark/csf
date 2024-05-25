<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String  employee_id = request.getParameter("employee_id"); 
		String  first_name = request.getParameter("first_name"); 
		String last_name = request.getParameter("last_name");
		String sur_name = request.getParameter("sur_name");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String postal_code = request.getParameter("postal_code");
		String  country = request.getParameter("country"); 
		String phone = request.getParameter("phone");
		String fax = request.getParameter("fax");
		String mobile_phone = request.getParameter("mobile_phone");
		String email = request.getParameter("email");
		String exp_date = request.getParameter("exp_date");
		String status=request.getParameter("status");
		String position = request.getParameter("position");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String comment = request.getParameter("comment");
		stmt.executeUpdate( "update employee set first_name= '"+first_name+"', last_name='"+last_name+"', sur_name='"+sur_name+"', address='"+address+"',city='"+city+"',postal_code='"+postal_code+"',country='"+country+"',phone='"+phone+"',fax='"+fax+"',mobile_phone='"+mobile_phone+"',email='"+email+"',exp_date='"+exp_date+"',status='"+status+"',position='"+position+"',username='"+username+"',password='"+password+"',comment='"+comment+"' where employee_id='"+employee_id+"'");	
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head>
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="employee_search.jsp";
 	 </script>
</head>
<body>
</body>
</html>
