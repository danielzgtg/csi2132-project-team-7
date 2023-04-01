<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<% int authSin = 0;
    for (Cookie cookie : request.getCookies()) { if ("customer".equals(cookie.getName())) {
        authSin = Integer.parseInt(cookie.getValue());
    } }
    if (authSin == 0) throw new SecurityException();
    pageContext.setAttribute("authSin", authSin); %>
<sql:query dataSource="${db}" var="result">
    SELECT customer.full_name, customer.address, customer.registration_date FROM customer
    WHERE customer.ssn_or_sin = ?
    LIMIT 1;
    <sql:param value="${authSin}"/>
</sql:query>
<% if (((org.apache.taglibs.standard.tag.common.sql.ResultImpl)
        pageContext.getAttribute("result")).getRowCount() != 1) { throw new SecurityException(); } %>
<%@ include file="WEB-INF/header.html" %>
<nav>
<a href="search.jsp">Search</a>
</nav>
<form action="profile_update.jsp" method="post" autocomplete="off">
<table width="100%" border="1">
<c:forEach var="row" items="${result.rows}">
<tr><td>SSN or SIN:</td><td><c:out value="${authSin}"/></td></tr>
<tr><td>Registration Date:</td><td><c:out value="${row.registration_date}"/></td></tr>
<tr><td><label for="name">Full Name:</label></td><td><input type="text" id="name" name="name" value="${fn:escapeXml(row.full_name)}"></td></tr>
<tr><td><label for="address">Address:</label></td><td><input type="text" id="address" name="address" value="${fn:escapeXml(row.address)}"></td></tr>
</c:forEach>
</table>
<button>Update</button>
</form>
<form action="profile_delete.jsp" method="post">
<button>Delete Profile</button>
</form>
<form action="profile_deauth.jsp" method="post">
<button>Log Out</button>
</form>
<%@ include file="WEB-INF/footer.html" %>
