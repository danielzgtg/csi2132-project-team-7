<%@ page import="java.util.Date,java.util.Objects,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:query dataSource="${db}" var="chain">
    SELECT chain.contact_email_address, chain.contact_phone_num, chain.owner_ssn_or_sin FROM chain
    WHERE chain.address_central_office = ?
    ;
<sql:param value="${param.chain}"/>
</sql:query>
<sql:query dataSource="${db}" var="hotels">
    SELECT hotel.address_of_hotel, hotel.area_of_hotel FROM hotel
    WHERE hotel.address_central_office = ?;
    ;
<sql:param value="${param.chain}"/>
</sql:query>
<%@ include file="../WEB-INF/header.html" %>
<h1>Owner</h1>
<form action="chain_update.jsp" method="post" autocomplete="off">
<input type="hidden" name="chain" value="${fn:escapeXml(param.chain)}"/>
<table width="100%" border="1">
<c:forEach var="row" items="${chain.rows}">
<tr><td>Central Office Address:</td><td><c:out value="${param.chain}"/></td></tr>
<tr><td><label for="email">Email:</label></td><td><input type="text" id="email" name="email" value="${fn:escapeXml(row.contact_email_address)}"></td></tr>
<tr><td><label for="phone">Phone:</label></td><td><input type="text" id="phone" name="phone" value="${fn:escapeXml(row.contact_phone_num)}"></td></tr>
<tr><td><label for="sin">Owner SSN or SIN:</label></td><td><input type="number" id="sin" name="sin" value="${fn:escapeXml(row.owner_ssn_or_sin)}"></td></tr>
</c:forEach>
</table>
<button>Update</button>
</form>
<form action="chain_delete.jsp" method="post">
<input type="hidden" name="chain" value="${fn:escapeXml(param.chain)}"/>
<button>Delete</button>
</form>
<table width="100%" border="1">
<tr>
<th>Hotel Address</th>
<th>Area</th>
</tr>
<c:forEach var="row" items="${hotels.rows}">
<tr>
<c:url value="staffroom.jsp" var="url">
<c:param name="hotel" value="${row.address_of_hotel}" />
<c:param name="area" value="${row.area_of_hotel}" />
</c:url>
<td><a href="${url}"><c:out value="${row.address_of_hotel}"/></a></td>
<td><c:out value="${row.area_of_hotel}"/></td>
</tr>
</c:forEach>
</table>
<form action="staffroom_add.jsp" method="post" autocomplete="off">
<input type="hidden" name="chain" value="${fn:escapeXml(param.chain)}"/>
<table width="100%" border="1">
<tr><td>Chain:</td><td><c:out value="${param.chain}"/></td></tr>
<tr><td><label for="hotel">Hotel Address:</label></td><td><input type="text" id="hotel" name="hotel"></td></tr>
<tr><td><label for="area">Hotel Area:</label></td><td><input type="text" id="area" name="area"></td></tr>
<tr><td><label for="ranking">Ranking:</label></td><td><select name="ranking" id="ranking">
<option value="1">1-star</option>
<option value="2">2-star</option>
<option value="3">3-star</option>
<option value="4">4-star</option>
<option value="5">5-star</option>
</select></td></tr>
<tr><td><label for="email_">Email:</label></td><td><input type="text" id="email_" name="email"></td></tr>
<tr><td><label for="phone_">Phone:</label></td><td><input type="text" id="phone_" name="phone"></td></tr>
</table>
<button>Add</button>
</form>
<a href="chain_list.jsp">Back to Chains</a>
<%@ include file="../WEB-INF/footer.html" %>
