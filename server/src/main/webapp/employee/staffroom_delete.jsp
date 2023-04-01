<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    DELETE FROM hotel WHERE hotel.address_of_hotel = ? AND hotel.area_of_hotel = ?;
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
Hotel deleted
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
</table>
<a href="hotels.jsp">Back to Hotels</a>
<%@ include file="../WEB-INF/footer.html" %>
