<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.User, model.Book, model.BookDao, java.util.List"%>
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
		<a href=<%=request.getContextPath() + "/jsp/index.jsp"%>>Home</a> <a
			class="active" href="shop.jsp">Shop</a>
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
		<a <%=style%> href="cart.jsp">Cart</a> <a href="../HTML/about.html">About</a>
		<a href="contact.html">Contact</a>
		<div class="search-container">
			<form action=<%=request.getContextPath() + "/jsp/search.jsp"%>>
				<%
					if (u != null && u.getFirstName() != null) {
				%><a href=<%=request.getContextPath() + "/jsp/user.jsp"%>><%=u.getFirstName()%></a>
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
	<br>
	<%!List<String> genres;
	List<Book> books;
		List<List<Book>> booksByGenre;
	Book b;
	int n; 
	int i;%>
	<%
		n=0;
		i=0;
		genres = (List<String>) session.getAttribute("Genres");
		booksByGenre = (List<List<Book>>) session.getAttribute("BooksByGenre");
	
		if (booksByGenre != null) {
			for (List<Book> genreBooks : booksByGenre) {
				 %>
				 <h3><%= genres.get(i) %></h3> <a href=<%= request.getContextPath() +
				 "/BookServlet?action=viewAllGenre&i=" + i + "&genre=" +genres.get(i++) %>>View All</a>
				 <%
				 n = 0; 
				for (Book b : genreBooks) {
					
	%>
	<form action=<%=request.getContextPath() + "/jsp/item.jsp"%>
		method="post">
		<input type="hidden" value="action" value="viewItemShop"> <input
			type="hidden" name="index" value=<%=n++%>>
			<input
			type="hidden" name="i" value=<%=i - 1%>>
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
				 out.print("<br>");
		}
				}
	%>






</body>
		</html>
	</header>
</body>
</html>
