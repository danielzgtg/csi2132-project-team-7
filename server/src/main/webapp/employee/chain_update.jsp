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
    SELECT 1 FROM employee WHERE employee.ssn_or_sin = ?;
    <sql:param value="${authSin}"/>
</sql:query>
<% if (((org.apache.taglibs.standard.tag.common.sql.ResultImpl)
        pageContext.getAttribute("auth")).getRowCount() != 1) { throw new SecurityException(); } %>
<sql:update dataSource="${db}">
    UPDATE chain
    SET contact_email_address = ?, contact_phone_num = ?, owner_ssn_or_sin = ?
    WHERE chain.address_central_office = ? AND chain.owner_ssn_or_sin = ?
    ;
<sql:param value="${param.email}"/>
<sql:param value="${param.phone}"/>
<sql:param value="${Integer.parseInt(param.sin)}"/>
<sql:param value="${param.chain}"/>
<sql:param value="${authSin}"/>
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
<nav>
<a href="${url}">Back to Chain</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
