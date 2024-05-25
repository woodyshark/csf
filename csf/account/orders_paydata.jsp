<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String orders_no = request.getParameter("orders_no"); 
		String year = request.getParameter("year");
		String pay_type = request.getParameter("pay_type"); 
		String pay_date = request.getParameter("pay_date");
		String pay_detail = request.getParameter("pay_detail"); 
		stmt.executeUpdate("update orders set pay='Y',pay_type='"+pay_type+"',pay_date='"+pay_date+"',pay_detail='"+pay_detail+"' where orders_no='"+orders_no+"' and year='"+year+"'");
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="orders_account.jsp";
 	 </script>
</head>
<body>
</body>
</html>
