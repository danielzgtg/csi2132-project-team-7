<%@ page import="java.util.Date,java.util.Objects,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:query dataSource="${db}" var="hotel">
    SELECT hotel.address_central_office, hotel.ranking, hotel.contact_email_address, hotel.contact_phone_num, hotel.manager_ssn_or_sin FROM hotel
    WHERE hotel.address_of_hotel = ? AND hotel.area_of_hotel = ?
    ;
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
</sql:query>
<sql:query dataSource="${db}" var="rooms">
    SELECT room.room_id, room.room_price_cents, room.capacity FROM room
    WHERE room.address_of_hotel = ? AND room.area_of_hotel = ?
    ;
<sql:param value="${param.hotel}"/>
<sql:param value="${param.area}"/>
</sql:query>
<%@ include file="../WEB-INF/header.html" %>
<h1>Employee</h1>
<c:url value="reception.jsp" var="reception">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
</c:url>
<a href="${reception}">To Front Desk</a>
<form action="staffroom_update.jsp" method="post" autocomplete="off">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<table width="100%" border="1">
<c:forEach var="row" items="${hotel.rows}">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td>Chain:</td><td><c:out value="${row.address_central_office}"/></td></tr>
<tr><td><label for="ranking">Ranking:</label></td><td><select name="ranking" id="ranking">
<option value="1" ${row.ranking == 1 ? "selected" : ""}>1-star</option>
<option value="2" ${row.ranking == 2 ? "selected" : ""}>2-star</option>
<option value="3" ${row.ranking == 3 ? "selected" : ""}>3-star</option>
<option value="4" ${row.ranking == 4 ? "selected" : ""}>4-star</option>
<option value="5" ${row.ranking == 5 ? "selected" : ""}>5-star</option>
</select></td></tr>
<tr><td><label for="email">Email:</label></td><td><input type="text" id="email" name="email" value="${fn:escapeXml(row.contact_email_address)}"></td></tr>
<tr><td><label for="phone">Phone:</label></td><td><input type="text" id="phone" name="phone" value="${fn:escapeXml(row.contact_phone_num)}"></td></tr>
<tr><td><label for="sin">Manager SSN or SIN:</label></td><td><input type="number" id="sin" name="sin" value="${fn:escapeXml(row.manager_ssn_or_sin)}"></td></tr>
</c:forEach>
</table>
<button>Update</button>
</form>
<form action="staffroom_delete.jsp" method="post">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<button>Delete</button>
</form>
<table width="100%" border="1">
<tr>
<th>Room Id</th>
<th>Price</th>
<th>Capacity</th>
</tr>
<c:forEach var="row" items="${rooms.rows}">
<tr>
<c:url value="room.jsp" var="url">
<c:param name="hotel" value="${param.hotel}" />
<c:param name="area" value="${param.area}" />
<c:param name="room" value="${row.room_id}" />
</c:url>
<td><a href="${url}">#<c:out value="${row.room_id}"/></a></td>
<td><c:out value="${row.room_price_cents}"/></td>
<td><c:out value="${row.capacity}"/></td>
</tr>
</c:forEach>
</table>
<form action="room_add.jsp" method="post" autocomplete="off">
<input type="hidden" name="hotel" value="${fn:escapeXml(param.hotel)}"/>
<input type="hidden" name="area" value="${fn:escapeXml(param.area)}"/>
<table width="100%" border="1">
<tr><td>Hotel:</td><td><c:out value="${param.hotel}"/></td></tr>
<tr><td>Hotel Area:</td><td><c:out value="${param.area}"/></td></tr>
<tr><td><label for="room">Room Id:</label></td><td><input type="number" id="room" name="room"></td></tr>
<tr><td><label for="price">Price:</label></td><td><input type="number" id="price" name="price"> cents</td></tr>
<tr><td><label for="capacity">Capacity:</label></td><td><input type="number" id="capacity" name="capacity"></td></tr>
</table>
<button>Add</button>
</form>
<a href="hotels.jsp">Back to Hotels</a>
<%@ include file="../WEB-INF/footer.html" %>
