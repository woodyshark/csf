<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>
ddddddddddddd
<%
	SQLManager myman = SQLManager.getInstance();
	Connection con = myman.requestConnection("csf");  
	try {
		Statement stmt = con.createStatement();
		ResultSet rs=null;
		if(request.getParameter("stock_out") != null){
			String[] stock_out= request.getParameterValues("stock_out");
			String[] year= request.getParameterValues("year");
			if	(stock_out != null && stock_out.length > 0) {
				for(int k=0; k<stock_out.length; k++){					
					stmt.executeUpdate("update orders set stock='Y' where orders_no='"+stock_out[k]+"' and year= '"+year[k]+"'");
//out.print("select d.good_id,d.quantity,o.orders_date,o.client_id,d.sale,d.sale_unit,g.unit_low,g.unit_high,g.rate from orders_detail d,orders o,good g where d.orders_no=o.orders_no and d.year=o.year and d.good_id=g.good_id and   orders_no='"+stock_out[k]+"' and year= '"+year[k]+"'");
					rs = stmt.executeQuery("select d.good_id,d.quantity,o.orders_date,o.client_id,d.sale,d.sale_unit,g.unit_low,g.unit_high,g.rate from orders_detail d,orders o,good g where d.orders_no=o.orders_no and d.year=o.year and d.good_id=g.good_id and   o.orders_no='"+stock_out[k]+"' and o.year= '"+year[k]+"'");
out.print("1111");				
					String[] good_id = new String[100];
					float[] quantity = new float[100];
					String[] orders_date = new String[100];
					String[] client_id = new String[100];
					float[] sale = new float[100];
					String[] sale_unit = new String[100];
					String[] unit_low = new String[100];
					String[] unit_high = new String[100];
					float[] rate = new float[100];
					int n=0;
					while(rs.next()){
						good_id[n] = rs.getString(1);
						quantity[n] = rs.getFloat(2);
						orders_date[n] = rs.getString(3);
						client_id[n] = rs.getString(4);
						sale[n] = rs.getFloat(5);			
						sale_unit[n] = rs.getString(6);
						unit_low[n] = rs.getString(7);
						unit_high[n] = rs.getString(8);
						rate[n] = rs.getFloat(9);
						n = n+1;
					}
					try{
						for(int m=0;m<good_id.length;m++){
							rs = stmt.executeQuery("select total_unit_low,total_unit_high from good where good_id='"+good_id[m]+"'");	
							if(rs.next()){
								float total_unit_low = rs.getFloat(1);
								float total_unit_high = rs.getFloat(2);
								if(unit_high[m].equals("")){
									total_unit_low = total_unit_low-quantity[m];
								}else{
									if(sale_unit[m].equals("1")){	
										float total	= ((total_unit_high*rate[m])+total_unit_low)-quantity[m];
										float data2_unit_low = total % rate[m];
										float data2_unit_high = total / rate[m];	
										Float cc = new Float(data2_unit_high);
										int dd = cc.intValue();
										total_unit_low = data2_unit_low;
										total_unit_high = dd;						
									}else{
										total_unit_high = total_unit_high-quantity[m];						
									}
								}	
								stmt.executeUpdate("update good set total_unit_low='"+total_unit_low+"',total_unit_high='"+total_unit_high+"' where good_id='"+good_id[m]+"'");
							}
						}
					}catch(Exception e){out.println(e);} 		
					try{
						for(int j=0;j<good_id.length;j++){	
//out.print("(select td.trans_no,td.year,t.trans_date,td.quantity_stock,'trans_detail',td.price_unit from trans_detail td,trans t where td.trans_no=t.trans_no and td.year=t.year and td.quantity_stock>0 and td.good_id='"+good_id[j]+"') union all (select d.mate_no,d.year,m.mate_date,d.quantity_stock,'material_detail',d.price_unit from material_detail d,material m where d.mate_no=m.mate_no and d.year=m.year and d.quantity_stock<>0 and d.good_id='"+good_id[j]+"') ORDER BY `trans_date` ASC");		
							rs = stmt.executeQuery("(select td.trans_no,td.year,t.trans_date,td.quantity_stock,'trans_detail',td.price_unit from trans_detail td,trans t where td.trans_no=t.trans_no and td.year=t.year and td.quantity_stock>0 and td.good_id='"+good_id[j]+"') union all (select d.mate_no,d.year,m.mate_date,d.quantity_stock,'material_detail',d.price_unit from material_detail d,material m where d.mate_no=m.mate_no and d.year=m.year and d.quantity_stock<>0 and d.good_id='"+good_id[j]+"') ORDER BY `trans_date` ASC");		
							String[] mate_nos = new String[100];
							String[] years = new String[100];
							String[] mate_dates = new String[100];
							float[] quantity_stocks = new float[100];
							String[] types = new String[100];
							String[] price_units = new String[100];
							int c=0;
							while(rs.next()){
								mate_nos[c] = rs.getString(1);
								years[c] = rs.getString(2);
								mate_dates[c] = rs.getString(3);
								quantity_stocks[c] = rs.getFloat(4);
								types[c] = rs.getString(5);
								price_units[c]  = rs.getString(6);
								c = c+1;
							}		
							float total_quantity=quantity[j];
							if(sale_unit[j].equals("1")){	
								total_quantity=total_quantity;
							}else{
								String aa = Float.toString(total_quantity);
								String bb = new String(aa);
								int number = bb.indexOf(".");
								int cc = Integer.parseInt(bb.substring(0,number));
								int dd = Integer.parseInt(bb.substring(number+1));
								total_quantity = (cc*rate[j])+dd;									
							}	
out.print("total_quantity="+total_quantity);					
							try{
								for(int m=0;m<mate_nos.length;m++){		
									String stocks="";String details="";
									if(types[m].equals("material_detail")){
										stocks = " stock_mate ";
										details = " mate_no ";
									}else if(types[m].equals("trans_detail")){
										stocks = " stock_tran ";
										details = " trans_no ";
									}	
									float total_quantity_stock=quantity_stocks[m];
									if(price_units[m].equals("1")){
										total_quantity_stock=total_quantity_stock;
									}else{
										String aa = Float.toString(total_quantity_stock);
										String bb = new String(aa);
										int number = bb.indexOf(".");
										int cc = Integer.parseInt(bb.substring(0,number));
										int dd = Integer.parseInt(bb.substring(number+1));
										total_quantity_stock = (cc*rate[j])+dd;									
									}
out.print("total_quantity_stock="+total_quantity_stock);
									if(total_quantity<=total_quantity_stock){
										total_quantity_stock = total_quantity_stock-total_quantity;	
out.print("total_quantity_stock-total_quantity="+total_quantity_stock);
										float total_quantity_stock_unit=0;
										if(price_units[m].equals("1")){
											total_quantity_stock_unit=total_quantity_stock;					
										}else{
											float data2_unit_low = total_quantity_stock%rate[j];
											float data2_unit_high = total_quantity_stock / rate[j];	
											Float cc = new Float(data2_unit_low);
											int dd = cc.intValue();
											Float ee = new Float(data2_unit_high);
											int ff = ee.intValue();
											total_quantity_stock_unit = Float.parseFloat( Integer.toString(ff).concat(".").concat(Integer.toString(dd)));
										}
										float total_quantity_unit=0;
										if(sale_unit[j].equals("1")){
											total_quantity_unit=total_quantity;
										}else{
											float data3_unit_low = total_quantity%rate[j];
											float data3_unit_high = total_quantity / rate[j];	
											Float gg = new Float(data3_unit_low);
											int hh = gg.intValue();
											Float ii = new Float(data3_unit_high);
											int jj = ii.intValue();
											total_quantity_unit = Float.parseFloat( Integer.toString(jj).concat(".").concat(Integer.toString(hh)));
										}
out.print("insert into "+stocks+"	 	values('"+good_id[j]+"','"+mate_nos[m]+"','"+years[m]+"','"+client_id[j]+"','"+total_quantity_unit+"','"+sale[j]+"','"+sale_unit[j]+"','"+orders_date[j]+"','"+stock_out[k]+"/"+year[k]+"')");	
out.print("update "+types[m]+" set quantity_stock='"+total_quantity_stock_unit+"' where "+details+"='"+mate_nos[m]+"' and year='"+years[m]+"' and good_id='"+good_id[j]+"'");		
										stmt.executeUpdate("insert into "+stocks+"	 	values('"+good_id[j]+"','"+mate_nos[m]+"','"+years[m]+"','"+client_id[j]+"','"+total_quantity_unit+"','"+sale[j]+"','"+sale_unit[j]+"','"+orders_date[j]+"','"+stock_out[k]+"/"+year[k]+"')");	
										stmt.executeUpdate("update "+types[m]+" set quantity_stock='"+total_quantity_stock_unit+"' where "+details+"='"+mate_nos[m]+"' and year='"+years[m]+"' and good_id='"+good_id[j]+"'");		
										break;
									}else{
										float total_quantity_stock_unit=0;
										if(sale_unit[j].equals("1")){
											total_quantity_stock_unit=total_quantity_stock;
										}else{
											float data2_unit_low = total_quantity_stock%rate[j];
											float data2_unit_high = total_quantity_stock / rate[j];	
											Float cc = new Float(data2_unit_low);
											int dd = cc.intValue();
											Float ee = new Float(data2_unit_high);
											int ff = ee.intValue();
											total_quantity_stock_unit = Float.parseFloat( Integer.toString(ff).concat(".").concat(Integer.toString(dd)));
										}
out.print("insert into "+stocks+"  values('"+good_id[j]+"','"+mate_nos[m]+"','"+years[m]+"','"+client_id[j]+"','"+total_quantity_stock_unit+"','"+sale[j]+"','"+sale_unit[j]+"','"+orders_date[j]+"','"+stock_out[k]+"/"+year[k]+"')");
out.print("update "+types[m]+" set quantity_stock='0' where "+details+"='"+mate_nos[m]+"' and year='"+years[m]+"' and good_id='"+good_id[j]+"'");
										stmt.executeUpdate("insert into "+stocks+"  values('"+good_id[j]+"','"+mate_nos[m]+"','"+years[m]+"','"+client_id[j]+"','"+total_quantity_stock_unit+"','"+sale[j]+"','"+sale_unit[j]+"','"+orders_date[j]+"','"+stock_out[k]+"/"+year[k]+"')");
										stmt.executeUpdate("update "+types[m]+" set quantity_stock='0' where "+details+"='"+mate_nos[m]+"' and year='"+years[m]+"' and good_id='"+good_id[j]+"'");
										total_quantity = total_quantity-total_quantity_stock;
									}
								}
							}catch(Exception e){out.println(e);} 	
						}
					}catch(Exception e){out.println(e);} 	
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
		window.location="stock_out.jsp?";
 	 </script>
</head>
<body>
</body>
</html>
