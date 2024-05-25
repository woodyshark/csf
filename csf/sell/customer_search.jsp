<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../session.jsp" %>

<%    SQLManager myman = SQLManager.getInstance();
    Connection con = myman.requestConnection("csf");
    try {
        Statement stmt = con.createStatement();
        String keyword = "";
        String status = "";
        String selected1 = "";
        String selected2 = "";
        String good_id = "";
        String start = "";
        String start_dd = "";
        String start_mm = "";
        String start_yy = "";
        String end_dd = "";
        String end_mm = "";
        String end_yy = "";
        ResultSet rs = null;
        String counter = "0";
        String where1 = "";
        String where2 = "";
        String where3 = "";
        try {
            keyword = request.getParameter("keyword");
            status = request.getParameter("status");
            if (status == null) {
                status = "company_name";
            }
            good_id = request.getParameter("good_id");
            if (good_id == null) {
                good_id = "all";
            }
            String keys = keysearch.search(keyword);
            if (status.equals("company_name")) {
                selected1 = "selected";
                where1 = " and (c.company_name like '" + keys + "' or c.name like '" + keys + "') ";
            } else if (status.equals("employee_name")) {
                selected2 = "selected";
                where1 = " and e.first_name like '" + keys + "' ";
            }
            start_dd = request.getParameter("start_dd");
            if (start_dd == null) {
                start_dd = "";
            }
            start_mm = request.getParameter("start_mm");
            if (start_mm == null) {
                start_mm = "";
            }
            start_yy = request.getParameter("start_yy");
            if (start_yy == null) {
                start_yy = "";
            }
            end_dd = request.getParameter("end_dd");
            if (end_dd == null) {
                end_dd = "";
            }
            end_mm = request.getParameter("end_mm");
            if (end_mm == null) {
                end_mm = "";
            }
            end_yy = request.getParameter("end_yy");
            if (end_yy == null) {
                end_yy = "";
            }
            where2 = fromtodate.where(start_dd, start_mm, start_yy, end_dd, end_mm, end_yy, "o.orders_date");
            if (good_id.equals("all")) {
                where3 = " and d.good_id like '%' ";
            } else {
                where3 = " and d.good_id = " + good_id + " ";
            }
//out.print(where2);
        } catch (Exception e) {
            if (keyword == null) {
                keyword = "";
                start = "true";
            }
        }
%>

<html>
    <head><meta equiv="Content-Type" content="text/html; charset=TIS-620">
        <title>Untitled</title>
    </head>
    <body> 
        <font  class="f1">ค้นหาข้อมูลขายสินค้า</font>
        <form action="customer_search.jsp" name="form1" method="post">
            <table width="100%" cellpadding="3" cellspacing="2">
                <tr>
                    <td align="center">
                        <strong>ค้นหา</strong> <input type="Text" class="txt" size="8" name="keyword" value="<%=keyword%>">
                        <strong>โดย</strong> 
                        <select name="status" >
                            <option value="company_name" <%=selected1%>>ชื่อลูกค้า</option>
                            <option value="employee_name" <%=selected2%>>ชื่อพนักงาน</option>
                        </select>
                        <strong>ชื่อสินค้า</strong>  
                        <select name="good_id">
                            <option value="all">ทั้งหมด</option>
                            <%				      
                                rs = stmt.executeQuery("select g.good_id,g.name from good g,good_type t where trans='N' and g.good_type_id=t.good_type_id order by t.name,g.name");
                                while (rs.next()) {
                                    String good_ids = rs.getString(1);
                                    String names = rs.getString(2);
                                    String selected = "";
                                    if (good_id.equals(good_ids)) {
                                        selected = "selected";
                                    } else {
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
                <td align="center"  width="12%">เลขที่ใบขายสินค้า</td>
                <td align="center"  width="12%">ใบสั่งซื้อลงวันที่</td>
                <td align="center" width="33%">ชื่อลูกค้า</td>
                <td align="center"width="13%">ชื่อสินค้า</td>
                <td align="center" width="10%">จำนวน</td>
                <td align="center" width="8%">ราคา</td>
                <td align="center" width="12%">รวมเงิน</td>
            </tr>
            <%
                if (start.equals("true")) {
                } else {		      
                    String queryStr = "select d.orders_no,d.year,(select DISTINCT orders_date from orders o where o.orders_no=d.orders_no and o.year=d.year),(select DISTINCT company_name from client c,orders o where o.client_id=c.client_id and o.orders_no=d.orders_no and o.year=d.year),(select DISTINCT name from client c,orders o where o.client_id=c.client_id and o.orders_no=d.orders_no and o.year=d.year),(select DISTINCT name from good g where g.good_id=d.good_id),(select DISTINCT unit_low from good g where g.good_id=d.good_id),(select DISTINCT unit_high from good g where g.good_id=d.good_id),d.quantity,d.sale,d.sale_unit,d.amount from orders o,client c,orders_detail d where o.client_id=c.client_id and o.orders_no=d.orders_no and o.year=d.year " + where1 + where2 + where3 + " order by o.year desc,o.orders_no desc";
//out.println(queryStr);
                    rs = stmt.executeQuery(queryStr);
                }
                float total_amount = 0;
                float total_quantity = 0;
                try {
                    int i = -1;
                    while (rs.next()) {
                        i = i + 1;
                        String orders_no = rs.getString(1);
                        String year = rs.getString(2);
                        String orders_date = rs.getString(3);
                        String orders_date_show = "";
                        try {
                            orders_date_show = orders_date.substring(6, 8) + "/" + orders_date.substring(4, 6) + "/" + orders_date.substring(0, 4);
                        } catch (Exception e) {
                        }
                        String company_name = rs.getString(4) + "-->" + rs.getString(5);
                        String good_name = rs.getString(6);
                        String unit_low = rs.getString(7);
                        String unit_high = rs.getString(8);
                        float quantity = rs.getFloat(9);
                        total_quantity = total_quantity + quantity;
                        float price = rs.getFloat(10);
                        String price_unit = rs.getString(11);
                        String price_unit_name = "";
                        if (price_unit.equals("1")) {
                            price_unit_name = unit_low;
                        } else {
                            price_unit_name = unit_high;
                        }
                        float amount = rs.getFloat(12);
                        total_amount = total_amount + amount;
                        String background = "";
                        int bar = i % 2;
                        if (bar == 0) {
                            background = "tr1";
                        } else {
                            background = "tr2";
                        }
            %>
            <tr class="<%=background%>" >
                <td align="center"><%=orders_no%>/<%=year%></Td>
                <td align="center" ><%=orders_date_show%></td>
                <td align="left" ><%=company_name%></td>  
                <td align="left" ><%=good_name%></td>
                <td align="right" ><%=convertcomma.dtoa(Float.toString(quantity), "#,##0.0")%> <%=price_unit_name%></td>  
                <td align="right" ><%=convertcomma.dtoa(Float.toString(price), "#,##0.00")%></td>
                <td align="right" ><%=convertcomma.dtoa(Float.toString(amount), "#,##0.00")%></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    StringWriter errors = new StringWriter();
                    e.printStackTrace(new PrintWriter(errors));
                    out.print(errors.toString());
                }
            %>
            <tr class="tr0" > 
                <td  colspan="4"  ></td>
                <td align="right"><%=convertcomma.dtoa(Float.toString(total_quantity), "#,##0.0")%></td>
                <td></td>
                <td align="right"><%=convertcomma.dtoa(Float.toString(total_amount), "#,##0.00")%></td>
            </tr>
        </table>
    </body>
</html>

<%
        stmt.close();
    } catch (Exception e) {
        StringWriter errors = new StringWriter();
        e.printStackTrace(new PrintWriter(errors));
        out.print(errors.toString());
    }
    myman.returnConnection("csf", con);
%>
