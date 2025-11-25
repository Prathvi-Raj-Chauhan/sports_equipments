<%@ page session="true" %>
<%
    session.invalidate();
    response.sendRedirect("teacherLogin.jsp");
%>

