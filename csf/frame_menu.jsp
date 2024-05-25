<%@ page contentType="text/html; charset=windows-874" %>
<%@ include file="session.jsp" %>

<html>
<body>
<table width="100%" cellpadding="3" cellspacing="0">
 <tr><td>Admin</td></tr>
  <tr> 
    <td> <a href="admin/employee_search.jsp" target="frame_center">	พนักงาน</a></td>
  </tr>
  <tr> 
    <td> <a href="admin/client_search.jsp" target="frame_center">ลูกค้า</a></td>
  </tr>
  <tr> 
    <td> <a href="admin/good_search.jsp" target="frame_center">สินค้า</a></td>
  </tr>
 <tr><td>Factory</td></tr>
  <tr> 
    <td> <a href="factory/material_search.jsp" target="frame_center">ใบสั่งซื้อวัตถุดิบ-สินค้า </a></td>
  </tr> 
  <tr> 
    <td> <a href="factory/trans_search.jsp" target="frame_center">วัตถุดิบแปรเป็นสินค้า </a></td>
  </tr>
  <tr> 
    <td> <a href="factory/customer_search.jsp" target="frame_center">ข้อมูลซื้อวัตถุดิบ-สินค้า </a></td>
  </tr>
  <tr> 
    <td> <a href="factory/customer_trans_search.jsp" target="frame_center">ข้อมูลแปรเป็นสินค้า </a></td>
  </tr>
 <tr><td>Warehouse</td></tr>
  <tr> 
    <td> <a href="warehouse/stock_in.jsp" target="frame_center">สินค้าเข้า </a></td>
  </tr>
  <tr> 
    <td> <a href="warehouse/stock_tran.jsp" target="frame_center">สินค้าแปรรูปเข้า </a></td>
  </tr>
  <tr> 
    <td> <a href="warehouse/stock_out.jsp" target="frame_center">สินค้าออก </a></td>
  </tr>
  <tr> 
    <td> <a href="warehouse/stock_search.jsp" target="frame_center">จำนวนสินค้าคงเหลือ </a></td>
  </tr>
 <tr><td>Sell</td></tr>
  <tr> 
    <td> <a href="sell/orders_search.jsp" target="frame_center">ใบขายสินค้า </a></td>
  </tr>
   <tr> 
    <td> <a href="sell/orders_good.jsp" target="frame_center">ใบรายการสินค้า </a></td>
  </tr>
  <tr> 
    <td> <a href="sell/meet_search.jsp" target="frame_center">ใบเสนอราคา </a></td>
  </tr>
   <tr> 
    <td> <a href="sell/meet_add2.jsp" target="frame_center">เพิ่มใบเสนอราคา</a></td>
  </tr>
  <tr> 
    <td> <a href="sell/meet_next_search.jsp" target="frame_center">การนัดพบครั้งต่อไป </a></td>
  </tr>
  <tr> 
    <td> <a href="sell/customer_search.jsp" target="frame_center">ข้อมูลใบขายสินค้า </a></td>
  </tr>
  <tr> 
    <td> <a href="sell/customer_meet_search.jsp" target="frame_center">ข้อมูลใบเสนอราคา </a></td>
  </tr>
 <tr><td>Account</td></tr>
 <tr> 
    <td> <a href="account/material_account.jsp" target="frame_center">บัญชีใบสั่งซื้อวัตถุดิบ </a></td>
  </tr>
  <tr> 
    <td> <a href="account/orders_account.jsp" target="frame_center">บัญชีใบขายสินค้า </a></td>
  </tr>
 <tr><td>Manager</td></tr>
   <tr> 
    <td> <a href="manager/good_who.jsp" target="frame_center">สินค้าอยู่ที่ใคร</a></td>
  </tr>   
  <tr> 
    <td> <a href="manager/orders_manage.jsp" target="frame_center">ทุน-กำไรแต่ละใบสั่งซื้อ</a></td>
  </tr>
  <tr> 
    <td> <a href="manager/good_price.jsp" target="frame_center">จัดการราคาสินค้า</a></td>
  </tr>
    <tr> 
    <td> <a href="manager/stock_manage.jsp" target="frame_center">จัดการสินค้าคงเหลือ</a></td>
  </tr>
    <tr> 
    <td> <a href="manager/balance_sheet.jsp" target="frame_center">งบดุล</a></td>
  </tr>
 <tr><td>----------</td></tr>
    <tr> 
    <td> <a href="horoscope/prophet.jsp" target="frame_center">ดูดวง</a></td>
  </tr>
    <tr> 
    <td> <a href="horoscope/gen.jsp" target="frame_center">คาราโอเกะ</a></td>
  </tr>
    <tr> 
    <td> <a href="horoscope/kara.jsp" target="frame_center">kara</a></td>
  </tr>
     <tr> 
    <td> <a href="horoscope/m.jsp" target="frame_center">m</a></td>
  </tr>
  <tr> 
    <td> <a href="logout.jsp" target="frame_center">ออกจากระบบ </a></td>
  </tr>
</table>
</body>
</html>
