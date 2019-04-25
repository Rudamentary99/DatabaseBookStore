<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page
	import="model.User, model.Book, model.BookDao, model.CartDao, java.util.List"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1" />
<meta charset="utf-8" />

<title>Sheet μ | Item</title>
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
<link rel="stylesheet" type="text/css"
	href=<%=request.getContextPath() + "/css/style.css"%>>
</head>
<body>
	<div class="topnav">
		<a class="active" href=<%= request.getContextPath() + "/jsp/index.jsp" %>>Home</a> 
		<a href=<%= request.getContextPath() + "/BookServlet?action=shopByCategory" %>>Shop</a> 
		<%!String mStyle;
	String mMessage;
	

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



	<br>
	<%!BookDao bd = new BookDao();%>
	<%!User u = new User();%>
	<%!Book b = new Book();
	boolean adminOptions = true;
	int index;
	int i;
	String action;%>
	<%
		index = Integer.parseInt(request.getParameter("index"));
		action = request.getParameter("action");
		if (action != null && action.equals("viewItem")) {
			b = ((List<Book>) session.getAttribute("SearchItems")).get(index);
		} else if (request.getParameter("genre") != null) {
			b = ((List<Book>) session.getAttribute(request.getParameter("genre"))).get(index);
			adminOptions = false;
		} else {
			i = Integer.parseInt(request.getParameter("i"));
			b = ((List<List<Book>>) session.getAttribute("BooksByGenre")).get(i).get(index);
			adminOptions = false;
		}
	%>

		
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
						<span itemprop="name"><%=b.getTitle()%></span>
				</a>
					<meta itemprop="position" content="2"></li>
			</ul>
			<section id="e9f36bee-5450-165e-06d5-a6df21c29715" itemscope
				itemtype="http://schema.org/Product"
				class="ecom-style-product-section">
				<div class="ecom-style-product-info">
					<h1 itemprop="name" class="ecom-style-product-name"><%=b.getTitle()%></h1>
					<div class="ecom-style-sku"></div>
					<div id="price" class="ecom-style-price" itemprop="offers"
						itemtype="http://schema.org/Offer" itemscope>
						<span itemprop="priceCurrency" content="USD">$</span> <span
							itemprop="price" content="25.00"><%=b.getCurrentPrice()%></span>
						<link itemprop="availability" href="http://schema.org/InStock">
					</div>
					<embed
						src=<%=request.getContextPath() + "/img/" + Integer.toString(b.getBookID()) + ".pdf"%>
						style="width: 300px; height: 400px;" type="application/pdf">
				</div>

				<div class="ecom-style-product-gallery">
					<p itemprop="description" class="ecom-style-product-description"></p>
					<p><%=b.getDescription()%></p>
					<p></p>



					<div class="item-container">
						<%!String addMessage;%>
						<%
							addMessage = (String) request.getAttribute("cartAddMessage");
							if (addMessage != null) {
								out.print(addMessage + "<br>");
							}
						%>

						<form action=<%=request.getContextPath() + "/BookServlet"%>
							method="post">
							<input type="hidden" name="action" value="addToCart"> <input
								type="hidden" name="bookID" value=<%=b.getBookID()%>> <input
								type="hidden" name="index"
								value=<%=request.getParameter("index")%>>
							<button type="submit">Add To Cart</button>
						</form>
						<%
							if (u != null && u.getFirstName() != null && u.isAdmin() && adminOptions) {
						%>
						<form action=<%=request.getContextPath() + "/AdminServlet"%>
							method="post">
							<input type="hidden" name="action" value="updateBook"> <input
								type="hidden" name="id" value=<%="\"" + b.getBookID() + "\""%>>
							<input type="hidden" name="index"
								value=<%=request.getParameter("index")%>>
							<button type="submit">Edit</button>
						</form>
						<form action=<%=request.getContextPath() + "/jsp/imgUpload.jsp"%>
							method="post">
							<input type="hidden" name="action" value="editFoley"> <input
								type="hidden" name="bookID" value=<%="\"" + b.getBookID() + "\""%>>
							<input type="hidden" name="index"
								value=<%=request.getParameter("index")%>>
							<button type="submit">Edit foley</button>
						</form>

						<%
							}
						%>
					</div>

				</div>
			</section>
			</main>
		</div>
</body>
</html>
