<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String good_id_mate = request.getParameter("good_id_mate");	
		String quantity_mate = request.getParameter("quantity_mate");	
		String year_mate = request.getParameter("year_mate"); 		
		String trans_fin = request.getParameter("trans_fin"); 
		String mate_no = request.getParameter("mate_no");
		String trans_date = request.getParameter("trans_date"); 
		Object employee_id=session.getValue("employee_id");	
		String comment = request.getParameter("comment");
		String stock = "N";
		Date today = new Date();
		int year = 1900+today.getYear();
		ResultSet rs = stmt.executeQuery("select max(trans_no)+1 from trans where year='"+year+"'");
		rs.next();
		String trans_no = rs.getString(1);
		if(trans_no==null){
			trans_no="1";
		}
		rs.close();
		stmt.executeUpdate("insert into trans  values('"+trans_no+"','"+year+"','"+mate_no+"','"+trans_date+"','"+employee_id+"','"+comment+"','"+stock+"','"+good_id_mate+"','"+quantity_mate+"','"+year_mate+"')");
		if(request.getParameter("good_id") != null){
			String[] good_id= request.getParameterValues("good_id");	
			String[] quantity= request.getParameterValues("quantity");
			String[] price= request.getParameterValues("price");		
			String[] price_unit= request.getParameterValues("price_unit");		
			String[] sale_low= request.getParameterValues("sale_low");	
			String[] sale_high= request.getParameterValues("sale_high");
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					stmt.executeUpdate("insert into trans_detail values('"+trans_no+"','"+year+"','"+good_id[k]+"','"+quantity[k]+"','"+price[k]+"','"+price_unit[k]+"','"+sale_low[k]+"','"+sale_high[k]+"','"+quantity[k]+"')");
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
						stmt.executeUpdate("insert into good_price  values('"+good_id[k]+"','"+trans_date+"','"+price[k]+"','"+price_unit[k]+"','"+sale_low[k]+"','"+sale_high[k]+"','ใบวัตถุดิบแปรเป็นสินค้า "+mate_no+"/"+year+"')");
						stmt.executeUpdate( "update good set price='"+price[k]+"', price_unit='"+price_unit[k]+"', sale_low='"+sale_low[k]+"', sale_high='"+sale_high[k]+"' where good_id='"+good_id[k]+"'");	
					}
				}
			}
		}		
		stmt.executeUpdate("update material_detail set trans_fin='"+trans_fin+"' where mate_no='"+mate_no+"' and year='"+year_mate+"' and good_id='"+good_id_mate+"' and quantity='"+quantity_mate+"'");
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620"><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="trans_search.jsp";
 	 </script>
</head>
<body>
</body>
</html>
