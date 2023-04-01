<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<fmt:parseDate var="start" pattern="yyyy-MM-dd" value="${param.start}"/>
<fmt:parseDate var="end" pattern="yyyy-MM-dd" value="${param.end}"/>
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
<sql:update dataSource="${db}">
    INSERT INTO customer (ssn_or_sin, full_name, address) VALUES (?, ?, ?) ON CONFLICT DO NOTHING;
<sql:param value="${Integer.parseInt(param.sin)}"/>
<sql:param value="${param.customer}"/>
<sql:param value="${param.address}"/>
</sql:update>
<sql:update dataSource="${db}">
    INSERT INTO booking_or_renting (address_of_hotel, area_of_hotel, room_id, start_date, end_date, customer_ssn_or_sin, was_booked, is_renting)
    VALUES (?, ?, ?, ?, ?, ?, false, true);
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${Integer.parseInt(param.room)}"/>
<sql:dateParam value="${start}"/>
<sql:dateParam value="${end}"/>
<sql:param value="${Integer.parseInt(param.sin)}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
Booking Successful!
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td>Start Date:</td><td><c:out value="${param.start}"/></td></tr>
<tr><td>End Date:</td><td><c:out value="${param.end}"/></td></tr>
<tr><td>Customer SSN or SIN:</td><td><c:out value="${param.sin}"/></td></tr>
</table>
<c:url value="room.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
<c:param name="room" value="${param.room}" />
</c:url>
<nav>
<a href="${url}">Back to Room</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
