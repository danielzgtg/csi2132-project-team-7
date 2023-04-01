<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:query dataSource="${db}" var="result">
    SELECT * from hotel;
</sql:query>
<%@ include file="WEB-INF/header.html" %>
<table border = "1" width = "100%">
    <tr>
        <th>Emp ID</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Age</th>
    </tr>
    <c:forEach var = "row" items = "${result.rows}">
        <tr>
            <td> <c:out value = "${row.address_of_hotel}"/></td>
            <td> <c:out value = "${row.area_of_hotel}"/></td>
            <td> <c:out value = "${row.address_central_office}"/></td>
            <td> <c:out value = "${row.ranking}"/></td>
        </tr>
    </c:forEach>
</table>
<%@ include file="WEB-INF/footer.html" %>