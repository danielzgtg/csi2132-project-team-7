<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    INSERT INTO employee (ssn_or_sin, full_name, address)
    VALUES (?, ?, ?);
<sql:param value="${Integer.valueOf(param.sin)}"/>
<sql:param value="${param.name}"/>
<sql:param value="${param.address}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
Employee registered
<table width="100%" border="1">
<tr><td>SSN or SIN:</td><td><c:out value="${param.sin}"/></td></tr>
<tr><td>Full Name:</td><td><c:out value="${param.name}"/></td></tr>
<tr><td>Address:</td><td><c:out value="${param.address}"/></td></tr>
</table>
<nav>
<a href="profile_login.jsp">Back</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
