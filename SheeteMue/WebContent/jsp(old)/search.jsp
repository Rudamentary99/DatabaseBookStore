<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.SearchBook, model.BookDao"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>search</title>
</head>
<body>
	<%!BookDao bd = new BookDao();%>
	<%!ArrayList<SearchBook> searchBooks = new ArrayList<>();%>
	<%!ArrayList<Integer> bookIDs = new ArrayList<>();%>
	<div class="search-container">
		<form action="/SheeteMue/jsp/search.jsp">
			<input type="text" placeholder="Search.." name="search">
			<button type="submit">
				<i class="fa fa-search"></i>
			</button>
		</form>
	</div>
	<%
		
			searchBooks = bd.Search(request.getParameter("search"));
			if (searchBooks != null) {
				
				for (SearchBook b : searchBooks) {
			Integer.toString(b.getBookID());
					bookIDs.add(b.getBookID());
	%>				
	<a href=<%="/SheeteMue/jsp/item.jsp?id=" + b.getBookID()%>> <%= b.getTitle() %></a><br>
	<%
				}
			}
	%>
	
</body>
</html>