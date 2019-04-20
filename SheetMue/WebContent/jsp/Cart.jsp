<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="model.User, model.CartItem, model.CartDao, java.util.ArrayList, model.Cart"%>
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
		<a <%=style%> href=<%= request.getContextPath() + "/CartServlet?action=viewCart" %>>Cart</a>
		<a
			href="../HTML/about.html">About</a> <a href="contact.html">Contact</a>
		<div class="search-container">
			<form action=<%= request.getContextPath() + "/jsp/search.jsp" %>>
			
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

		<%!ArrayList<CartItem> savedForeLater = new ArrayList<>();%>
		<%!CartDao bd = new CartDao();%>
		<%!Cart co;%>
		<%!Cart cs; %>



		<div style="padding-left: 16px">
			<form action="">
				<button type="submit">Proceed to Checkout</button>
			</form>
			<h3>Cart Items:</h3>
			<table>
				<%
					//if cart not loaded
					co = (Cart) session.getAttribute("CartOrder");
					if (co != null) {
						//load and save cart

						//output cart
						for (CartItem cI : co.getItems()) {
							
				%>
				<tr>
					<th><a class="itemLink" href=href=
						<%="/SheeteMue/jsp/item.jsp?id=" + cI.getBookID() + "&title="
								+ makeParameter(cI.getTitle()) + "&description=" + makeParameter(cI.getDescription())
								+ "&price=" + makeParameter(Double.toString(cI.getCurrentPrice()))%>><%=cI.getTitle()%></a></th>
					<td>$<%=cI.getCurrentPrice()%></td>
					<td>
						<div class="itemForms">
							<form action=<%=request.getContextPath() + "/CartServlet"%>>
								<input type="hidden" name="action" value="saveForLater">
								<input type="hidden" name="bookID"
									value=<%="\"" + cI.getBookID() + "\""%>>

								<button id="save" type="submit">Save For Later</button>
							</form>
							<form action=<%=request.getContextPath() + "/CartServlet"%>>
								<input type="hidden" name="action" value="removeFromCart">
								<input type="hidden" name="bookID"
									value=<%="\"" + cI.getBookID() + "\""%>>
								<button id="remove" type="submit">X</button>

							</form>
						</div>
					</td>

				</tr>
				<%
					
							
						}
					}
				%>
			</table>
			<%
				cs = (Cart) session.getAttribute("CartSave");
			
				if (cs != null) {
			%>
			<h3>Saved For Later:</h3>
			<%
				for (CartItem cI : cs.getItems()) {
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
				<form action=<%=request.getContextPath() + "/CartServlet"%> method="post">
					<input type="hidden" name="action" value="addToOrder"> <input
						type="hidden" name="bookID"
						value=<%="\"" + cI.getBookID() + "\""%>>

					<button id="add" type="submit">Add To Order</button>
				</form>
				<form action=<%=request.getContextPath() + "/CartServlet"%> method="post">
					<input type="hidden" name="action" value="removeFromCart">
					<input type="hidden" name="bookID"	value=<%="\"" + cI.getBookID() + "\""%>>
					<button id="remove" type="submit">X</button>

				</form>
			</div>
			<%
				}
				}
			%>
		</div>
		

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
