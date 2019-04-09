<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.SearchBook, model.BookDao, model.User"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>Sheet μ | Search</title>

<link rel="stylesheet" href="../css/style.css">
<meta id="wixMobileViewport" name="viewport"
	content="width=980, user-scalable=yes" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%!BookDao bd = new BookDao();%>
	<%!ArrayList<SearchBook> searchBooks = new ArrayList<>();%>
	<%!ArrayList<Integer> bookIDs = new ArrayList<>();%>
	<%!User u = new User();%>
	

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
							+ "&description=" + makeParameter(b.getDescription()) + "&price="
							+ makeParameter(Double.toString(b.getCurrentPrice()))%>>
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