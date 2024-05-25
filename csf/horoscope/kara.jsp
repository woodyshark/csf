<%@ page import="com.codestudio.util.*,libs.*,java.io.*,java.util.*,java.sql.*,java.text.*,java.util.Date" %>
<%

// set password for root@localhost = old_password('root')  เซ็ตที่ my sql แก้ Communication failure during handshake. Is there a server running on localhost:3306?
// set my.ini แก้ภาษาไทย ทำทีละบรรทัด
// ติดตั้ง mm.mysql-2.0.11-bin.jar ใน config
	Class.forName("org.gjt.mm.mysql.Driver").newInstance();
	java.sql.Connection con;
//	con = DriverManager.getConnection("jdbc:mysql://localhost/kara?user=root&password=root");
	try{ //SELECT number,artist_T,listname_T FROM tbl_data t where number>=001135 and number<=204067
		Statement stmt = con.createStatement();		
		ResultSet rs = stmt.executeQuery("select *from tbl_data where number>=855038 and number<=858056");	
		while(rs.next()){
			String  number = rs.getString("number");
			String  artist_T = rs.getString("artist_T");
			String  listname_T = rs.getString("listname_T");
				try{
					FileOutputStream fout = new FileOutputStream("j:/file/"+number+".snf", true);
					BufferedOutputStream bout = new BufferedOutputStream(fout);
					PrintStream pout = new PrintStream(bout);
					pout.println("[SongInfo]");
					pout.println("CODE="+number);
					pout.println("TYPE=VIDEO");
					pout.println("SUB_TYPE=MPG");
					pout.println("ALBUM=0");
					pout.println("TITLE="+listname_T);
					pout.println("KEY=C");
					pout.println("TEMPO=0");
					pout.println("ARTIST_TYPE=M");
					pout.println("ARTIST="+artist_T);		
					pout.println("AUTHOR=0");		
					pout.println("RHYTHM=0");		
					pout.println("CREATOR=Woody");		
					pout.println("COMPANY=Woodpaker");
					pout.println("LANGUAGE=DEFAULT");
					pout.println("YEAR=0");
					pout.println("VOCAL_CHANNEL=RIGHT");
					pout.println("FILE_NAME="+number+".mpg");
					pout.println("START_TIME=0");
					pout.println("STOP_TIME=0");
					pout.println(" ");
					pout.close();
				}catch (FileNotFoundException err){ 
					System.out.println("error is : "+err);
				}
				out.print("filename="+number);
			}
		}catch (Exception e){out.println(e);}
%>
 