<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:query dataSource="${db}" var="result">
    SELECT room.room_price_cents, room.capacity, room.extended_capacity, room.problems_or_damages FROM room
    WHERE room.room_id = ?
    AND room.address_of_hotel = ?
    AND room.area_of_hotel = ?
    LIMIT 1;
<sql:param value="${Integer.parseInt(param.room)}"/>
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
</sql:query>
<%@ include file="WEB-INF/header.html" %>
<h1>Customer Booking</h1>
<table width="100%" border="1">
<c:forEach var="row" items="${result.rows}">
<tr><td>Room Id: </td><td>${fn:escapeXml(param.room)}</td></tr>
<tr><td>Hotel: </td><td>${fn:escapeXml(param.hotel)}</td></tr>
<tr><td>Hotel Area: </td><td>${fn:escapeXml(param.area)}</td></tr>
<tr><td>Price: </td><td>${fn:escapeXml(row.room_price_cents)} cents</td></tr>
<tr><td>Capacity</td><td>${fn:escapeXml(row.capacity)}</td></tr>
<tr><td>Extended Capacity</td><td>${fn:escapeXml(row.extended_capacity)}</td></tr>
<tr><td>Problems or Damages</td><td>${fn:escapeXml(row.problems_or_damages)}</td></tr>
</c:forEach>
</table>
<form action="room_book.jsp" method="post">
<input type="number" name="room" hidden value="${fn:escapeXml(param.room)}"/>
<input type="text" name="hotel" hidden value="${fn:escapeXml(param.hotel)}"/>
<input type="text" name="area" hidden value="${fn:escapeXml(param.area)}"/>
<label>Start Date: <input type="date" name="start" value="${fn:escapeXml(param.start)}"></label>
<label>End Date: <input type="date" name="end" value="${fn:escapeXml(param.end)}"></label>
<button>Book</button>
</form>
<%@ include file="WEB-INF/footer.html" %>
