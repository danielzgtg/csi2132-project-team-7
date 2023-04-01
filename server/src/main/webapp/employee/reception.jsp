<%@ page import="java.util.Date,java.util.Objects,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
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
    SELECT b.room_id, b.start_date, b.end_date, b.customer_ssn_or_sin, b.is_renting FROM booking_or_renting b
    WHERE b.address_of_hotel = ? AND b.area_of_hotel = ?
    ;
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
</sql:query>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
</table>
<table width="100%" border="1">
<tr>
<th>Room Id</th>
<th>Start Date</th>
<th>End Date</th>
<th>Customer SSN or SIN</th>
<th>Action</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<td>#<c:out value="${row.room_id}"/></td>
<td><c:out value="${row.start_date}"/></td>
<td><c:out value="${row.end_date}"/></td>
<td><c:out value="${row.customer_ssn_or_sin}"/></td>
<td><c:if test="${!row.is_renting}">
<c:url value="reception_confirm.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
<c:param name="room" value="${row.room_id}" />
<c:param name="start" value="${row.start_date}" />
</c:url>
<a href="${url}">Check In</a>
</c:if></td>
</tr>
</c:forEach>
</table>
<c:url value="staffroom.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<nav>
<a href="${url}">Back to Staffroom</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
