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
			href="../HTML/about.html">About</a> <a href="contact.html">Contact</a>
		<div class="search-container">
			<form action="search.jsp">
				<%
					if (u != null && u.getFirstName() != null) {
				%><a href=<%= request.getContextPath() + "/jsp/user.jsp" %>><%= u.getFirstName() %></a> <%
				} else {
				%>
				<a class="active" href=<%= request.getContextPath() + "/jsp/login.jsp" %>>Login</a>
				<%}%>
				 <input type="text"
					placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>

<br>
<div style="padding-left:16px">
  Create an account<br><br>
  <form action=<%= request.getContextPath() + "/UserServlet" %> method="post"> 
  <input type="hidden" name="action" value="createUser">
  First Name:
  <input type="text" placeholder="John" name="firstname" required>
  <br><br>
  Last Name:
  <input type="text" placeholder="Doe" name="lastname" required><br><br>
  Email address: <input type="text" placeholder="johndoe@whatever.com" name="email" required><br><br>
  Phone Number (optional): <input type="text" placeholder="111-111-1111" name="phone"><br><br>
  Date of Birth: <input type="date" placeholder="4-1-19" name="DOB" required><br><br>
  Password: <input type="text" placeholder="Shh" name="password" required><br><br>
  Confirm Password: <input type="text" placeholder="Shh" name="confirmPassword" required><br><br>
  <button type="submit">Create Account</button>
  </form>
</div>

</body>
</html>
</header>
</body>
</html>
