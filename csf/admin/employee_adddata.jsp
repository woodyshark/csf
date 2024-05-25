<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
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
		String imp_date = request.getParameter("imp_date");
		String exp_date = "";
		String status="Y";
		String position = request.getParameter("position");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String comment = request.getParameter("comment");
		ResultSet rs = stmt.executeQuery("select max(employee_id)+1 from employee");
		rs.next();
		String employee_id = rs.getString(1);
		if(employee_id==null){
			employee_id="1";
		}
		rs.close();
		stmt.executeUpdate( "insert into employee values('"+employee_id+"','"+first_name+"','"+last_name+"','"+sur_name+"','"+address+"','"+city+"','"+postal_code+"','"+country+"','"+phone+"','"+fax+"','"+mobile_phone+"','"+email+"','"+imp_date+"','"+exp_date+"','"+status+"','"+position+"','"+username+"','"+password+"','"+comment+"')");	
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
