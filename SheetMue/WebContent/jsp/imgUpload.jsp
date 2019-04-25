<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.Book, model.BookDao, model.User" %>
<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="utf-8">

  <title>Sheet μ | Administrator Settings</title>

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
		<a class="active" href=<%= request.getContextPath() + "/jsp/index.jsp" %>>Home</a> <a href="shop.jsp">Shop</a> 
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
<%!
Book b; 
	String action;
	int editBookID;
%>
<%

	b = (Book)request.getAttribute("editBookID");
	 if (b != null) {
		editBookID = b.getBookID();
	 } else if(request.getParameter("bookID") != null) {
		editBookID = Integer.parseInt(request.getParameter("bookID"));
	} else {
		response.sendRedirect("/jsp/index.jsp");
	}

%>
<div style="padding-left:16px">
  Upload Musics stock photo<br><br>
	
<form action=<%= request.getContextPath() + "/AdminServlet?action=saveFoley&bookID="+ editBookID %>  enctype="multipart/form-data" method="post">
  	Upload Image:<input type="file" name="img" accept=".pdf" required>
    <button type="submit">Submit</button><br><br><br>
  </form>
</div>

</body>
</html>
</header>
</body>
</html>
