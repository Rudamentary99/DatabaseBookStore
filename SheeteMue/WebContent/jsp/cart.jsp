<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.User, model.Book, model.BookDao"%>
<!doctype html>

<html lang="en">
<head>
<meta charset="utf-8">

<title>Sheet μ | Cart</title>

<link rel="stylesheet" href="../css/style.css">
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
		<a href="index.html">Home</a> <a href="shop.html">Shop</a>
		
		<a class="active" href="cart.jsp">Cart</a> <a
			href="../HTML/about.html">About</a> <a href="contact.html">Contact</a>

		<div class="search-container">
			<form action="search.jsp">
				<a href="../HTML/create.html">Create Account</a><a href="login.jsp">Login</a>
				<input type="text" placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>

	<br>
	<div style="padding-left: 16px">
		<dl>
			<input type="checkbox" value="Item 1">Item 1
		</dl>
		<dt>Item description here</dt>
		<br>
		<br>
		<dl>
			<input type="checkbox" value="Item 2">Item 2
		</dl>
		<dt>Item description here</dt>
		<br>
		<br>
		<button type="submit">Purchase Items</button>
		<br>
		<br>
		<button type="submit">Remove</button>
	</div>

</body>
		</html>
	</header>
</body>
</html>
