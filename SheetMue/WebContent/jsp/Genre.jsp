<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="model.User, model.Book, java.util.List" %>
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
		<a href=<%= request.getContextPath() + "/jsp/index.jsp" %>>Home</a> 
		<a class="active" href=<%= request.getContextPath() + "/BookServlet?action=shopByCategory" %>>Shop</a> 
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
		<a <%=style%> href=<%= request.getContextPath() + "/CartServlet?action=viewCart" %>>Cart</a>
		<a
			href="../HTML/about.html">About</a> <a href="contact.html">Contact</a>
		<div class="search-container">
			<form action=<%= request.getContextPath() + "/BookServlet" %> method="post">
				<input type="hidden" name="action" value="searchBooks">
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

<%!
	List<Book> genreBooks;
	String genre;
	int i = 0;
%>
<%
	
	genre = (String) request.getAttribute("genreToView");
	genreBooks = (List<Book>) session.getAttribute(genre);
%>

	<div style="padding-left: 16px">
		<h3><%= genre %></h3>
		<%
		
			for (Book b: genreBooks) {
				%>
				<form action=<%=request.getContextPath() + "/jsp/item.jsp"%>>
		<input type="hidden" name="genre" value=<%= genre%>>
		 <input type="hidden" name="index" value=<%=i++%>>
			<button type="submit">
			<img
				src=<%=request.getContextPath() + "/img/" + Integer.toString(b.getBookID()) + ".png"%>
				style="width: 300px; height: 400px;">

			<%=b.getTitle() + "   " + b.getCurrentPrice()%>
		</button>
		

	</form>
	<br> 
				<%
			}
		
		
		%>
	</div>

</body>
		</html>
	</header>
</body>
</html>
