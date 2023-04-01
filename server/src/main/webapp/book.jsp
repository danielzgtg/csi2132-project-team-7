<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<fmt:parseDate var="start" pattern="yyyy-MM-dd" value="${param.start}"/>
<fmt:parseDate var="end" pattern="yyyy-MM-dd" value="${param.end}"/>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    INSERT INTO booking_or_renting (address_of_hotel, area_of_hotel, room_id, start_date, end_date, customer_ssn_or_sin, was_booked, is_renting)
    VALUES (?, ?, ?, ?, ?, 123123123, true, false);
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${Integer.parseInt(param.room)}"/>
<sql:dateParam value="${start}"/>
<sql:dateParam value="${end}"/>
</sql:update>
<%@ include file="WEB-INF/header.html" %>
Booking Successful!
<table width="100%" border="1">
<tr><td>Hotel: </td><td>${fn:escapeXml(param.hotel)}</td></tr>
<tr><td>Hotel Area: </td><td>${fn:escapeXml(param.area)}</td></tr>
<tr><td>Room Id: </td><td>${fn:escapeXml(param.room)}</td></tr>
<tr><td>Start Date: </td><td>${fn:escapeXml(param.start)}</td></tr>
<tr><td>End Date: </td><td>${fn:escapeXml(param.end)}</td></tr>
</table>
<a href="search.jsp">Back to Search</a>
<%@ include file="WEB-INF/footer.html" %>
