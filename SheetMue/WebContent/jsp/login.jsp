<%@page import="java.awt.event.WindowStateListener"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User, model.UserDao"%>

<!doctype html>

<html lang="en">

<head>
<meta charset="utf-8">

<title>Sheet μ | Login</title>

<link rel="stylesheet" href=<%= request.getContextPath() + "/css/style.css" %>>
<meta id="wixMobileViewport" name="viewport"
	content="width=980, user-scalable=yes" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>

	<h6>Sheet μ</h6>


	<div class="topnav">
		<a href="index.jsp">Home</a> <a href="shop.html">Shop</a> 
		<%!String mStyle;
	String mMessage;

	User u = new User();
	String style = "style=\"display:none\"";%>
		<%
			u = (User) session.getAttribute("User");
			if (u != null && u.getFirstName() != null) {
				style = "";
			}
		%>
		<a <%=style%> href="cart.jsp">Cart</a>
		<a
			href="../HTML/about.html">About</a> <a href="../HTML/contact.html">Contact</a>
		<div class="search-container">
			<form action="search.jsp">

				<a class="active"
					href="login.jsp">Login</a> <input type="text"
					placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>
<body>
	<br>
	<div style="padding-left: 16px">
		
		Don't have account? <a href=<%= request.getContextPath() + "/jsp/CreateUser.jsp" %>>Create Account</a>
		<% 
		mStyle = (String) request.getAttribute("style");
		mMessage = (String) request.getAttribute("message");
		if (mStyle == null) {
			mStyle = "";
			mMessage = "";
		}
		%>
		<h1 style=<%= "\"" + mStyle + "\"" %>><%= mMessage %></h1>
		<form method="post" action=<%= "\"" + request.getContextPath() + "/UserServlet" + "\"" %>>
			<input type="hidden" name="action" value="login"> Enter your
			email and password<br> <br> Email address: <input
				type="text" placeholder="johndoe@whatever.com" name="inputEmail"
				required><br> <br> Password: <input
				type="password" value="" placeholder="Shh" name="inputPassword"
				required><br> <br>
			<button type="submit">Submit</button>
		</form>


	</div>
</body>
</body>
</html>
