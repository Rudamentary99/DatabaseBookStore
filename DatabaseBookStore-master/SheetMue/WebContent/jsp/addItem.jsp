<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="model.Publisher, model.PublisherDao, model.Book, model.BookDao, model.GenreDao, java.util.ArrayList"%>
<!DOCTYPE html>


<html lang="en">
<head>
<meta charset="utf-8">

<title>Sheet μ | Administrator Settings</title>

<link rel="stylesheet" href=<%= request.getContextPath() + "/css/style.css" %>>
<meta id="wixMobileViewport" name="viewport"
	content="width=980, user-scalable=yes" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>

	<h6>Sheet μ</h6>
<body>
	<%!
	GenreDao gd = new GenreDao();
	PublisherDao pd = new PublisherDao();
	BookDao bd = new BookDao();
	Book b = new Book();
	String select = "";
	String vId = "";
	String vTitle = "";
	String vAuthorName = "";
	String vPubDate = "";
	String vDescription = "";
	String vEdition = "";
	String vCurrentPrice = "";
	String vStockAmount = "";
	String val = "value=";
	String action = "createBook";
	boolean selectGenres= false;
	%>
	<div class="topnav">
		<a href="index.html">Home</a> <a href="shop.html">Shop</a> <a
			href="cart.html">Cart</a> <a href="about.html">About</a> <a
			href="contact.html">Contact</a>

		<div class="search-container">
			<form action="/action_page.php">
				<a class="active" href="create.html">Create Account</a><a
					href="user.html">User Settings</a><a href="login.html">Login</a> <input
					type="text" placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>
	<br>
	<%
		b = (Book) request.getAttribute("EditItem");
		if (b != null && b.getTitle() != null) {
			action = "saveEdit";
			vId = val + b.getBookID();
			vTitle = val + b.getTitle();
			vAuthorName = val + "\"" + b.getAuthorName() + "\"";
			vDescription = val + "\"" + b.getDescription() + "\"";
			vEdition = val + "\"" + b.getEdition() + "\"";
			vPubDate = val + "\"" + b.getPubDate().toString() + "\"";
			vCurrentPrice = val + "\"" + b.getCurrentPrice() + "\"";
			vStockAmount = val + "\"" + b.getAmountInStock() + "\"";
			selectGenres = true;
		
		}
	%>


	<div style="padding-left: 16px">
		Create a Book<br> <br>
		<form action="../CreateBook" method="post">

			<input type="hidden" name="action" value=<%=action%>> <input
				type="hidden" name="id" value=<%=vId%>>
				 Publisher:
			<select name="publisherID">
				<%
					for (Publisher p : pd.loadAll()) {
						select = "";
						if (selectGenres && p.getPublisherID() == b.getPublisherID()) {
							select = "selected";
						}
				%>
				<option value=<%="\"" + p.getPublisherID() + "\" " + select%>><%=p.getName()%></option>
				<%
					}
				%>
			</select> <br> <br> Title: <input type="text" placeholder="Title"
				name="title" id="title" <%=vTitle%> required><br> <br>
			Author Name: <input type="text" placeholder="Author"
				name="authorName" id="authorName" <%=vAuthorName%> required><br>
			<br> Edition: <input type="number" step="1"
				placeholder="Edition" name="edition" id="edition" <%=vEdition%>
				min="0" required><br> <br> Publish Date: <input
				type="date" name="pubDate" id="pubDate" <%=vPubDate%> required><br>
			<br> Description: <input type="text" placeholder="Description"
				name="description" id="description" <%=vDescription%> required><br>
			<br> Genres (ctrl for multiple): <select name="Genres" multiple>
				<%
						
					for (String genre : gd.loadAll()){
						select="";
						if (selectGenres && b.getGenres().contains(genre)) {
							select="selected";
						}
						%>
						<option value=<%= "\"" + genre + "\" " + select %>><%= genre %></option>
						<% 
						}
				
				%>
				
			</select><a href=<%= request.getContextPath() + "/jsp/CreateGenre" %>>create genre</a><br>  <br> Price: <input type="number" step=".01"
				placeholder="Price" name="currentPrice" id="currentPrice"
				<%=vCurrentPrice%> required><br> <br> Amount in
			Stock: <input type="number" step="1" placeholder="Stock"
				name="amountInStock" id="amountInStock" <%=vStockAmount%> required><br>
			<button type="submit">Submit</button>

			<br>
		</form>
	</div>

</body>

</body>
</html>
