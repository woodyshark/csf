<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String  good_id = request.getParameter("good_id"); 
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
		stmt.executeUpdate( "update good set good_type_id='"+good_type_id+"', name='"+name+"', description='"+description+"', unit_low='"+unit_low+"', rate='"+rate+"', unit_high='"+unit_high+"', min_quantity='"+min_quantity+"',trans='"+trans+"',comment='"+comment+"' where good_id='"+good_id+"'");	
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
