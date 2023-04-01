<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    UPDATE room
    SET room_price_cents = ?, capacity = ?, extended_capacity = ?, problems_or_damages = ? 
    WHERE room.address_of_hotel = ? AND room.area_of_hotel = ? AND room.room_id = ?;
<sql:param value="${Integer.parseInt(param.price)}"/>
<sql:param value="${Integer.parseInt(param.capacity)}"/>
<sql:param value="${Integer.parseInt(param.extended)}"/>
<sql:param value="${param.problems}"/>
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${Integer.parseInt(param.room)}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
Room updated
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td>Price:</td><td><c:out value="${fn:escapeXml(param.price)}"/></td></tr>
<tr><td>Capacity:</td><td><c:out value="${fn:escapeXml(param.capacity)}"/></td></tr>
<tr><td>Extended Capacity:</td><td><c:out value="${fn:escapeXml(param.extended)}"/></td></tr>
<tr><td>Problems or Damages:</td><td><c:out value="${param.problems}"/></td></tr>
</table>
<c:url value="room.jsp" var="url">
<c:param name="room" value="${param.room}" />
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<a href="${url}">Back to Room</a>
<%@ include file="../WEB-INF/footer.html" %>
