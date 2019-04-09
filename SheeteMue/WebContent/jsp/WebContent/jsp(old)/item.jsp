<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="model.Book, model.BookDao" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1"/>
    <meta charset="utf-8"/>

<title><%= "SheetMue/" + request.getParameter("id") %></title>

<meta property="og:title" content="I'm a Product"/>
<meta property="og:type" content="product"/>
<meta property="og:url" content="//noahrejda.wixsite.com/mysite/product-page/i-m-a-product-9"/>
<meta property="og:site_name" content="mysite"/>
<meta property="og:description" content="I'm a product description. I'm a great place to add more details about your product such as sizing, material, care instructions and cleaning instructions."/>

<meta id="wixMobileViewport" name="viewport" content="width=980, user-scalable=yes"/>
<link rel="stylesheet" type="text/css" href="../css/style.css">




        </head>
<body>
	<%! BookDao bd = new BookDao(); %>
	<%! Book b = new Book(); %>
	<%b = bd.load(Integer.parseInt(request.getParameter("id"))); %>
            <header class="container" id="SITE_HEADER" >
            <section class="container" id="comp-j7ajym72" >
            <section class="container" id="comp-j7ajym85" >
            <div id="comp-j7ajzaby" class="Text">
    <h6>Sheet μ</h6>
</div>


    </section>

    </section>

    </header>
<section class="page" id="fz7md">
                <span id="comp-j7ekj3y3">
    <!-- placeholder for component of data type=VectorImage -->
</span>
            <div id="comp-j7al14wy1" type="TPA-Part" class="anon$2">

</div>
            <div id="TPAMultiSection_j7al14wm" type="TPA-Part" class="anon$1">
<main class="ecom-style-container">
 <ul itemscope itemtype="http://schema.org/BreadcrumbList" class="ecom-style-breadcrumbs">
  <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"> <a itemprop="item" href="//noahrejda.wixsite.com/mysite"> <span itemprop="name">Home</span> </a>
   <meta itemprop="position" content="1"> </li>
  <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"> <a itemprop="item" href="//noahrejda.wixsite.com/mysite/product-page/i-m-a-product-9"> <span itemprop="name"><%= b.getTitle() %></span> </a>
   <meta itemprop="position" content="2"> </li>
 </ul>
 <section id="e9f36bee-5450-165e-06d5-a6df21c29715" itemscope itemtype="http://schema.org/Product" class="ecom-style-product-section">
  <div class="ecom-style-product-info">
   <h1 itemprop="name" class="ecom-style-product-name"><%= b.getTitle() %></h1>
   <div class="ecom-style-sku">
    SKU:
    <span itemprop="sku"><%= b.getBookID() %></span>
   </div>
   <div id="price" class="ecom-style-price" itemprop="offers" itemtype="http://schema.org/Offer" itemscope>
    <span itemprop="priceCurrency" content="USD">$</span>
    <span itemprop="price" content="25.00"><%= b.getCurrentPrice() %></span>
    <link itemprop="availability" href="http://schema.org/InStock">
  </div>
   <img src="../img/img.png" style="width: 300px; height: 400px;">
   <ul id="faq" class="ecom-style-info-sections">
    <li class="ecom-style-info-section-item"> <h3 class="ecom-style-info-section-item-title">PRODUCT INFO</h3> <p></p><p>I'm a product detail. I'm a great place to add more information about your product such as sizing, material, care and cleaning instructions. This is also a great space to write what makes this product special and how your customers can benefit from this item.</p> <p></p> </li>
    <li class="ecom-style-info-section-item"> <h3 class="ecom-style-info-section-item-title">RETURN &amp; REFUND POLICY</h3> <p></p><p>I’m a Return and Refund policy. I’m a great place to let your customers know what to do in case they are dissatisfied with their purchase. Having a straightforward refund or exchange policy is a great way to build trust and reassure your customers that they can buy with confidence.</p> <p></p> </li>
    <li class="ecom-style-info-section-item"> <h3 class="ecom-style-info-section-item-title">SHIPPING INFO</h3> <p></p><p>I'm a shipping policy. I'm a great place to add more information about your shipping methods, packaging and cost. Providing straightforward information about your shipping policy is a great way to build trust and reassure your customers that they can buy from you with confidence.</p> <p></p> </li>
   </ul>
  </div>
  <div class="ecom-style-product-gallery">
   <p itemprop="description" class="ecom-style-product-description"></p>
   <p><%= b.getDescription()%></p>
   <p></p>
   
   <button type="submit" value="Add to Cart">
  
  
  </div>
 </section>
</main>
</div>
        </body>
</html>
