<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
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
    INSERT INTO room (address_of_hotel, area_of_hotel, room_id, room_price_cents, capacity, extended_capacity, problems_or_damages)
    VALUES (?, ?, ?, ?, ?, ?, '');
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${Integer.parseInt(param.room)}"/>
<sql:param value="${Integer.parseInt(param.price)}"/>
<sql:param value="${Integer.parseInt(param.capacity)}"/>
<sql:param value="${Integer.parseInt(param.capacity)}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
Room added
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td>Price:</td><td><c:out value="${param.price}"/></td></tr>
<tr><td>Capacity:</td><td><c:out value="${param.capacity}"/></td></tr>
<tr><td>Extended Capacity:</td><td><c:out value="${param.capacity}"/></td></tr>
<tr><td>Problems or Damages:</td><td></td></tr>
</table>
<c:url value="room.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
<c:param name="room" value="${param.room}" />
</c:url>
<nav>
<a href="${url}">To Room</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
