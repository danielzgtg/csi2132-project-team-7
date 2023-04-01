<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<% if (!"POST".equals(request.getMethod())) { throw new SecurityException(); } %>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:update dataSource="${db}">
    INSERT INTO hotel (address_of_hotel, area_of_hotel, address_central_office, ranking, contact_email_address, contact_phone_num, manager_ssn_or_sin)
    VALUES (?, ?, ?, ?, ?, ?, ?); 
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
<sql:param value="${param.chain}"/>
<sql:param value="${Integer.parseInt(param.ranking)}"/>
<sql:param value="${param.email}"/>
<sql:param value="${param.phone}"/>
<sql:param value="${123456789}"/>
</sql:update>
<%@ include file="../WEB-INF/header.html" %>
<h1>Owner</h1>
Hotel Added
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Chain:</td><td><c:out value="${param.chain}"/></td></tr>
<tr><td>Ranking:</td><td><c:out value="${param.ranking}"/>-star</td></tr>
<tr><td>Email:</td><td><c:out value="${param.email}"/></td></tr>
<tr><td>Phone:</td><td><c:out value="${param.phone}"/></td></tr>
</table>
<c:url value="staffroom.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<a href="${url}">To Staffroom</a>
<%@ include file="../WEB-INF/footer.html" %>
