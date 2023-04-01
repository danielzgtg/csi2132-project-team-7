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
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee Booking</h1>
<form action="room_update.jsp" method="post" autocomplete="off">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<input type="hidden" name="room" value="${fn:escapeXml(param.room)}"/>
<table width="100%" border="1">
<c:forEach var="row" items="${result.rows}">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td><label for="price">Price:</label></td><td><input type="number" id="price" name="price" value="${fn:escapeXml(row.room_price_cents)}"> cents</td></tr>
<tr><td><label for="capacity">Capacity:</label></td><td><input type="number" id="capacity" name="capacity" value="${fn:escapeXml(row.capacity)}"></td></tr>
<tr><td><label for="extended">Extended Capacity:</label></td><td><input type="number" id="extended" name="extended" value="${fn:escapeXml(row.extended_capacity)}"></td></tr>
<tr><td><label for="problems">Problems or Damages:</label></td><td><textarea id="problems" name="problems"><c:out value="${row.problems_or_damages}"/></textarea></td></tr>
</c:forEach>
</table>
<button>Update</button>
</form>
<form action="room_delete.jsp" method="post">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<input type="hidden" name="room" value="${fn:escapeXml(param.room)}"/>
<button>Delete</button>
</form>
<form action="room_book.jsp" method="post" autocomplete="off">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<input type="hidden" name="room" value="${fn:escapeXml(param.room)}"/>
<label>Start Date: <input type="date" name="start"></label><br>
<label>End Date: <input type="date" name="end"></label><br>
<label>Customer SSN or SIN: <input type="number" name="sin"></label><br>
<label>Customer Full Name: <input type="text" name="customer"></label><br>
<label>Customer Address: <input type="text" name="address"></label><br>
<label>Credit Card: <input type="text"></label><br>
<button>Book</button>
</form>
<c:url value="staffroom.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<a href="${url}">Back to Staffroom</a>
<%@ include file="../WEB-INF/footer.html" %>
