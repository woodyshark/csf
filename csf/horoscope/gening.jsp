<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%   
	String title = request.getParameter("title"); 
	String artist = request.getParameter("artist");
	String code = request.getParameter("code");
	int code1 = Integer.parseInt(code)+1;
	String sub_type = request.getParameter("sub_type");
	String file = request.getParameter("file");
	try{
		FileOutputStream fout = new FileOutputStream("f:/file/"+code+".snf", true);
		BufferedOutputStream bout = new BufferedOutputStream(fout);
		PrintStream pout = new PrintStream(bout);
		pout.println("[SongInfo]");
		pout.println("CODE="+code);
		pout.println("TYPE=VIDEO");
		pout.println("SUB_TYPE="+ sub_type);
		pout.println("ALBUM=0");
		pout.println("TITLE="+title);
		pout.println("KEY=C");
		pout.println("TEMPO=0");
		pout.println("ARTIST_TYPE=M");
		pout.println("ARTIST="+artist);		
		pout.println("AUTHOR=0");		
		pout.println("RHYTHM=0");		
		pout.println("CREATOR=Woody");		
		pout.println("COMPANY=Woodpaker");
		pout.println("LANGUAGE=DEFAULT");
		pout.println("YEAR=0");
		pout.println("VOCAL_CHANNEL=RIGHT");
		pout.println("FILE_NAME="+code+"."+file);
		pout.println("START_TIME=0");
		pout.println("STOP_TIME=0");
		pout.println(" ");
		pout.close();
	}catch (FileNotFoundException err){ 
		System.out.println("error is : "+err);
	}

%>
<html>
<head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
	<title>Untitled</title>
	<script language="JavaScript">
		 window.location="gen.jsp?code1=<%=code1%>";
 	 </script>
</head>
<body>
</body>
</html>
