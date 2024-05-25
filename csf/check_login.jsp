<%@ page import="com.codestudio.util.*,libs.*,java.io.*,java.util.*,java.sql.*,java.text.*,java.util.Date" %>
<%   
out.println("aaa");
	 SQLManager myman = SQLManager.getInstance();
	 Connection con = myman.requestConnection("csf");
	 out.println("bbb");
	try{
		Statement stmt = con.createStatement();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		ResultSet rs = stmt.executeQuery("select employee_id,first_name,position from employee where upper(username)=upper('"+username+"') and upper(password)=upper('"+password+"') and status='Y'");
		String employee_id=""; String first_name=""; String position="";
		 if (rs.next()){
			employee_id  =rs.getString(1);
			first_name =rs.getString(2);
			position =rs.getString(3);
		} 
		rs.close();
		if ((employee_id.equals("")) || (first_name.equals("")) || (position.equals(""))) { 
%>
			<script language="javascript">
				window.location="login.jsp?u=0";
			</script>
<%    
		}else{ 		
			session.putValue("employee_id",employee_id);
	     	session.putValue("first_name",first_name);
			session.putValue("position",position);
%>
			<script language="javascript">
		       top.location="frame_main.jsp";
			</script>
<%   
		}   
		stmt.close();
	}catch (Exception e){out.println(e);}
	//myman.returnConnection("csf", con);	
 %>
