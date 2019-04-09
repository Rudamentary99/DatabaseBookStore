<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="model.User, model.CartItem, model.CartDao, java.util.ArrayList, model.Cart"%>
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


		<%!ArrayList<CartItem> savedForeLater = new ArrayList<>();%>
		<%!CartDao bd = new CartDao();%>
		<%!User u = new User();%>
		<%!Cart c;%>


		<div class="topnav">
			<a href="index.html">Home</a> <a href="shop.html">Shop</a> <a
				class="activcolor: white;e" href="cart.jsp">Cart</a> <a
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
			<form action="">
				<button type="submit">Proceed to Checkout</button>
			</form>
			<table>
				<%
					u = (User) session.getAttribute("User");
					//if logged in
					if (u != null && u.getFirstName() != null) {
						//if cart not loaded
						c = (Cart) session.getAttribute("Cart");
						if (c == null) {
							//load and save cart
							c = bd.load(u.getUserID());
							session.setAttribute("Cart", c);
						}
						//output cart
						for (CartItem cI : c.getItems()) {
							if (!cI.isSavedForLater()) {
				%>
				<tr>
					<th><a class="itemLink" href=href=
						<%="/SheeteMue/jsp/item.jsp?id=" + cI.getBookID() + "&title="
								+ makeParameter(cI.getTitle()) + "&description=" + makeParameter(cI.getDescription())
								+ "&price=" + makeParameter(Double.toString(cI.getCurrentPrice()))%>><%=cI.getTitle()%></a></th>
					<td>$<%=cI.getCurrentPrice()%></td>
					<td>
						<div class="itemForms">
							<form action="cart.jsp">
								<input type="hidden" name="proc" id="proc" value="1"> <input
									type="hidden" name="id" id="id"
									value=<%="\"" + cI.getBookID() + "\""%>>

								<button id="save" type="submit">Save For Later</button>
							</form>
							<form action="cart.jsp">
								<input type="hidden" name="proc" id="proc" value="2"> <input
									type="hidden" name="id" id="id"
									value=<%="\"" + cI.getBookID() + "\""%>>
								<button id="remove" type="submit">X</button>

							</form>
						</div>
					</td>

				</tr>
				<%
					} else {
								savedForeLater.add(cI);
							}
						}
					}
				%>
			</table>
			<%
				if (savedForeLater.size() > 0) {
			%>
			<h3>Saved For Later</h3>
			<%
				for (CartItem cI : savedForeLater) {
			%>
			<div class="cartItem">
				<a
					href=<%="/SheeteMue/jsp/item.jsp?id=" + cI.getBookID() + "&title=" + makeParameter(cI.getTitle())
							+ "&description=" + makeParameter(cI.getDescription()) + "&price="
							+ makeParameter(Double.toString(cI.getCurrentPrice()))%>>
					<p><%=cI.getTitle()%></p>
					<p>
						$<%=cI.getCurrentPrice()%></p> <br>

				</a>
					<form action="cart.jsp">
						<input type="hidden" name="proc" id="proc" value="3"> <input
							type="hidden" name="id" id="id"
							value=<%="\"" + cI.getBookID() + "\""%>>

						<button id="add" type="submit">Add To Order</button>
					</form>
					<form action="cart.jsp">
						<input type="hidden" name="proc" id="proc" value="2"> <input
							type="hidden" name="id" id="id"
							value=<%="\"" + cI.getBookID() + "\""%>>
						<button id="remove" type="submit">X</button>

					</form>
				</div>
			<%
				}
				}
			%>
		</div>
		<%!String proc;%>
		<%!int r;%>
		<%
			proc = request.getParameter("proc");

			if (proc != null) {
				if (proc.equals("1")) {
					//save for later
					r = bd.update(u.getUserID(), new CartItem(Integer.parseInt(request.getParameter("id")), true));
					//reload cart
					session.removeAttribute("Cart");
					response.sendRedirect("cart.jsp");

				} else if (proc.equals("3")) {
					//add to order
					r = bd.update(u.getUserID(), new CartItem(Integer.parseInt(request.getParameter("id")), false));
					//reload cart
					session.removeAttribute("Cart");
					savedForeLater.clear();
					response.sendRedirect("cart.jsp");

				} else {
					//remove from cart

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


	</header>
</body>
</html>
