<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.Book, model.BookDao" %>
    

<!DOCTYPE html>
<html>
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
success
<br>
<%! String name; %>
<% name =(String) session.getAttribute("id");  %>
 <img alt="test" src=<%= "../img/" + name + ".png" %>> 

</body>
</html>