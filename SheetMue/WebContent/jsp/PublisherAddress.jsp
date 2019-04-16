<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="model.User, model.Publisher, model.Address, model.PublisherDao, java.util.List" %>

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
		<a class="active" href=<%= request.getContextPath() + "/jsp/index.jsp" %>>Home</a> <a href="shop.html">Shop</a> 
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
			<form action=<%= request.getContextPath() + "/jsp/search.jsp" %>>
			
				<%
					if (u != null && u.getFirstName() != null) {
						if(u.isAdmin()) {
							
						
				%>
				<a href=<%= request.getContextPath() + "/jsp/Admin.jsp" %>>Admin</a> <%
				} %>
				<a href=<%= request.getContextPath() + "/jsp/user.jsp" %>><%= u.getFirstName() %></a> <%
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


	<h3>
	
	
	
	
	<%!PublisherDao pd = new PublisherDao();;
	List<Address> pubAddresses;%>
	<h3>Genres:</h3>
	<%
	pubAddresses = pd.loadPublisherAddresses(Integer.parseInt(request.getParameter("id")));
		if (pubAddresses != null && pubAddresses.size() > 0) {
			for (Address a : pubAddresses) {
				if (request.getParameter("action") != null && request.getParameter("action").equals("editAddress")
						&& a.getAddressID() == Integer.parseInt(request.getParameter("AddressId"))) {
	%>
	<form action=<%=request.getContextPath() + "/AdminServlet"%>
		method="post">
		<input type="hidden" name="action" value="updateAddress">
		<input type="hidden" name="id" value=<%= request.getParameter("id") %>>
		<input type="hidden" name="addressId" value=<%= a.getAddressID() %>>
		<input type="text" name="street" value=<%="\"" + a.getStreet() + "\""%>required>
		<input type="text" name="city" value=<%="\"" + a.getCity() + "\""%>required>
		<input type="text" name="state" value=<%="\"" + a.getState() + "\""%>required>
		<input type="text" name="zip" value=<%="\"" + a.getZip() + "\""%>required>
		
		<button type=submit>Save</button>
	</form>
	<form action=<%=request.getContextPath() + "/jsp/PublisherAddress.jsp"%>
		method="post">
		<input type="hidden" name="id" value=<%= request.getParameter("id") %>>
		<button type=submit>Discard</button>
	</form>
	<%
		} else {
	%>
	Street:<a><%=a.getStreet()%></a>  <br>
	City: <a><%=a.getCity() %></a><br>
	State: <a><%= a.getState() %></a><br>
	Zip: <a><%= a.getZip() %></a><br>
	
		<form action=<%=request.getContextPath() + "/jsp/PublisherAddress.jsp"%>
		method="post">
		<input type="hidden" name="action" value="editAddress"> 
		<input type="hidden" name="id" value=<%= request.getParameter("id") %>><input
			type="hidden" name="addressId" value=<%="\"" + a.getAddressID() + "\""%>>
		<button type=submit>edit</button>
	</form>
	<form action=<%=request.getContextPath() + "/AdminServlet"%>
		method="post">
		<input type="hidden" name="action" value="deletePubAddress"> <input
			type="hidden" name="addressId" value=<%="\"" + a.getAddressID() + "\""%>>
		<button type=submit>Remove</button>
	</form>


	<%
		}
			}
		} else {
	%>

	<h4>No Data</h4>

	<%
		}
	%>
	<form action=<%= request.getContextPath() + "/jsp/AdminPublisher.jsp" %> method="post">
		<button type=submit>Return to Publishers</button>
	</form>
	<br>
	<br>
	<h3>Add Address:</h3>
	<form action=<%=request.getContextPath() + "/AdminServlet"%>
		method="post">
		<input type="hidden" name="action" value="createPubAddress">
		<input type="hidden" name="id">
		<input type="text" name="street" required>
		<input type="text" name="city" required>
		<input type="text" name="state" required>
		<input type="text" name="zip" required>
		
		<button type=submit>Save</button>
	</form>
</body>
		</html>
	</header>
</body>
</html>
