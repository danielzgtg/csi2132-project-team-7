<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
    if (!"POST".equals(request.getMethod())) { throw new SecurityException(); }
    int sin = Integer.parseInt(request.getParameter("sin"));
    pageContext.setAttribute("sin", sin);
%>
<sql:setDataSource dataSource="jdbc/db" var="db"/>
<sql:query dataSource="${db}" var="auth">
    SELECT 1 FROM customer WHERE customer.ssn_or_sin = ?;
<sql:param value="${sin}"/>
</sql:query>
<%
    if (((org.apache.taglibs.standard.tag.common.sql.ResultImpl)
            pageContext.getAttribute("auth")).getRowCount() != 1) { throw new SecurityException(); }
    Cookie cookie = new Cookie("customer", String.valueOf(sin));
    cookie.setMaxAge(60*60*24*100);
    response.addCookie(cookie);
    response.sendRedirect("profile.jsp");
%>
