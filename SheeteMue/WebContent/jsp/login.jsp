<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User, model.UserDao"%>
<jsp:useBean id="User" class="model.User" scope="session" />
<jsp:setProperty property="email" name="User" param="inputEmail" />
<jsp:setProperty property="password" name="User" param="inputPassword" />
<jsp:setProperty property="attemptedLogin" name="User"
	param="attemptedLogin" />
<!doctype html>

<html lang="en">
<%!UserDao ud = new UserDao();%>
<%!User cU = new User();%>
<%!User nU = new User();%>
<head>
<meta charset="utf-8">

<title>Sheet μ | Login</title>

<link rel="stylesheet" href="../css/style.css">
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
		<a href="index.html">Home</a> <a href="shop.html">Shop</a> <a
			href="cart.html">Cart</a> <a href="about.html">About</a> <a
			href="contact.html">Contact</a>

		<div class="search-container">
			<form action="search.jsp">
				<a href="create.html">Create Account</a><a class="active"
					href="login.html">Login</a> <input type="text"
					placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>
	<br>
	<div style="padding-left: 16px">
		<%
			cU = ((User) session.getAttribute("User"));
			if (cU.getAttemptedLogin().equals("true")) {
				if (cU.getPassword() != null && cU.getEmail() != null) {
					if (!cU.getPassword().equals("") && !cU.getEmail().equals(""))
						nU = ud.loginUser(cU.getEmail(), cU.getPassword());
					if (nU != null) {
						session.setAttribute("User", nU);
						out.print("<h1 style=\"color:green\">enjoy shopping " + nU.getFirstName() + " " + nU.getLastName() +"</h1>");
						
					} else {
						session.removeAttribute("User");
						out.print("<a style=\"color:red\">wrong Username or Password</a>");
						
					}
					//u = ud.loginUser(u.getEmail(), u.getPassword());
				} else {
					out.print(((User) session.getAttribute("User")).toString());
					out.print("<a style=\"color:red\">please fill all fields</a>");
				}
			}
		%>


		<form method="post" action="login.jsp">
			<input type="hidden" name="attemptedLogin" value="true">
			Enter your email and password<br> <br> Email address: <input
				type="text" placeholder="johndoe@whatever.com" name="inputEmail"><br>
			<br> Password: <input type="password" value="" placeholder="Shh"
				name="inputPassword"><br> <br>
			<button type="submit">Submit</button>
		</form>

	</div>
</body>
		</html>
	</header>
</body>
</html>
