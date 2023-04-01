<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    UPDATE chain
    SET contact_email_address = ?, contact_phone_num = ?, owner_ssn_or_sin = ?
    WHERE chain.address_central_office = ?
    ;
<sql:param value="${param.email}"/>
<sql:param value="${param.phone}"/>
<sql:param value="${Integer.parseInt(param.sin)}"/>
<sql:param value="${param.chain}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Owenr</h1>
Chain updated
<table width="100%" border="1">
<tr><td>Central Office Address:</td><td><c:out value="${param.chain}"/></td></tr>
<tr><td>Email:</td><td><c:out value="${param.email}"/></td></tr>
<tr><td>Phone:</td><td><c:out value="${param.phone}"/></td></tr>
<tr><td>Owner SSN or SIN:</td><td><c:out value="${param.sin}"/></td></tr>
</table>
<c:url value="chain.jsp" var="url">
    <c:param name="chain" value="${param.chain}" />
</c:url>
<a href="${url}">Back to Chain</a>
<%@ include file="../WEB-INF/footer.html" %>
