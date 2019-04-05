<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="model.User, model.Book, model.BookDao"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1" />
<meta charset="utf-8" />

<title>Sheet μ | <%=request.getParameter("title")%></title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<meta property="og:title" content="I'm a Product" />
<meta property="og:type" content="product" />
<meta property="og:url"
	content="//noahrejda.wixsite.com/mysite/product-page/i-m-a-product-9" />
<meta property="og:site_name" content="mysite" />
<meta property="og:description"
	content="I'm a product description. I'm a great place to add more details about your product such as sizing, material, care instructions and cleaning instructions." />

<meta id="wixMobileViewport" name="viewport"
	content="width=980, user-scalable=yes" />
<link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
	<%!BookDao bd = new BookDao();%>
	<%!User u = new User();%>
	<%!Book b = new Book();%>
	<header>
		<h6>Sheet μ</h6>
		<div class="topnav">
		<a href="index.jsp">Home</a> <a href="shop.html">Shop</a> <a
			href="../HTML/about.html">About</a> <a href="contact.html">Contact</a>
		<%!User u = new User();%>
		<%!String style = "style=\"display:none\"";%>
		<%
			u = (User) session.getAttribute("User");
			if (u != null && u.getFirstName() != null) {
				style = "";
			}
		%>
		<a <%=style%> href="cart.jsp">Cart</a>
		<div class="search-container">
			<form action="search.jsp">

				<a href="../HTML/create.html">Create Account</a><a class="active"
					href="login.jsp">Login</a> <input type="text"
					placeholder="Search.." name="search">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
	</div>


	</header>
	<br>
	<section class="page" id="fz7md">
		<span id="comp-j7ekj3y3"> <!-- placeholder for component of data type=VectorImage -->
		</span>
		<div id="comp-j7al14wy1" type="TPA-Part" class="anon$2"></div>
		<div id="TPAMultiSection_j7al14wm" type="TPA-Part" class="anon$1">
			<main class="ecom-style-container">
			<ul itemscope itemtype="http://schema.org/BreadcrumbList"
				class="ecom-style-breadcrumbs">
				<li itemprop="itemListElement" itemscope
					itemtype="http://schema.org/ListItem"><a itemprop="item"
					href="//noahrejda.wixsite.com/mysite"> <span itemprop="name">Home</span>
				</a>
					<meta itemprop="position" content="1"></li>
				<li itemprop="itemListElement" itemscope
					itemtype="http://schema.org/ListItem"><a itemprop="item"
					href="//noahrejda.wixsite.com/mysite/product-page/i-m-a-product-9">
						<span itemprop="name"><%=request.getParameter("title")%></span>
				</a>
					<meta itemprop="position" content="2"></li>
			</ul>
			<section id="e9f36bee-5450-165e-06d5-a6df21c29715" itemscope
				itemtype="http://schema.org/Product"
				class="ecom-style-product-section">
				<div class="ecom-style-product-info">
					<h1 itemprop="name" class="ecom-style-product-name"><%=request.getParameter("title")%></h1>
					<div class="ecom-style-sku">
						SKU: <span itemprop="sku">0001</span>
					</div>
					<div id="price" class="ecom-style-price" itemprop="offers"
						itemtype="http://schema.org/Offer" itemscope>
						<span itemprop="priceCurrency" content="USD">$</span> <span
							itemprop="price" content="25.00"><%=request.getParameter("price")%></span>
						<link itemprop="availability" href="http://schema.org/InStock">
					</div>
					<img src="../img/img.png" style="width: 300px; height: 400px;">
					<ul id="faq" class="ecom-style-info-sections">
						<li class="ecom-style-info-section-item">
							<h3 class="ecom-style-info-section-item-title">PRODUCT INFO</h3>
							<p></p>
							<p>I'm a product detail. I'm a great place to add more
								information about your product such as sizing, material, care
								and cleaning instructions. This is also a great space to write
								what makes this product special and how your customers can
								benefit from this item.</p>
							<p></p>
						</li>
						<li class="ecom-style-info-section-item">
							<h3 class="ecom-style-info-section-item-title">RETURN &amp;
								REFUND POLICY</h3>
							<p></p>
							<p>I’m a Return and Refund policy. I’m a great place to let
								your customers know what to do in case they are dissatisfied
								with their purchase. Having a straightforward refund or exchange
								policy is a great way to build trust and reassure your customers
								that they can buy with confidence.</p>
							<p></p>
						</li>
						<li class="ecom-style-info-section-item">
							<h3 class="ecom-style-info-section-item-title">SHIPPING INFO</h3>
							<p></p>
							<p>I'm a shipping policy. I'm a great place to add more
								information about your shipping methods, packaging and cost.
								Providing straightforward information about your shipping policy
								is a great way to build trust and reassure your customers that
								they can buy from you with confidence.</p>
							<p></p>
						</li>
					</ul>
				</div>
				<div class="ecom-style-product-gallery">
					<p itemprop="description" class="ecom-style-product-description"></p>
					<p><%=request.getParameter("description")%></p>
					<p></p>

					<%
						if (request.getParameter("addToCart") != null) {
							if (session.getAttribute("User") != null) {
								u = (User) session.getAttribute("User");

								if (bd.addToCart(u.getUserID(), Integer.parseInt(request.getParameter("id")))) {
									out.print("Item has been added");
								} else {
									out.print("Item is already in you cart");
								}

							} else {
								out.print(
										"<h1 style=\"color:red\">To Add Item to Cart, You Must be Logged in</h1> <br> <a href=\"login.jsp\">You may log in here</a>");
							}

						}
					%>

					<div class="item-container">
						<form method="post"
							action=<%="/SheeteMue/jsp/item.jsp?id=" + request.getParameter("id") + "&title="
					+ makeParameter(request.getParameter("title")) + "&description="
					+ makeParameter(request.getParameter("description")) + "&price="
					+ makeParameter(request.getParameter("price"))%>>
							 <input name="addToCart" type="hidden"
								value="true">
							<button type="submit">Add To Cart</button>
						</form>
					</div>

				</div>
			</section>
			</main>
		</div>
		<%!public String makeParameter(final String x) {
		final char SPACE = ' ';
		String rString = "";
		if (x == null)
			return null;
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
