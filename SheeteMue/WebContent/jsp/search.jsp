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


	<a
		href=<%="/SheeteMue/jsp/item.jsp?id=" + b.getBookID() + "&title=" + makeParameter(b.getTitle())
		+ "&description=" + makeParameter(b.getDescription()) + "&price=" + makeParameter(Double.toString(b.getCurrentPrice()))%>>
		<%=b.getTitle()%></a>
	<br>

	<%
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

</body>
</html>