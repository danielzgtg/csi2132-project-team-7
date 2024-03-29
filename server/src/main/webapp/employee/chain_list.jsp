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
    SELECT 1 FROM employee WHERE employee.ssn_or_sin = ?;
    <sql:param value="${authSin}"/>
</sql:query>
<% if (((org.apache.taglibs.standard.tag.common.sql.ResultImpl)
        pageContext.getAttribute("auth")).getRowCount() != 1) { throw new SecurityException(); } %>
<sql:query dataSource="${db}" var="result">
    SELECT chain.address_central_office, chain.contact_email_address, chain.contact_phone_num FROM chain
    WHERE chain.owner_ssn_or_sin = ?
    ;
<sql:param value="${authSin}"/>
</sql:query>
<%@ include file="../WEB-INF/header.html" %>
<h1>Owner</h1>
<table width="100%" border="1">
<tr>
<th>Chain</th>
<th>Email</th>
<th>Phone</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<c:url value="chain.jsp" var="url">
<c:param name="chain" value="${row.address_central_office}" />
</c:url>
<td><a href="${url}"><c:out value="${row.address_central_office}"/></a></td>
<td><c:out value="${row.contact_email_address}"/></td>
<td><c:out value="${row.contact_phone_num}"/></td>
</tr>
</c:forEach>
</table>
<form action="chain_add.jsp" method="post" autocomplete="off">
<table width="100%" border="1">
<tr><td><label for="chain">Central Office Address:</label></td><td><input type="text" id="chain" name="chain"></td></tr>
<tr><td><label for="email">Email:</label></td><td><input type="text" id="email" name="email"></td></tr>
<tr><td><label for="phone">Phone:</label></td><td><input type="text" id="phone" name="phone"></td></tr>
</table>
<button>Add</button>
</form>
<nav>
<a href="profile.jsp">Back</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
