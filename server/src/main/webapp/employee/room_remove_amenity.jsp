<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    DELETE FROM offers
    WHERE offers.address_of_hotel = ?
    AND offers.area_of_hotel = ?
    AND offers.room_id = ?
    AND offers.amenity_name = ?
    ;
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${Integer.parseInt(param.room)}"/>
<sql:param value="${param.amenity}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
Amenity removed
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td>Amenity:</td><td><c:out value="${param.amenity}"/></td></tr>
</table>
<c:url value="room.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
<c:param name="room" value="${param.room}" />
</c:url>
<a href="${url}">Back to Room</a>
<%@ include file="../WEB-INF/footer.html" %>
