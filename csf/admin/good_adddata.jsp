<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String name = request.getParameter("name");
		String good_type_id = request.getParameter("good_type_id");
		String imp_date = request.getParameter("imp_date");
		String description = request.getParameter("description");
		String unit_low = request.getParameter("unit_low");
		String rate = request.getParameter("rate");
		String unit_high = request.getParameter("unit_high");if(unit_high==null){unit_high="";}
		String min_quantity = request.getParameter("min_quantity");
		String trans = request.getParameter("trans");
		String comment = request.getParameter("comment");
		ResultSet rs = stmt.executeQuery("select max(good_id)+1 from good");
		rs.next();
		String good_id = rs.getString(1);
		if(good_id==null){
			good_id="1";
		}
		rs.close();
		stmt.executeUpdate( "insert into good( good_id ,  good_type_id ,  name ,  imp_date ,  description ,  unit_low ,  rate ,  unit_high ,  min_quantity ,  trans ,  comment ,  price ,  price_unit ,  sale_low ,  sale_high ,  total_unit_low ,  total_unit_high ) values('"+good_id+"','"+good_type_id+"','"+name+"','"+imp_date+"','"+description+"','"+unit_low+"','"+rate+"','"+unit_high+"','"+min_quantity+"','"+trans+"','"+comment+"',0,'1',0,0,0,0)");	
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="good_search.jsp";
 	 </script>
</head>
<body>
</body>
</html>
