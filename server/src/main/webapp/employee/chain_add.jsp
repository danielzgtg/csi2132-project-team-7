<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    INSERT INTO chain (address_central_office, contact_email_address, contact_phone_num, owner_ssn_or_sin)
    VALUES (?, ?, ?, ?);
<sql:param value="${param.chain}"/>
<sql:param value="${param.email}"/>
<sql:param value="${param.phone}"/>
<sql:param value="${123456789}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Owner</h1>
Chain Added
<table width="100%" border="1">
<tr><td>Central Office Address:</td><td><c:out value="${param.chain}"/></td></tr>
<tr><td>Email:</td><td><c:out value="${param.email}"/></td></tr>
<tr><td>Phone:</td><td><c:out value="${param.phone}"/></td></tr>
</table>
<c:url value="chain.jsp" var="url">
<c:param name="chain" value="${param.chain}" />
</c:url>
<a href="${url}">To Chain</a>
<%@ include file="../WEB-INF/footer.html" %>
