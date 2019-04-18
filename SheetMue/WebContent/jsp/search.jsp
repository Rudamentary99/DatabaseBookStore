<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="model.User, model.BookDao, model.SearchBook,java.util.ArrayList" %>
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
				%><a href=<%= request.getContextPath() + "/jsp/user.jsp" %>><%= u.getFirstName() %></a> <%
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
<%! ArrayList<SearchBook> searchBooks;

BookDao bd = new BookDao();%>

	<%
		searchBooks = bd.Search(request.getParameter("search"));
		if (searchBooks != null) {


			for (SearchBook b : searchBooks) {
	%>


	<form action=<%= request.getContextPath() + "/jsp/item.jsp" %> method="post">
		<input type="hidden" value="action" value="viewItem"> <input
			type="hidden" name="id" value=<%="\"" + b.getBookID() + "\""%>> <input
			type="hidden" name="title" value=<%="\"" + b.getTitle() + "\""%>> <input
			type="hidden" name="description" value=<%="\"" + b.getDescription() + "\""%>> <input
			type="hidden" name="price" value=<%="\"" + b.getCurrentPrice() + "\""%>> <input
			type="hidden" name="stockAmount" value=<%="\"" + b.getAmountInStock() + "\""%>>
		<button type="submit"><%=b.getTitle() + "   " + b.getCurrentPrice()%></button>

	</form>
	<br>

	<%
		}
		}
	%>
	<%!public String makeParameter(final String x) {
		final char SPACE = ' ';
		String rString = "";
		if (x.charAt(0) != SPACE) {
			rString += Character.toString(x.charAt(0));
		}
		for (int i = 1; i < x.length(); i++) {
			if (x.charAt(i) != SPACE) {
				rString += Character.toString(x.charAt(i));
			} else {
				rString += "+";
			}

		}

		return rString;

	}%>

</body>
</html>