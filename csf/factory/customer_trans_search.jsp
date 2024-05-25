<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");  
	try{
		Statement stmt = con.createStatement();		
		String keyword1="";String keyword2="";String status="";String selected1="";String selected2="";String good_id="";String start="";
		String start_dd="";String start_mm="";String start_yy="";String end_dd="";String end_mm="";String end_yy="";
		ResultSet rs=null;String counter="0";String where1="";String where2="";String where3="";
		try{
			keyword1 = request.getParameter("keyword1");
			keyword2 = request.getParameter("keyword2"); if(keyword2==null){keyword2="";}
			status = request.getParameter("status"); if(status==null){status="trans_no";}
			good_id = request.getParameter("good_id"); if(good_id==null){good_id="all";}
			String keyword11 = keysearch.search(keyword1);
			String keyword22 = keysearch.search(keyword2);
			if(status.equals("trans_no")){
				selected1 = "selected";
				where1 = " and t.trans_no like '"+keyword11+"' and t.year like '"+keyword22+"' "; 
			}else if(status.equals("mate_no")){
				selected2 = "selected";
				where1 = " and t.mate_no like '"+keyword11+"' and t.year_mate like '"+keyword22+"' "; 
			}		
			start_dd = request.getParameter("start_dd"); if(start_dd==null){start_dd="";}
			start_mm = request.getParameter("start_mm"); if(start_mm==null){start_mm="";}
			start_yy = request.getParameter("start_yy"); if(start_yy==null){start_yy="";}	
			end_dd = request.getParameter("end_dd"); if(end_dd==null){end_dd="";}
			end_mm = request.getParameter("end_mm"); if(end_mm==null){end_mm="";}
			end_yy = request.getParameter("end_yy"); if(end_yy==null){end_yy="";}
			where2 = fromtodate.where(start_dd,start_mm,start_yy,end_dd,end_mm,end_yy,"t.trans_date");
			if(good_id.equals("all")){
				where3 = " and d.good_id like '%' ";
			}else{
				where3 = " and d.good_id like '"+good_id+"' ";
			}
		}catch (Exception e){if(keyword1==null){keyword1="";start="true";}}
%>

<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620"><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
</head>
<body> 
<font  class="f1">ค้นหาข้อมูลแปรเป็นสินค้า</font>
<form action="customer_trans_search.jsp" name="form1" method="post">
	<table width="100%" cellpadding="3" cellspacing="2">
		<tr>
			<td align="center">
				<select name="status" >
					<option value="trans_no" <%=selected1%>>เลขที่วัตถุดิบ</option>
					<option value="mate_no" <%=selected2%>>เลขที่ใบสั่งซื้อ</option>
				</select> 
				<input type="Text" class="txt" size="7" name="keyword1" value="<%=keyword1%>"> / <input type="Text" class="txt" size="4" name="keyword2" value="<%=keyword2%>">
				<strong>ชื่อสินค้า</strong>  
				<select name="good_id">
					<option value="all">ทั้งหมด</option>
<%
		rs = stmt.executeQuery("select distinct (good_trans_id), g.name from good_trans t, good g where t.good_trans_id = g.good_id order by g.name");
		while(rs.next()){
			String good_ids = rs.getString(1);
			String names = rs.getString(2);
			String selected="";
			if(good_id.equals(good_ids)){
				selected = "selected";
			}else{
				selected = "";
			}
%>
					<option value="<%=good_ids%>" <%=selected%>><%=names%></option>
<%
		}	
%>
				  </select>
				<strong>ตั้งแต่วันที่</strong> <input type="Text" class="txt" size="2" maxlength="2" name="start_dd" value="<%=start_dd%>"> /  <input type="Text" class="txt" size="2" maxlength="2" name="start_mm" value="<%=start_mm%>"> / <input type="Text" class="txt" size="4" maxlength="4" name="start_yy" value="<%=start_yy%>">  
				<strong>ถึงวันที่</strong> <input type="Text" class="txt" size="2" maxlength="2" name="end_dd" value="<%=end_dd%>"> /  <input type="Text" class="txt" size="2" maxlength="2" name="end_mm" value="<%=end_mm%>"> / <input type="Text" class="txt" size="4" maxlength="4" name="end_yy" value="<%=end_yy%>">
				<input type="submit" value="  ค้นหา  " class="butt">
			</td>
		</tr>	 
	</table>
</form> 
<table width="100%" cellpadding="3" cellspacing="2" >
	<tr class="tr0" >
		<td align="center"  width="10%">เลขที่วัตถุดิบ</td>
		<td align="center"  width="12%">วัตถุดิบลงวันที่</td>
		<td align="center"  width="10%">เลขที่ใบสั่งซื้อ</td>
		<td align="center" width="15%" >ชื่อผู้ผลิต</td>
		<td align="center" width="15%">วัตถุดิบ</td>
		<td align="center"  width="15%">ชื่อสินค้า</td>
		<td align="center" width="7%">จำนวน</td>
		<td align="center" width="8%">ราคา</td>
		<td align="center" width="8%">รวมเงิน</td>
	</tr>
<%
		if(start.equals("true")){
		}else{
//out.print("select d.trans_no,d.year,t.trans_date,t.mate_no,t.year_mate,c.company_name,(select g2.name from good g2 where g2.good_id=t.good_id),t.quantity,g.name,d.quantity,d.price from trans t,client c,good g,trans_detail d,material m where d.trans_no=t.trans_no and d.year=t.year and t.mate_no=m.mate_no and t.year_mate=m.year and m.client_id=c.client_id and  d.good_id=g.good_id "+where1+where2+where3+" order by d.year desc,d.trans_no desc");

			rs = stmt.executeQuery("select d.trans_no,d.year,t.trans_date,t.mate_no,t.year_mate,c.company_name,(select g2.name from good g2 where g2.good_id=t.good_id),t.quantity,g.name,d.quantity,d.price from trans t,client c,good g,trans_detail d,material m where d.trans_no=t.trans_no and d.year=t.year and t.mate_no=m.mate_no and t.year_mate=m.year and m.client_id=c.client_id and  d.good_id=g.good_id "+where1+where2+where3+" order by d.year desc,d.trans_no desc");
		}
		float total_amount = 0;
		float total_quantity = 0;	
		try{
			int i = -1;
			while(rs.next()){
				i = i+1;
				String trans_no = rs.getString(1);
				String year = rs.getString(2);
				String trans_date = rs.getString(3);
				String trans_date_show="";
				try{
					trans_date_show = trans_date.substring(6,8)+"/"+trans_date.substring(4,6)+"/"+trans_date.substring(0,4);
				}catch(Exception e){}
				String mate_no = rs.getString(4);
				String year_mate = rs.getString(5);
				String company_name = rs.getString(6);
				String good_id_mate = rs.getString(7);
				String quantity_mate = rs.getString(8);
				String good_name = rs.getString(9);
				float quantity = rs.getFloat(10);
				total_quantity = total_quantity+quantity;
				float price = rs.getFloat(11);
				float amount = quantity*price;
				total_amount = total_amount+amount;
				String background="";
				int bar = i%2;
				if(bar==0){
					background = "tr1";
				} else background = "tr2";
	%>
				<tr class="<%=background%>" >
					<td align="center"><%=trans_no%>/<%=year%></Td>
					<td align="center" ><%=trans_date_show%></td>
					<td align="center"><%=mate_no%>/<%=year_mate%></Td>
					<td align="left" ><%=company_name%></td>  
					<td align="left" ><%=good_id_mate%>(<%=convertcomma.dtoa(quantity_mate,"#,##0.0")%>)</td>  
					<td align="left" ><%=good_name%></td>
					<td align="right" ><%=convertcomma.dtoa(Float.toString(quantity),"#,##0.0")%> </td>  
					<td align="right" ><%=convertcomma.dtoa(Float.toString(price),"#,##0.00")%></td>
					<td align="right" ><%=convertcomma.dtoa(Float.toString(amount),"#,##0.00")%></td>
				</tr>
<%
			}
		}catch (Exception e){out.println(e);}
%>
	<tr class="tr0" > 
          <td  colspan="6"  ></td>
			<td align="right"><%=convertcomma.dtoa(Float.toString(total_quantity),"#,##0.0")%></td>
		  <td></td>
			<td align="right"><%=convertcomma.dtoa(Float.toString(total_amount),"#,##0.00")%></td>
	</tr>
	</table>
</body>
</html>

<%
		stmt.close();
		}catch (Exception e){out.println(e);}
		myman.returnConnection("csf", con);	
%>
 