<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<embed src=<%= request.getContextPath() + "/img/test.pdf" %>  type="application/pdf">
</body>
</html>