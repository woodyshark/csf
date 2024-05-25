<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	SQLManager myman = SQLManager.getInstance();
	Connection con = myman.requestConnection("csf");  
	try {
		Statement stmt = con.createStatement();
		String meet_date = request.getParameter("meet_date"); 
		String client_id = request.getParameter("client_id");
		Object employee_id=session.getValue("employee_id");
		String question = request.getParameter("question"); 
		String solution = request.getParameter("solution");
		String next_date = request.getParameter("next_date"); 
		String comment = request.getParameter("comment");
		Date today = new Date();
		int year = 1900+today.getYear();
		ResultSet rs = stmt.executeQuery("select max(meet_no)+1 from meet where year='"+year+"'");
		rs.next();
		String meet_no = rs.getString(1);
		if(meet_no==null){
			meet_no="1";
		}
		rs.close();
		stmt.executeUpdate("insert into meet values('"+meet_no+"','"+year+"','"+meet_date+"','"+client_id+"','"+employee_id+"','"+question+"','"+solution+"','"+comment+"','"+next_date+"')");
		if(request.getParameter("del") != null){
			String[] good_id= request.getParameterValues("del");
			if	(good_id != null && good_id.length > 0) {
				for(int k=0; k<good_id.length; k++){
					String sale_unit = request.getParameter("sale_unit"+good_id[k]);
					String sale_low = request.getParameter("sale_low"+good_id[k]);
					String sale_high = request.getParameter("sale_high"+good_id[k]);
					String sale="";
					if(sale_unit.equals("1")){
						sale = sale_low;
					}else{
						sale = sale_high;
					}
					stmt.executeUpdate("insert into meet_detail values('"+meet_no+"','"+year+"','"+good_id[k]+"','"+sale+"','"+sale_unit+"')");
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
		window.location="meet_search.jsp";
 	 </script>
</head>
<body>
</body>
</html>
