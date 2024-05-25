<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	 String good_id="";
	try{
		Statement stmt = con.createStatement();
		good_id = request.getParameter("good_id"); 
		String good_date = request.getParameter("good_date");
		String  price = request.getParameter("price"); 
		String  price_unit = request.getParameter("price_unit"); 
		String sale_low = request.getParameter("sale_low");
		String sale_high = request.getParameter("sale_high");if(sale_high==null){sale_high="0";}
		String comment = request.getParameter("comment");
                String sql="insert into good_price values('"+good_id+"','"+good_date+"',"+price+",'"+price_unit+"',"+sale_low+","+sale_high+",'"+comment+"')";
                out.print(sql);
		stmt.executeUpdate(sql);
                sql="SELECT  price,price_unit,sale_low,sale_high FROM good_price WHERE good_id = '"+good_id+"' ORDER BY good_date DESC limit 1";
                  out.print(sql);
		ResultSet rs = stmt.executeQuery(sql);	
		if(rs.next()){
			String prices = rs.getString(1);
			String price_units = rs.getString(2);
			String sale_lows = rs.getString(3);
			String sale_highs = rs.getString(4);
                        sql="update good set price="+prices+", price_unit='"+price_units+"', sale_low="+sale_lows+", sale_high="+sale_highs+" where good_id='"+good_id+"'";
                          out.print(sql);
			stmt.executeUpdate(sql );	
		}
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="good_price.jsp?good_id=<%=good_id%>";
 	 </script>
</head>
<body>
</body>
</html>
