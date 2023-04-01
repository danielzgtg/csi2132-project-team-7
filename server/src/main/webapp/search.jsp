<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.lang.Integer,java.lang.String" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<%
    SimpleDateFormat parser= new SimpleDateFormat("yyyy-MM-dd");
    String sText = request.getParameter("start");
    Date sDate = parser.parse(sText.length() == 0 ? "3000-01-01" : sText);
    String eText = request.getParameter("end");
    Date eDate = parser.parse(eText.length() == 0 ? "2000-01-01" : eText);
%>
<sql:query dataSource="${db}" var="result">
    SELECT room.room_id, room.address_of_hotel, room.area_of_hotel, hotel.address_central_office FROM room 
   INNER JOIN hotel on hotel.address_of_hotel = room.address_of_hotel and hotel.area_of_hotel = room.area_of_hotel
   WHERE NOT EXISTS (
    SELECT 1 FROM booking_or_renting
    WHERE booking_or_renting.start_date <= ?
    AND booking_or_renting.end_date >= ?
    AND booking_or_renting.address_of_hotel = room.address_of_hotel
    AND booking_or_renting.area_of_hotel = room.area_of_hotel
    AND booking_or_renting.room_id = room.room_id
    )
    AND room.capacity >= ?
    AND hotel.area_of_hotel LIKE CONCAT('%', ?, '%')
    AND hotel.address_central_office LIKE CONCAT('%', ?, '%')
    AND room.room_price_cents <= ?
    ;
<sql:dateParam value="<%= sDate %>"/>
<sql:dateParam value="<%= eDate %>"/>
<sql:param value="${Integer.parseInt(param.capacity.length() == 0 ? 0 : Integer.parseInt(param.capacity))}"/>
<sql:param value="${String.valueOf(param.area)}"/>
<sql:param value="${String.valueOf(param.chain)}"/>
<sql:param value="${param.price.length() == 0 ? Integer.MAX_VALUE : Integer.parseInt(param.price)}"/>
</sql:query>
<%@ include file="WEB-INF/header.html" %>
<form action="search.jsp">
<label>Start Date: <input type="date" name="start" value="${param.start}"></label>
<label>End Date: <input type="date" name="end" value="${param.end}"></label>
<label>Capacity: <select name="capacity">
<option value="0" ${param.capacity.equals("0") ? "selected" : ""}>Any</option>
<option value="1" ${param.capacity.equals("1") ? "selected" : ""}>Single</option>
<option value="2" ${param.capacity.equals("2") ? "selected" : ""}>Double</option>
<option value="3" ${param.capacity.equals("3") ? "selected" : ""}>Triple</option>
<option value="4" ${param.capacity.equals("4") ? "selected" : ""}>Quadruple</option>
<option value="5" ${param.capacity.equals("5") ? "selected" : ""}>Suite</option>
</select></label>
<label>Area: <input type="text" name="area" value="${param.area}"></label>
<label>Chain: <input type="text" name="chain" value="${param.chain}"></label>
<label>Total Rooms: <input type="number" name="rooms" value="${param.rooms}"></label>
<label>Price: <input type="number" name="price" value="${param.price}"></label>
<button>Submit</button>
</form>
<table width="100%" border="1">
<tr>
<th>Room Id</th>
<th>Hotel</th>
<th>Hotel Area</th>
<th>Chain</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
<c:url value="room.jsp" var="url">
<c:param name="room" value="${row.room_id}" />
<c:param name="hotel" value="${row.address_of_hotel}" />
<c:param name="area" value="${row.area_of_hotel}" />
<c:param name="chani" value="${row.address_central_office}" />
</c:url>
<td><a href="${url}">#<c:out value="${row.room_id}"/></a></td>
<td><c:out value="${row.address_of_hotel}"/></td>
<td><c:out value="${row.area_of_hotel}"/></td>
<td><c:out value="${row.address_central_office}"/></td>
</tr>
</c:forEach>
</table>
<%@ include file="WEB-INF/footer.html" %>
