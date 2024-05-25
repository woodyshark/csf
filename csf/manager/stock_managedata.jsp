<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		if(request.getParameter("good_id") != null){
			String[] type= request.getParameterValues("type");
			String[] mate_no= request.getParameterValues("mate_no");
			String[] year= request.getParameterValues("year");
			String[] good_id= request.getParameterValues("good_id");
			String[] quantity= request.getParameterValues("quantity");
			String[] quantity_stock= request.getParameterValues("quantity_stock");
			String[] price_unit= request.getParameterValues("price_unit");
			String[] unit_low= request.getParameterValues("unit_low");
			String[] unit_high= request.getParameterValues("unit_high");
			String[] rate= request.getParameterValues("rate");
			stmt.executeUpdate("update good set total_unit_low=0,total_unit_high=0 where trans='N'");
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					String type_name="";
					if(type[k].equals("mate_no")){
						type_name="material_detail";
					}else if(type[k].equals("trans_no")){
						type_name="trans_detail";
					}
					stmt.executeUpdate("update "+type_name+" set quantity_stock='"+quantity_stock[k]+"' where "+type[k]+"='"+mate_no[k]+"' and year='"+year[k]+"' and good_id='"+good_id[k]+"' and quantity='"+quantity[k]+"'");
					ResultSet rs = stmt.executeQuery("select d.quantity_stock,d.price_unit,g.unit_low,g.unit_high,g.rate from material_detail d, good g where d.quantity_stock <> 0 and d.good_id = g.good_id and g.trans = 'n' and d.good_id = '"+good_id[k]+"'");
					float total_unit_low=0;float total_unit_high=0;float totals=0;
					while(rs.next()){
						float quantity_stocks=rs.getFloat(1);
						String price_units=rs.getString(2);
						String unit_lows = rs.getString(3);
						String unit_highs = rs.getString(4);
						float rates = rs.getFloat(5);
						if(price_units.equals("1")){	
							totals = totals+quantity_stocks;
						}else{
							String aa = Float.toString(quantity_stocks);
							String bb = new String(aa);
							int number = bb.indexOf(".");
							int cc = Integer.parseInt(bb.substring(0,number));
							int dd = Integer.parseInt(bb.substring(number+1));
							totals = totals+(cc*rates)+dd;		
						}
					}
					rs = stmt.executeQuery("select d.quantity_stock,d.price_unit,g.unit_low,g.unit_high,g.rate from trans_detail d, good g where d.quantity_stock <> 0 and d.good_id = g.good_id and g.trans = 'n' and d.good_id = '"+good_id[k]+"'");
					while(rs.next()){
						float quantity_stocks=rs.getFloat(1);
						String price_units=rs.getString(2);
						String unit_lows = rs.getString(3);
						String unit_highs = rs.getString(4);
						float rates = rs.getFloat(5);
						if(price_units.equals("1")){	
							totals = totals+quantity_stocks;
						}else{
							String aa = Float.toString(quantity_stocks);
							String bb = new String(aa);
							int number = bb.indexOf(".");
							int cc = Integer.parseInt(bb.substring(0,number));
							int dd = Integer.parseInt(bb.substring(number+1));
							totals = totals+(cc*rates)+dd;			
						}
					}
					if(unit_high[k].equals("")){
						total_unit_low = totals;
					}else{
						if(price_unit[k].equals("1")){	
							total_unit_low = totals;		
						}else{
							float data2_unit_low = totals % Float.parseFloat(rate[k]);
							float data2_unit_high = totals / Float.parseFloat(rate[k]);	
							Float cc = new Float(data2_unit_high);
							int dd = cc.intValue();
							total_unit_low = data2_unit_low;
							total_unit_high = dd;						
						}
					}	
					stmt.executeUpdate("update good set total_unit_low='"+total_unit_low+"',total_unit_high='"+total_unit_high+"' where good_id='"+good_id[k]+"'");
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
		 window.location="stock_manage.jsp";
 	 </script>
</head>
<body>
</body>
</html>
