<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<fmt:parseDate var="start" pattern="yyyy-MM-dd" value="${param.start}"/>
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
    UPDATE booking_or_renting b
    SET is_renting = true
    WHERE b.address_of_hotel = ?
    AND b.area_of_hotel = ?
    AND b.room_id = ?
    AND b.start_date = ?
    AND b.was_booked = true
    AND b.is_renting = false
    ;
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${Integer.parseInt(param.room)}"/>
<sql:dateParam value="${start}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
Booking Successful!
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td>Start Date:</td><td><c:out value="${param.start}"/></td></tr>
</table>
<c:url value="reception.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<nav>
<a href="${url}">Back to Front Desk</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
