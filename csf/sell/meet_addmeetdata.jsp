<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String meet_no = request.getParameter("meet_no");
		String year = request.getParameter("year");
		ResultSet rs = stmt.executeQuery("select g.good_id,g.name,m.sale,m.sale_unit,g.unit_low,g.unit_high,g.rate from meet_detail m,good g where m.good_id=g.good_id and  meet_no='"+meet_no+"' and year='"+year+"'");
		String doc="";
		int i=0;
		while(rs.next()){
			i=i+1;
			String good_id = rs.getString(1);
			String good_name = rs.getString(2);
			String sale = rs.getString(3);
			String sale_unit = rs.getString(4);
			String unit_low = rs.getString(5);
			String unit_high = rs.getString(6);
			String rate = rs.getString(7);
			String sale_unit_name="";
			if(sale_unit.equals("1")){
				sale_unit_name = unit_low;
			}else{
				sale_unit_name = unit_high;
			}
			if(i==1){							
				doc="good_id="+good_id+"&good_name="+good_name+"&sale="+sale+"&price_unit="+sale_unit+"&price_unit_name="+sale_unit_name+"&rate="+rate+"&unit_low="+unit_low+"&unit_high="+unit_high;
			}else{
				doc=doc+"&good_id="+good_id+"&good_name="+good_name+"&sale="+sale+"&price_unit="+sale_unit+"&price_unit_name="+sale_unit_name+"&rate="+rate+"&unit_low="+unit_low+"&unit_high="+unit_high;
			}
		}
%>
<script>
		self.parent.opener.adddetail2("<%=doc%>");
		window.close();
</script>
<%
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
