<%-- 
    Document   : logout
    Created on : Feb 28, 2018, 9:16:19 AM
    Author     : user
--%>

<%
session.setAttribute("userid", null);
session.invalidate();
response.sendRedirect("index.jsp");
%>
