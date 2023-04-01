<%@ page import="java.util.Date,java.util.Objects,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:query dataSource="${db}" var="result">
    SELECT p.ssn_or_sin, e.role_name FROM employee p
    LEFT JOIN (
    SELECT e.employee_ssn_or_sin, e.role_name FROM employment e
    WHERE e.address_of_hotel = ? AND e.area_of_hotel = ?
    ) e ON p.ssn_or_sin = e.employee_ssn_or_sin
    ;
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
</sql:query>
<%@ include file="../WEB-INF/header.html" %>
<h1>Manager</h1>
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
</table>
<form action="hr_confirm.jsp" id="hire">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
</form>
<form action="hr_fire.jsp" method="post" id="fire">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
</form>
<table width="100%" border="1">
<tr>
<th>SSN or SIN</th>
<th>Role</th>
<th>Action</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<td><c:out value="${row.ssn_or_sin}"/></td>
<td><c:out value="${row.role_name}"/></td>
<td><c:if test="${row.role_name == null}">
<button form="hire" name="sin" value="${fn:escapeXml(row.ssn_or_sin)}">Hire</button>
</c:if><c:if test="${row.role_name != null}">
<button form="fire" name="sin" value="${fn:escapeXml(row.ssn_or_sin)}">Fire</button>
</c:if></td>
</tr>
</c:forEach>
</table>
<c:url value="staffroom.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<a href="${url}">Back to Staffroom</a>
<%@ include file="../WEB-INF/footer.html" %>
