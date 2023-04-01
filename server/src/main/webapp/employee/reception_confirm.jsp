<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
<form action="reception_book.jsp" method="post" autocomplete="off">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<input type="hidden" name="room" value="${fn:escapeXml(param.room)}"/>
<input type="hidden" name="start" value="${fn:escapeXml(param.start)}"/>
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Room Id:</td><td><c:out value="${param.room}"/></td></tr>
<tr><td>Start Date:</td><td><c:out value="${param.start}"/></td></tr>
<tr><td><label for="cc">Credit Card:</label></td><td><input type="text" id="cc"></td></tr>
</table>
<button>Confirm</button>
</form>
<c:url value="reception.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<nav>
<a href="${url}">Cancel</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
