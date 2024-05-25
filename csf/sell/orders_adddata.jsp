<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String orders_date = request.getParameter("orders_date"); 
		String client_id = request.getParameter("client_id");
		Object employee_id=session.getValue("employee_id");
		String total = request.getParameter("total");		
		String next_date = request.getParameter("next_date"); 
		String comment = request.getParameter("comment");
		String stock = "N";	
		String discount = request.getParameter("discount"); 
		String total_discount = request.getParameter("total_discount");		
		String pay="";
		String pay_type = request.getParameter("pay_type"); 
		String pay_date = request.getParameter("pay_date");
		String pay_detail = request.getParameter("pay_detail"); if(pay_detail==null){pay_detail="";}
		if(pay_type.equals("N")){
			pay = "N";
			pay_type = "";
		}else{
			pay = "Y";
		}
		Date today = new Date();
		int year = 1900+today.getYear();
		ResultSet rs = stmt.executeQuery("select max(orders_no)+1 from orders where year='"+year+"'");
		rs.next();
		String orders_no = rs.getString(1);
		if(orders_no==null){
			orders_no="1";
		}
		rs.close();
		stmt.executeUpdate("insert into orders values('"+orders_no+"','"+year+"','"+orders_date+"','"+client_id+"','"+employee_id+"','"+total+"','"+discount+"','"+total_discount+"','"+comment+"','"+next_date+"','"+stock+"','"+pay+"','"+pay_type+"','"+pay_date+"','"+pay_detail+"')");
		if(request.getParameter("good_id") != null){
			String[] good_id= request.getParameterValues("good_id");	
			String[] quantity= request.getParameterValues("quantity");
			String[] sale= request.getParameterValues("sale");		
			String[] price_unit= request.getParameterValues("price_unit");		
			String[] amount= request.getParameterValues("amount");	
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					stmt.executeUpdate("insert into orders_detail values('"+orders_no+"','"+year+"','"+good_id[k]+"','"+quantity[k]+"','"+sale[k]+"','"+price_unit[k]+"','"+amount[k]+"')");
				}
			}
		}
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="orders_search.jsp";
 	 </script>
</head>
<body>
</body>
</html>
