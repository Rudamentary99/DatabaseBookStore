<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.UserDao, model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
	<%!UserDao ud = new UserDao();%>
	<%!User u = new User();%>
	<%!boolean load = false;%>
	<%!String e;%>
	<%!String p;%>
	<%
		if (request.getParameter("email") != null || request.getParameter("password") != null) {
			e = request.getParameter("email");
			p = request.getParameter("password");
			u = ud.loginUser(e, p);
			if (u != null) {
				session.setAttribute("User", u);
			} else {
				out.print("fail");
			}
		}
	%>

	<form action="/SheeteMue/jsp/login.jsp" style="height: 64px;">
		<input type="text" placeholder="email" name="email"> <input
			type="text" placeholder="password" name="password">
		<button type="submit">Search</button>
	</form>

</body>
</html>