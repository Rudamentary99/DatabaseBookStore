<%@page import="java.awt.event.WindowStateListener"%>
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
		<a href="index.jsp">Home</a> <a href="shop.html">Shop</a> <a
			href="../HTML/about.html">About</a> <a href="contact.html">Contact</a>
		<%!User u = new User();%>
		<%!String style = "style=\"display:none\"";%>
		<%
			u = (User) session.getAttribute("User");
			if (u != null && u.getFirstName() != null) {
				style = "";
			}
		%>
		<a <%=style%> href="cart.jsp">Cart</a>
		<div class="search-container">
			<form action="search.jsp">

				<a href="../HTML/create.html">Create Account</a><a class="active"
					href="login.jsp">Login</a> <input type="text"
					placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>

	<br>
	<div style="padding-left: 16px">
		<%!String infoStyle;%>
		<%!String infoTxt;%>
		<%!String pastPage;%>
		<%
			cU = ((User) session.getAttribute("User"));

			if (cU.getFirstName() == null) {
				if (cU.getAttemptedLogin().equals("true")) {
					if (cU.getPassword() != null && cU.getEmail() != null) {

						nU = ud.loginUser(cU.getEmail(), cU.getPassword());
						if (nU != null) {
							session.setAttribute("User", nU);
							response.sendRedirect("login.jsp");

						} else {
							session.removeAttribute("User");
							infoStyle = "color:red";
							infoTxt = "wrong Username or Password";

						}
						//u = ud.loginUser(u.getEmail(), u.getPassword());
					} else {
						infoStyle = "color:red";
						infoTxt = "please fill all fields";
					}
				out.print("<h1 style=\"" + infoStyle + "\">" + infoTxt + "</h1>");
				}
			} else {
				infoTxt = "Enjoy Shopping, " + cU.getFirstName() + " " + cU.getLastName();
				infoStyle = "color:green";
			out.print("<h1 style=\"" + infoStyle + "\">" + infoTxt + "</h1>");
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
