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
			class="active" href="shop.html">Shop</a>
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
	Book b;
	BookDao bd = new BookDao();%>
	<%
		genres = bd.loadAllGenres();
		if (genres != null) {
			for (String genre : genres) {
				books = bd.loadBooksByGenre(genre);
				if (books != null) {
	%>
	<h3><%=genre%></h3> <font action=<%=request.getContextPath() + "/BookServlet" %> method="post">
	<input type="hidden" name="action" value="shopByCategory">
	<input type="hidden" name="genre" value=<%= "\"" + genre + "\"" %>>
	<button type="submit">View More</button>
	</font>
	<%
		for (int i =0; i<3; i++) {
			b = books.get(i);	
	%>

	<form action=<%= request.getContextPath() + "/jsp/item.jsp" %> method="post">
		<input type="hidden" value="action" value="viewItem"> <input
			type="hidden" name="id" value=<%="\"" + b.getBookID() + "\""%>>
		<input type="hidden" name="title"
			value=<%="\"" + b.getTitle() + "\""%>> <input type="hidden"
			name="description" value=<%="\"" + b.getDescription() + "\""%>>
		<input type="hidden" name="price"
			value=<%="\"" + b.getCurrentPrice() + "\""%>> <input
			type="hidden" name="stockAmount"
			value=<%="\"" + b.getAmountInStock() + "\""%>>
		<button type="submit"><%=b.getTitle() + "   " + b.getCurrentPrice()%></button>

	</form>
	<br> <br>


	<%
		}
				}
	%>




	<br>
	<br>
	<%
		}
		}
	%>

</body>
		</html>
	</header>
</body>
</html>
