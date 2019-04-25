<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="model.User, model.UserDao, model.Address, java.util.ArrayList"%>
<!doctype html>

<html lang="en">
<head>
<meta charset="utf-8">

<title>Sheet μ | Home</title>

<link rel="stylesheet"
	href=<%="\"" + request.getContextPath() + "/css/style.css\""%>>
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
		<a class="active"
			href=<%=request.getContextPath() + "/jsp/index.jsp"%>>Home</a> <a
			href=<%=request.getContextPath() + "/BookServlet?action=shopByCategory"%>>Shop</a>
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
		<a <%=style%>
			href=<%=request.getContextPath() + "/CartServlet?action=viewCart"%>>Cart</a>
		<a href="../HTML/about.html">About</a> <a href="contact.html">Contact</a>
		<div class="search-container">
			<form action=<%=request.getContextPath() + "/BookServlet"%>
				method="post">
				<input type="hidden" name="action" value="searchBooks">
				<%
					if (u != null && u.getFirstName() != null) {
						if (u.isAdmin()) {
				%>
				<a href=<%=request.getContextPath() + "/jsp/Admin.jsp"%>>Admin</a>
				<%
					}
				%>
				<a href=<%=request.getContextPath() + "/jsp/user.jsp"%>><%=u.getFirstName()%></a>
				<%
					} else {
				%>
				<a href=<%=request.getContextPath() + "/jsp/login.jsp"%>>Login</a>
				<%
					}
				%>
				<input type="text" placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>
	<%!ArrayList<Address> as;%>
	<h3>Please select the following</h3>

	<form action=<%=request.getContextPath() + "/UserServlet"%>
		method="post">
		<input type="hidden" name="action" value="createInvoice">
		<h4>ShippingAddress: </h4>
		<%
			as = (ArrayList<Address>) request.getAttribute("userAddresses");
			if (as != null) {
				if (as.size() > 0) {
					for (Address a : as) {
		%>
		<input type="radio" name="shippingAddress" value=<%=a.getAddressID()%>>
		<a>Street:<%=" " + a.getStreet()%></a><br> <a>City: <%=" " + a.getCity()%></a><br>
		<a>State: <%=" " + a.getState()%></a><br> <a>Zip: <%=" " + a.getZip()%></a>
		<br> <br>
		<%
			}
				} else {%>
					<a>You have no addresses saved. Please add an address before checking out.</a><br>
		<%		}
			}
		%>
					<a href=<%= request.getContextPath() + "/AddressServlet?action=shippingAddressView"%>>Add Shipping Address</a>

	<h4>Payment Method:</h4>
		<%
		
		
		%>
		
	</form>

</body>
		</html>