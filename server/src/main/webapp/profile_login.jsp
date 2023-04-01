<%@ page import="java.lang.Integer,java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="WEB-INF/header.html" %>
<h1>Customer Login</h1>
<form action="profile_auth.jsp" method="post" autocomplete="off">
<table width="100%" border="1">
<tr><td><label for="sin">SSN or SIN:</label></td><td><input type="number" id="sin" name="sin"></td></tr>
</table>
<button>Log In</button>
</form>
<nav>
<a href="profile_register.jsp">Register</a>
<a href="index.jsp">Back</a>
</nav>
<%@ include file="WEB-INF/footer.html" %>
