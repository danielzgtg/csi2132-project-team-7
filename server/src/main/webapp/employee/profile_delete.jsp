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
<sql:query dataSource="${db}" var="result">
    SELECT 1 FROM employee WHERE employee.ssn_or_sin = ? LIMIT 1;
    <sql:param value="${authSin}"/>
</sql:query>
<% if (((org.apache.taglibs.standard.tag.common.sql.ResultImpl)
        pageContext.getAttribute("result")).getRowCount() != 1) { throw new SecurityException(); } %>
<sql:update dataSource="${db}">
    DELETE FROM employee WHERE employee.ssn_or_sin = ?;
<sql:param value="${authSin}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
Employee deleted
<table width="100%" border="1">
<tr><td>SSN or SIN:</td><td><c:out value="${authSin}"/></td></tr>
</table>
<nav>
<a href="profile_login.jsp">Back</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
<%
    Cookie cookie = new Cookie("employee", "");
    cookie.setMaxAge(0);
    response.addCookie(cookie);
%>
