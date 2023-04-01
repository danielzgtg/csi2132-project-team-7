<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<% int authSin = 0;
    for (Cookie cookie : request.getCookies()) { if ("customer".equals(cookie.getName())) {
        authSin = Integer.parseInt(cookie.getValue());
    } }
    if (authSin == 0) throw new SecurityException();
    pageContext.setAttribute("authSin", authSin); %>
<sql:query dataSource="${db}" var="auth">
    SELECT 1 FROM customer WHERE customer.ssn_or_sin = ?;
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
<%@ include file="WEB-INF/header.html" %>
<h1>Customer</h1>
<table width="100%" border="1">
<c:forEach var="row" items="${result.rows}">
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Price:</td><td><c:out value="${row.room_price_cents}"/> cents</td></tr>
<tr><td>Capacity:</td><td><c:out value="${row.capacity}"/></td></tr>
<tr><td>Extended Capacity:</td><td><c:out value="${row.extended_capacity}"/></td></tr>
<tr><td>Problems or Damages:</td><td><c:out value="${row.problems_or_damages}"/></td></tr>
<tr><td>Amenities:</td><td><ul>
<c:forEach var="amenity" items="${amenities_have.rows}">
<li><c:out value="${amenity.amenity_name}"/></li>
</c:forEach>
</ul></td></tr>
</c:forEach>
</table>
<form action="room_book.jsp" method="post" autocomplete="off">
<input type="hidden" name="room" value="${fn:escapeXml(param.room)}"/>
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<label>Start Date: <input type="date" name="start" value="${fn:escapeXml(param.start)}"></label>
<label>End Date: <input type="date" name="end" value="${fn:escapeXml(param.end)}"></label>
<button>Book</button>
</form>
<nav>
<a href="search.jsp">Back to Search</a>
</nav>
<%@ include file="WEB-INF/footer.html" %>
