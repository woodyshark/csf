<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();
		String  good_id = request.getParameter("good_id"); 
		String  name = request.getParameter("name"); 
		String good_trans_id = request.getParameter("good_trans_id");
		String status="yes";
		ResultSet rs = stmt.executeQuery("select good_trans_id from good_trans where good_id='"+good_id+"'");	
		while(rs.next()){
			String good_trans_ids = rs.getString(1);
			if(good_trans_ids.equals(good_trans_id)){
				status="no";
				break;
			}
		}
		if(status.equals("yes")){
			stmt.executeUpdate("insert into good_trans values('"+good_id+"','"+good_trans_id+"')");
%>
<script>
			self.parent.opener.addtrans('<%=good_trans_id%>','<%=name%>');
</script>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.close();
 	 </script>
</head>
<body>
</body>
</html>
<%
		}else{
%>
<script>
			alert("มีสินค้านี้อยู่แล้ว กรุณาเลือกใหม่");
			history.back();
</script>
<%
		}
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
