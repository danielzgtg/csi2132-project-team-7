<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../WEB-INF/header.html" %>
<form action="profile_add.jsp" method="post" autocomplete="off">
<table width="100%" border="1">
<tr><td><label for="sin">SSN or SIN:</label></td><td><input type="number" id="sin" name="sin"></td></tr>
<tr><td><label for="name">Full Name:</label></td><td><input type="text" id="name" name="name"></td></tr>
<tr><td><label for="address">Address:</label></td><td><input type="text" id="address" name="address"></td></tr>
</table>
<button>Register</button>
</form>
<nav>
<a href="profile_login.jsp">Back</a>
</nav>
<%@ include file="../WEB-INF/footer.html" %>
