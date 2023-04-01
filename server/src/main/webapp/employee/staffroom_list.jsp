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
    SELECT hotel.address_of_hotel, hotel.area_of_hotel, hotel.address_central_office FROM hotel
    WHERE EXISTS (
    SELECT 1 FROM employment
    WHERE hotel.address_of_hotel = employment.address_of_hotel
    AND hotel.area_of_hotel = employment.area_of_hotel
    AND employment.employee_ssn_or_sin = ?
    ) OR hotel.manager_ssn_or_sin = ?
    ;
<sql:param value="${authSin}"/>
<sql:param value="${authSin}"/>
</sql:query>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
<table width="100%" border="1">
<tr>
<th>Hotel</th>
<th>Hotel Area</th>
<th>Chain</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<c:url value="staffroom.jsp" var="url">
<c:param name="hotel" value="${row.address_of_hotel}" />
<c:param name="area" value="${row.area_of_hotel}" />
</c:url>
<td><a href="${url}"><c:out value="${row.address_of_hotel}"/></a></td>
<td><c:out value="${row.area_of_hotel}"/></td>
<td><c:out value="${row.address_central_office}"/></td>
</tr>
</c:forEach>
</table>
<nav>
<a href="profile.jsp">Back</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
