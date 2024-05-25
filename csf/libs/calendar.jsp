<%@ page contentType="text/html; charset=windows-874" %>
<%
	String rtnid = request.getParameter("o_rtnid_hd");
	String opn = request.getParameter("o_opn_hd");
%>
<HTML>
<HEAD>
  <link rel="stylesheet" href="style.css">
  <style type="text/css">
<!--
 body {  margin: 0px  0px; padding: 0px  0px}
-->
</style>
  <TITLE>Calendar</TITLE>
<SCRIPT language="JavaScript">
var now    = new Date();
var absnow = now;
function wrtCalendar(iMove){	 
	var tabidx = 0; 
	var focusid = -1; 
  	var focusmonth = -1;
  	if(!arguments) iMove=0;
  	if(iMove==0) now = new Date();
  	nowdate  = now.getDate();
  	nowmonth = now.getMonth();
  	nowyear  = now.getYear();
  	if(nowmonth==11 && iMove > 0){
    	nowmonth = -1 + iMove ; nowyear++;
  	} else if(nowmonth==0 && iMove < 0){
    	nowmonth = 12 + iMove ; nowyear--;
  	} else {
    	nowmonth +=  iMove;
  	}
  	if(nowyear<1900) nowyear=1900+nowyear;
  	now = new Date(nowyear,nowmonth,1);
  	focusmonth = nowmonth;
  	var nowyyyymm= nowyear*100+nowmonth;
  	nowmonth = (nowmonth+1);
  	if (nowmonth.toString().length==1){
		nowmonth = '0' + nowmonth;
  	}
  	nowtitleyyyymm=nowyear+'/'+nowmonth;
	week = new Array('อา','จ','อ','พ','พฤ','ศ','ส');
  	fstday   = now;                                      
  	startday = fstday - ( fstday.getDay() * 1000*60*60*24 );  
  	startday = new Date(startday);
	document.body.style.display="none";
  	ddata = '';
  	ddata += '<FORM NAME="o_search_frm">\n';
  	ddata += '<TABLE name="tbl" BORDER=1 BGCOLOR=#64934C  BORDERCOLOR=#FFFFFF WIDTH=140 HEIGHT=140 align="center">\n';
  	ddata += '   <TR id="trmonth" BGCOLOR=#065C04 BORDERCOLOR=64934C WIDTH=140 HEIGHT=14>\n';
  	ddata += '   <TH COLSPAN=7 WIDTH=140 HEIGHT=14 ALIGN="right"><NOBR><FONT COLOR=#ECFFE2>\n';
  	ddata +=       nowtitleyyyymm;
  	ddata += '</FONT>&nbsp;<INPUT TYPE=button name="o_previous_btn" VALUE="<<" onClick="wrtCalendar(-1);" class="knop">\n';
  	ddata += '<INPUT TYPE=button name="o_home_btn" VALUE="o" onClick="wrtCalendar(0);" class="knop">\n';
  	ddata += '<INPUT TYPE=button name="o_next_btn"  VALUE=">>" onClick="wrtCalendar(1);" class="knop">\n';
  	ddata += '</NOBR></TH>\n';
  	ddata += '   </TR>\n'
  	ddata += '   <TR BGCOLOR=#F8C71E WIDTH=140 HEIGHT=14>\n';
  	for (i=0;i<7;i++){
    	ddata += '   <TH WIDTH=14 HEIGHT=14>\n';
    	ddata +=       week[i];
    	ddata += '   </TH>\n';
  	}
  	ddata += '   </TR>\n';
  	dayidx = -1;
  	for(j=0;j<6;j++){
    	ddata += '   <TR BGCOLOR=#ffffff>\n';
    	for(i=0;i<7;i++){
	  		dayidx++;
      		nextday = startday.getTime() + (i * 1000*60*60*24);
      		wrtday  = new Date(nextday);
      		wrtdate = wrtday.getDate();
      		wrtmonth= wrtday.getMonth();
      		wrtyear = wrtday.getYear();
      		if(wrtyear < 1900) wrtyear=1900 + wrtyear;
      		wrtyyyymm = wrtyear * 100 + wrtmonth;
	  		if (wrtdate.toString().length==1){
				wrtdate = '0' + wrtdate;
	 	 	}
	  		wrtmonth = (wrtmonth+1);
	  		if (wrtmonth.toString().length==1){
				wrtmonth = '0' + wrtmonth;
	  		}
      		wrtyyyymmdd= ''+wrtyear + wrtmonth + wrtdate;
      		wrtdateA  = '<A id="o_day_lnk" HREF="javascript:returnDate(\'' + wrtyyyymmdd +'\');"" ';
      		wrtdateA += ' tabindex="' + (++tabidx) + '">\n';
      		wrtdateA += '<FONT COLOR=#000000>\n';
      		wrtdateA += wrtdate;
      		wrtdateA += '</FONT>\n';
      		wrtdateA += '</A>\n';
      		if(wrtyyyymm != nowyyyymm){ 
        		ddata += ' <TD BGCOLOR=#B8C7B7 WIDTH=14 HEIGHT=14>\n';
        		ddata += wrtdateA;
      		} else if(wrtday.getDate() == absnow.getDate() && wrtday.getMonth() == absnow.getMonth() && wrtday.getYear() == absnow.getYear()){
	  			if (wrtday.getDate() == 1 && wrtday.getMonth() == focusmonth) focusid = dayidx;
        			ddata += ' <TD BGCOLOR=#FFABAB WIDTH=14 HEIGHT=14>\n';
        			ddata += '<FONT COLOR="#ffffff">'+wrtdateA+'</FONT>\n';
      		} else {
	  			if (wrtday.getDate() == 1 && wrtday.getMonth() == focusmonth) focusid = dayidx;
        		ddata += ' <TD WIDTH=14 HEIGHT=14>\n';
        		ddata += wrtdateA;
      		}
      		ddata += '   </TD>\n';
    	}
    	ddata += '   </TR>\n';
    	startday = new Date(nextday);
    	startday = startday.getTime() + (1000*60*60*24);
    	startday = new Date(startday);
	}
  	ddata += '   <TR>\n';
  	ddata += '   <TD COLSPAN=7 ALIGN=center>\n';
  	ddata += '   <INPUT TYPE=button name="o_close_btn" Style="width:60px; HEIGHT: 20px;" VALUE="ยกเลิก" onClick="self.close();return false" class="knop">\n';
	ddata += '   </TD>\n';
  	ddata += '   </TR>\n';
  	ddata += '</TABLE><br>\n';
  	ddata += '</FORM>\n';
	document.body.style.display="";
  	document.body.innerHTML = ddata;
	setTabIndex();
  	window.focus();
  	if (document.all.o_day_lnk) {
    	if (focusid !== -1) {
    		document.all.o_day_lnk[focusid].focus();
    	}
  	}
}
function returnDate(dSelete){
  var strYear = new String(dSelete.slice(0,4));
  var strMonth = new String(dSelete.slice(4,6));
  var strDay = new String(dSelete.slice(6,8));
  var strDate = strYear + strMonth + strDay
  if (<%=opn%>) {
		var fname = "<%=opn%>.setCalendarInfo";
		if (eval(fname)) {
			<%=opn%>.setCalendarInfo( "<%=rtnid%>",
										strDate
										);	
		}
	}
	window.close();
}
function chkParent() {
	if (<%=opn%>.closed) {
		window.close();
	}
}
function setTabIndex() {
	with (o_search_frm) {
		var tabOrder = new Array(
			o_home_btn, 43, 
			o_next_btn, 44,
			o_previous_btn, 45,
			o_close_btn, 46 
		);
		setTabOrder(tabOrder);
	}
}
function setTabOrder(pattern) {
    if(pattern==null) return;
    for(var i=0; i<pattern.length; i=i+2) {
        pattern[i].tabIndex = pattern[i+1];
    }
}
</SCRIPT>
	<link rel="stylesheet" href="style.css">
</HEAD>
<BODY language="JavaScript" onload="wrtCalendar(0);" bgcolor="#64934C">
	<P><SCRIPT language="JavaScript">setInterval(chkParent, 100);</SCRIPT></P>
</BODY>
</HTML>
