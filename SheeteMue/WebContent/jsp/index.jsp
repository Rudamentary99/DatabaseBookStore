<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="model.User" %>
<!doctype html>

<html lang="en">
<head>
<meta charset="utf-8">

<title>Sheet μ | Home</title>

<link rel="stylesheet" href= <%= "\"" + request.getContextPath() + "/css/style.css\"" %>>
<meta id="wixMobileViewport" name="viewport"
	content="width=980, user-scalable=yes" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
	<header>
		<h6>Sheet μ</h6>
		<html>
<body>

	

	<div class="topnav">
		<a class="active" href="index.jsp">Home</a> <a href="shop.html">Shop</a> <a
			href="../HTML/about.html">About</a> <a href="contact.html">Contact</a>
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
		<div class="search-container">
			<form action="search.jsp">
				<%
					if (u != null && u.getFirstName() != null) {
				%><a href=<%= request.getContextPath() + "/jsp/user.jsp" %>><%= u.getFirstName() %></a> <%
				} else {
				%>
				<a href=<%= request.getContextPath() + "/jsp/login.jsp" %>>Login</a>
				<%}%>
				 <input type="text"
					placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>



	<div style="padding-left: 16px">
		<h2>Welcome to Sheet μ</h2>
		<h3>The Sheet Music Store for the Modern Age</h3>
		<p>All of our sheet music is provided by your favorite artists,
			including independent artists.</p>
		<p>Browse around and see if you find something you like!</p>
	</div>

</body>
		</html>
	</header>
</body>
</html>
