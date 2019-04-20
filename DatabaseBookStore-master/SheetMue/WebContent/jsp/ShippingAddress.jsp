<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="model.User, model.UserDao, model.Address, model.AddressDao, java.util.ArrayList"%>
<!doctype html>

<html lang="en">
<head>
<meta charset="utf-8">

<title>Sheet μ | User Settings</title>

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



		<div class="topnav">
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
	</div>

		<br>
		<%
		if (request.getAttribute("message") != null) {
			out.print((String) request.getAttribute("message"));
		}
		
		%>
		<div style="padding-left: 16px">
			<%!ArrayList<Address> as;%>

			Shipping Addresses:<br> <br>
			<%
				as = (ArrayList<Address>) request.getAttribute("userAddresses");
				if (as != null) {
					if (as.size() > 0) {
					for (Address a : as) {
			%>
					<div class="addressList">
					<a>Street:<%= " " + a.getStreet() %></a><br>
					<a>City: <%= " " + a.getCity() %></a><br>
					<a>State: <%= " " + a.getState() %></a><br>
					<a>Zip: <%= " " + a.getZip() %></a><br>
					<form action="../UserServlet" method="post">
					<input type="hidden" name="action" value="removeAddress">
					<input type="hidden" name="addressID" value=<%= a.getAddressID() %>>
					<button type="submit">Remove</button>
					</form>
					</div> <br><br>
			<%						
					}
				} else {
					out.print("<a>You have no addresses saved</a><br><br>");		
				}
				}
			%>
			
				<form action=<%="\"" + request.getContextPath() + "/jsp/CreateAddress.jsp\""%>>
					<button type="submit">Add Address</button>
				
				</form>


		</div>

	</header>
</body>
</html>
