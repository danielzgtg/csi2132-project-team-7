<%
    if (!"POST".equals(request.getMethod())) throw new SecurityException();
    Cookie cookie = new Cookie("customer", "");
    cookie.setMaxAge(0);
    response.addCookie(cookie);
    response.sendRedirect("profile_login.jsp");
%>
