<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.User, model.GenreDao, java.util.List"%>

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
			href="shop.html">Shop</a>
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


	<%!GenreDao gd = new GenreDao();;
	List<String> genres;%>
	<h3>Genres:</h3>
	<%
		genres = gd.loadAll();
		if (genres != null && genres.size() > 0) {
			for (String g : genres) {
				if (request.getParameter("action") != null && request.getParameter("action").equals("editGenre")
						&& g.equals(request.getParameter("genreName"))) {
	%>
	<form action=<%=request.getContextPath() + "/AdminBook"%>
		method="post">
		<input type="text" name="newGenreName" value=<%="\"" + g + "\""%>>
		<input type="hidden" name="action" value="updateGenre">
		<button type=submit>Save</button>
	</form>
	<form action=<%=request.getContextPath() + "/jsp/AdminGenre.jsp"%>
		method="post">
		<button type=submit>Discard</button>
	</form>
	<%
		} else {
	%>
	<a><%=g%></a>
	<form action=<%=request.getContextPath() + "/jsp/AdminGenre.jsp"%>
		method="post">
		<input type="hidden" name="action" value="editGenre"> <input
			type="hidden" name="genreName" value=<%="\"" + g + "\""%>>
		<button type=submit>Rename</button>
	</form>
	<form action=<%=request.getContextPath() + "/AdminBook"%>
		method="post">
		<input type="hidden" name="action" value="deleteGenre"> <input
			type="hidden" name="genreName" value=<%="\"" + g + "\""%>>
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
	<h3>Create New Genre:</h3>
	<form action=<%=request.getContextPath() + "/AdminBook"%>
		method="post">
		<input type="hidden" name="action" value="createGenre"> Genre
		Name: <input type="text" name="genreName" required>
		<button type="submit">Create Genre</button>
	</form>
</body>
		</html>
	</header>
</body>
</html>
