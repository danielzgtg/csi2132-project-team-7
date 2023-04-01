<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/header.html" %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:query dataSource="${db}" var="result">
    SELECT role.name FROM role;
</sql:query>
<h1>Manager</h1>
<form action="hr_hire.jsp" method="post" autocomplete="off">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<input type="hidden" name="sin" value="${fn:escapeXml(param.sin)}"/>
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>SSN or SIN:</td><td><c:out value="${param.sin}"/></td></tr>
<tr><td><label for="role">Role</label></td><td><select name="role" id="role">
<c:forEach var="role" items="${result.rows}">
<li><c:out value="${role.name}"/>
<option value="${fn:escapeXml(role.name)}"><c:out value="${role.name}"/></option></li>
</c:forEach>
</select></td></tr>
</table>
<button>Hire</button>
</form>
<c:url value="hr.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<a href="${url}">Cancel</a>
<%@ include file="../WEB-INF/footer.html" %>
