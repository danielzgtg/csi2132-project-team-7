<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    INSERT INTO employment (address_of_hotel, area_of_hotel, employee_ssn_or_sin, role_name)
    VALUES (?, ?, ?, ?); 
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${Integer.parseInt(param.sin)}"/>
<sql:param value="${param.role}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Manager</h1>
Employee hired
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>SSN or SIN:</td><td><c:out value="${param.sin}"/></td></tr>
<tr><td>Role:</td><td><c:out value="${param.role}"/></td></tr>
</table>
<c:url value="hr.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<a href="${url}">Back to HR</a>
<%@ include file="../WEB-INF/footer.html" %>
