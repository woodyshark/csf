<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String mate_date = request.getParameter("mate_date"); 
		String client_id = request.getParameter("client_id");
		Object employee_id=session.getValue("employee_id");
		String total = request.getParameter("total");		
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
		ResultSet rs = stmt.executeQuery("select max(mate_no)+1 from material where year='"+year+"'");
		rs.next();
		String mate_no = rs.getString(1);
		if(mate_no==null){
			mate_no="1";
		}
		rs.close();
		stmt.executeUpdate("insert into material values('"+mate_no+"','"+year+"','"+mate_date+"','"+client_id+"','"+employee_id+"','"+total+"','"+discount+"','"+total_discount+"','"+comment+"','"+stock+"','"+pay+"','"+pay_type+"','"+pay_date+"','"+pay_detail+"')");
		if(request.getParameter("good_id") != null){
			String[] good_id= request.getParameterValues("good_id");	
			String[] quantity= request.getParameterValues("quantity");
			String[] price= request.getParameterValues("price");		
			String[] price_unit= request.getParameterValues("price_unit");		
			String[] amount= request.getParameterValues("amount");	
			String[] sale_low= request.getParameterValues("sale_low");	
			String[] sale_high= request.getParameterValues("sale_high");
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					rs = stmt.executeQuery("select trans from good where good_id='"+good_id[k]+"'");
					rs.next();
					String trans = rs.getString(1);
					rs.close();
					stmt.executeUpdate("insert into material_detail values('"+mate_no+"','"+year+"','"+good_id[k]+"','"+quantity[k]+"','"+price[k]+"','"+price_unit[k]+"','"+amount[k]+"','"+sale_low[k]+"','"+sale_high[k]+"','"+quantity[k]+"','"+trans+"','N')");
					rs = stmt.executeQuery("select price,price_unit,sale_low,sale_high from good_price where good_id='"+good_id[k]+"' order by good_date desc");
					String database_price = "";
					String database_price_unit= "";
					String database_sale_low = "";
					String database_sale_high = "";
					if(rs.next()){
						database_price = rs.getString(1);
						database_price_unit = rs.getString(2);
						database_sale_low = rs.getString(3);
						database_sale_high = rs.getString(4);
					}
					if(database_price.equals(price[k]) && database_price_unit.equals(price_unit[k])&&database_sale_low.equals(sale_low[k]) && database_sale_high.equals(sale_high[k])){
					}else{
						stmt.executeUpdate("insert into good_price  values('"+good_id[k]+"','"+mate_date+"','"+price[k]+"','"+price_unit[k]+"','"+sale_low[k]+"','"+sale_high[k]+"','ใบสั่งซื้อวัตถดิบ "+mate_no+"/"+year+"')");
						stmt.executeUpdate( "update good set price='"+price[k]+"', price_unit='"+price_unit[k]+"', sale_low='"+sale_low[k]+"', sale_high='"+sale_high[k]+"' where good_id='"+good_id[k]+"'");	
					}
				}
			}
		}
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620"><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="material_search.jsp";
 	 </script>
</head>
<body>
</body>
</html>
