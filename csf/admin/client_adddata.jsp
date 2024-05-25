<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
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
		String imp_date = request.getParameter("imp_date");
		String type = request.getParameter("type");
		String comment = request.getParameter("comment");
		ResultSet rs = stmt.executeQuery("select max(client_id)+1 from client");
		rs.next();
		String client_id = rs.getString(1);
		if(client_id==null){
			client_id="1";
		}
		rs.close();
		stmt.executeUpdate( "insert into client values('"+client_id+"','"+company_name+"','"+name+"','"+address+"','"+city+"','"+postal_code+"','"+country+"','"+phone+"','"+fax+"','"+mobile_phone+"','"+email+"','"+imp_date+"','"+type+"','"+comment+"')");	
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
