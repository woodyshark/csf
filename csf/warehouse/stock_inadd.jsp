<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	SQLManager myman = SQLManager.getInstance();
	Connection con = myman.requestConnection("csf");  
	try {
		Statement stmt = con.createStatement();
		ResultSet rs=null;
		if(request.getParameter("stockin") != null){
			String[] stockin= request.getParameterValues("stockin");
			if	(stockin != null && stockin.length > 0) {
				for(int k=0; k<stockin.length; k++){
					try{
                                            String sql="update material set stock='Y' where concat(trim(mate_no),'/',year) = '"+stockin[k]+"'";
						int i1=stmt.executeUpdate(sql);
                                                %>
                                                out.print("i1="+i1);
                                                <%
						rs = stmt.executeQuery("select d.good_id,d.quantity,d.price_unit,g.unit_low,g.unit_high,g.rate from material_detail d,good g where d.trans='N' and d.good_id=g.good_id and concat(trim(mate_no),'/',year) = '"+stockin[k]+"'");	
                                                %>
                                                out.print("after select");
                                                <%
						String[] good_id = new String[100];
						float[] quantity = new float[100];
						String[] price_unit = new String[100];
						String[] unit_low = new String[100];
						String[] unit_high = new String[100];
						float[] rate = new float[100];
						int n=0;
						while(rs.next()){
							good_id[n] = rs.getString(1);
							quantity[n] = rs.getFloat(2);
							price_unit[n] = rs.getString(3);
							unit_low[n] = rs.getString(4);
							unit_high[n] = rs.getString(5);
							rate[n] = rs.getFloat(6);
							n = n+1;
						}
						for(int m=0;m<good_id.length;m++){
							Date today = new Date();
							int year = 1900+today.getYear();
							int month = today.getMonth()+1;
							rs = stmt.executeQuery("select total_unit_low,total_unit_high from good where good_id='"+good_id[m]+"'");	
							if(rs.next()){
								float total_unit_low = rs.getFloat(1);
								float total_unit_high = rs.getFloat(2);
								if(unit_high[m].equals("")){
									total_unit_low = total_unit_low+quantity[m];
								}else{
									if(price_unit[m].equals("1")){	
										float total2	= ((total_unit_high*rate[m])+total_unit_low)+quantity[m];
										float data2_unit_low = total2 % rate[m];
										float data2_unit_high = total2 / rate[m];			
										Float cc = new Float(data2_unit_high);
										int dd = cc.intValue();
										total_unit_low = data2_unit_low;
										total_unit_high = dd;						
									}else{
										total_unit_high = total_unit_high+quantity[m];						
									}
								}		
								stmt.executeUpdate("update good set total_unit_low='"+total_unit_low+"',total_unit_high='"+total_unit_high+"' where good_id='"+good_id[m]+"'");			
							}
						}
					}catch(Exception e){out.println(e);} 		
				}
			}	
		}
		rs.close();
		stmt.close();
	}catch(Exception e){out.println(e);} 
	 myman.returnConnection("csf", con);		
 %>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	 <script language="JavaScript">
		window.location="stock_in.jsp";
 	 </script>
</head>
<body>
</body>
</html>
