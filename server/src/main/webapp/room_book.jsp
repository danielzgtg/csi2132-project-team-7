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
<sql:update dataSource="${db}">
    INSERT INTO booking_or_renting (address_of_hotel, area_of_hotel, room_id, start_date, end_date, customer_ssn_or_sin, was_booked, is_renting)
    VALUES (?, ?, ?, ?, ?, ?, true, false);
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${Integer.parseInt(param.room)}"/>
<sql:dateParam value="${start}"/>
<sql:dateParam value="${end}"/>
<sql:param value="${authSin}"/>
</sql:update>
<%@ include file="WEB-INF/header.html" %>
<h1>Customer</h1>
Booking Successful!
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td>Start Date:</td><td><c:out value="${param.start}"/></td></tr>
<tr><td>End Date:</td><td><c:out value="${param.end}"/></td></tr>
</table>
<nav>
<a href="search.jsp">Back to Search</a>
</nav>
<%@ include file="WEB-INF/footer.html" %>
