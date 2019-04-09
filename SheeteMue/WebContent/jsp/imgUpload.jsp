<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.Book, model.BookDao" %>
<!DOCTYPE html>
<jsp:useBean id="NewItem" class="model.Book" scope="session"></jsp:useBean>
<jsp:setProperty property="publisherID" name="NewItem" param="publisherID"/>
<jsp:setProperty property="authorName" name="NewItem" param="authorName"/>
<jsp:setProperty property="title" name="NewItem" param="title"/>
<jsp:setProperty property="edition" name="NewItem" param="edition"/>
<jsp:setProperty property="pubDate" name="NewItem" param="pubDate"/>
<jsp:setProperty property="description" name="NewItem" param="description"/>
<jsp:setProperty property="currentPrice" name="NewItem" param="currentPrice"/>
<jsp:setProperty property="amountInStock" name="NewItem" param="amountInStock"/>
<html lang="en">
<head>
  <meta charset="utf-8">

  <title>Sheet μ | Administrator Settings</title>

  <link rel="stylesheet" href="../css/style.css">
  <meta id="wixMobileViewport" name="viewport" content="width=980, user-scalable=yes"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
  <header>
  <h6>Sheet μ</h6>
<html>
<body>
<%! Book b = new Book(); %>
  <div class="topnav">
    <a href="index.html">Home</a>
    <a href="shop.html">Shop</a>
    <a href="cart.html">Cart</a>
    <a href="about.html">About</a>
    <a href="contact.html">Contact</a>

    <div class="search-container">
      <form action="/action_page.php">
        <a class="active" href="create.html">Create Account</a><a href="user.html">User Settings</a><a href="login.html">Login</a>
        <input type="text" placeholder="Search.." name="search">
        <button type="submit"><i class="fa fa-search"></i></button>
      </form>
    </div>
  </div>
<br>
<%
b = (Book) session.getAttribute("NewItem");
if (b != null) {
	out.print(b.getTitle());
}
%>

<div style="padding-left:16px">
<form action="imgUpload.jsp">
  Upload Musics stock photo<br><br>
  <input name="img" type="file" accept=".png" ><br><br>
  <button type="submit">Submit</button><br><br><br>
  </form>
</div>
<img alt="test" src=<%= "\"" + request.getParameter("img") + "\"" %>>
</body>
</html>
</header>
</body>
</html>
