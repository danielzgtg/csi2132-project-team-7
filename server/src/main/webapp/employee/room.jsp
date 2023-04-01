<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<% int authSin = 0;
    for (Cookie cookie : request.getCookies()) { if ("employee".equals(cookie.getName())) {
        authSin = Integer.parseInt(cookie.getValue());
    } }
    if (authSin == 0) throw new SecurityException();
    pageContext.setAttribute("authSin", authSin); %>
<sql:query dataSource="${db}" var="auth">
    ( SELECT 1 FROM employment e WHERE e.address_of_hotel = ? AND e.area_of_hotel = ? AND e.employee_ssn_or_sin = ? )
    UNION
    ( SELECT 1 FROM hotel WHERE hotel.address_of_hotel = ? AND hotel.area_of_hotel = ? AND hotel.manager_ssn_or_sin = ? )
    ;
    <sql:param value="${param.hotel}"/>
    <sql:param value="${param.area}"/>
    <sql:param value="${authSin}"/>
    <sql:param value="${param.hotel}"/>
    <sql:param value="${param.area}"/>
    <sql:param value="${authSin}"/>
</sql:query>
<% if (((org.apache.taglibs.standard.tag.common.sql.ResultImpl)
        pageContext.getAttribute("auth")).getRowCount() != 1) { throw new SecurityException(); } %>
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
<sql:query dataSource="${db}" var="amenities_have">
    SELECT offers.amenity_name FROM offers
    WHERE offers.room_id = ?
    AND offers.address_of_hotel = ?
    AND offers.area_of_hotel = ?;
<sql:param value="${Integer.parseInt(param.room)}"/>
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
</sql:query>
<sql:query dataSource="${db}" var="amenities_all">
    SELECT amenity.name FROM amenity;
</sql:query>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
<form action="room_remove_amenity.jsp" method="post" autocomplete="off" id="remove_amenity">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<input type="hidden" name="room" value="${fn:escapeXml(param.room)}"/>
</form>
<form action="room_update.jsp" method="post" autocomplete="off" id="update">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<input type="hidden" name="room" value="${fn:escapeXml(param.room)}"/>
</form>
<table width="100%" border="1">
<c:forEach var="row" items="${result.rows}">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td><label for="price">Price:</label></td><td><input form="update" type="number" id="price" name="price" value="${fn:escapeXml(row.room_price_cents)}"> cents</td></tr>
<tr><td><label for="capacity">Capacity:</label></td><td><input form="update" type="number" id="capacity" name="capacity" value="${fn:escapeXml(row.capacity)}"></td></tr>
<tr><td><label for="extended">Extended Capacity:</label></td><td><input form="update" type="number" id="extended" name="extended" value="${fn:escapeXml(row.extended_capacity)}"></td></tr>
<tr><td><label for="problems">Problems or Damages:</label></td><td><textarea form="update" id="problems" name="problems"><c:out value="${row.problems_or_damages}"/></textarea></td></tr>
<tr><td>Amenities:</td><td><ul>
<c:forEach var="amenity" items="${amenities_have.rows}">
<li><c:out value="${amenity.amenity_name}"/>
<button form="remove_amenity" name="amenity" value="${fn:escapeXml(amenity.amenity_name)}">X</button></li>
</c:forEach>
</ul></td></tr>
</c:forEach>
</table>
<button form="update">Update</button>
<form action="room_add_amenity.jsp" method="post" autocomplete="off">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<input type="hidden" name="room" value="${fn:escapeXml(param.room)}"/>
<label>Amenity: <select name="amenity">
<c:forEach var="amenity" items="${amenities_all.rows}">
<li><c:out value="${amenity.name}"/>
<option value="${fn:escapeXml(amenity.name)}"><c:out value="${amenity.name}"/></option></li>
</c:forEach>
</select></label>
<button>Add</button>
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
<nav>
<a href="${url}">Back to Staffroom</a>
    
<%@ include file="../WEB-INF/footer.html" %>
