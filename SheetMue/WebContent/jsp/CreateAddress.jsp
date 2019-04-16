<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.User, model.UserDao, model.AddressDao"%>
<!doctype html>

<html lang="en">
<head>
<meta charset="utf-8">

<title>Sheet μ | User Settings</title>

<link rel="stylesheet"
	href=<%= "\"" + request.getContextPath() + "/css/style.css\"" %>>
<meta id="wixMobileViewport" name="viewport"
	content="width=980, user-scalable=yes" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
	<header>
		<h6>Sheet μ</h6>



		<br><div class="topnav">
		<a  href="index.jsp">Home</a> <a href="shop.html">Shop</a> <a
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
				%><a class="active" href=<%= request.getContextPath() + "/jsp/user.jsp" %>><%= u.getFirstName() %></a> <%
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
	</div><br>
		
		<form action="../AddressServlet" method="post">
			<input type="hidden" name="action" value="createShippingAddress" >
			Street: <input type="text" name="street" placeholder="street" required><br>
			City: <input type="text" name="city" placeholder="Big Cabin, PointLookout, etc.." required><br>
			State: <input type="text" name="state" placeholder="NY, OK, etc..." required><br>
			Zip-code: <input type="text" name="zip" placeholder="zip" required><br>
			<button type="submit">Save Address</button>
		</form>
			<form action="ShippingAddress.jsp" method="post">
			<button type="submit">Cancel</button><br><br> 
			</form>

</body>
</html>