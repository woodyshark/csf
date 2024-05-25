<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	SQLManager myman = SQLManager.getInstance();
	Connection con = myman.requestConnection("csf");  
	try {
		Statement stmt = con.createStatement();
		if(request.getParameter("del") != null){
			String[] good_id= request.getParameterValues("del");
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					String price = request.getParameter("price"+good_id[k]);
					String sale_low = request.getParameter("sale_low"+good_id[k]);
					String sale_high = request.getParameter("sale_high"+good_id[k]);if(sale_high==null){sale_high="0.0";}
					stmt.executeUpdate("update good set price='"+price+"',sale_low='"+sale_low+"',sale_high='"+sale_high+"' where good_id='"+good_id[k]+"'");
					ResultSet rs = stmt.executeQuery("select price,price_unit,sale_low,sale_high from good_price where good_id='"+good_id[k]+"' order by good_date desc");
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
					int today_dates = fromtodate.today();
					if(database_price.equals(price) && database_sale_low.equals(sale_low) && database_sale_high.equals(sale_high)){
					}else{
						stmt.executeUpdate("insert into good_price  values('"+good_id[k]+"','"+today_dates+"','"+price+"','"+database_price_unit+"','"+sale_low+"','"+sale_high+"','จัดการราคาสินค้า')");
					}
				}
			}	
		}
		stmt.close();
	}catch(Exception e){out.println(e);} 
	 myman.returnConnection("csf", con);		
 %>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	 <script language="JavaScript">
		window.location="good_price.jsp";
 	 </script>
</head>
<body>
</body>
</html>
