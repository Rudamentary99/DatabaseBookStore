<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="model.User, model.Publisher, model.PublisherDao, java.util.List" %>
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
	List<Publisher> pubs;%>
	<h3>Genres:</h3>
	<%
		pubs = pd.loadAll();
		if (pubs != null && pubs.size() > 0) {
			for (Publisher p : pubs) {
				if (request.getParameter("action") != null && request.getParameter("action").equals("editPublisher")
						&& p.getPublisherID() == Integer.parseInt(request.getParameter("pubID"))) {
	%>
	<form action=<%=request.getContextPath() + "/AdminBook"%>
		method="post">
		<input type="hidden" name="action" value="updatePublisher">
		<input type="hidden" name="pubID" value=<%= p.getPublisherID() %>>
		<input type="text" name="name" value=<%="\"" + p.getName() + "\""%>required>
		<input type="text" name="email" value=<%="\"" + p.getEmail() + "\""%>required>
		<input type="text" name="phone" value=<%="\"" + p.getPhone() + "\""%>required>
		<button type=submit>Save</button>
	</form>
	<form action=<%=request.getContextPath() + "/jsp/AdminPublisher.jsp"%>
		method="post">
		<button type=submit>Discard</button>
	</form>
	<%
		} else {
	%>
	Name:<a><%=p.getName()%></a>  <br>
	email: <a><%= p.getEmail() %></a><br>
	phone: <a><%= p.getPhone() %></a><br>
	<form action=<%= request.getContextPath() + "/AdminServlet" %> method="post">
	<input type="hidden" name="action" value="viewPubAddresses">
	 <input type="hidden" name="pubID" value=<%="\"" + p.getPublisherID() + "\""%>>
		<button type=submit>View Addresses</button>
	</form>
		<form action=<%=request.getContextPath() + "/jsp/AdminPublisher.jsp"%>
		method="post">
		<input type="hidden" name="action" value="editPublisher"> <input
			type="hidden" name="pubID" value=<%="\"" + p.getPublisherID() + "\""%>>
		<button type=submit>edit</button>
	</form>
	<form action=<%=request.getContextPath() + "/AdminServlet"%>
		method="post">
		<input type="hidden" name="action" value="deleteGenre"> <input
			type="hidden" name="pubID" value=<%="\"" + p.getPublisherID() + "\""%>>
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
	<br>
	<br>
	
</body>
		</html>
	</header>
</body>
</html>
