<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a document location</title>
</head>
<body>
<h2>Create a document location</h2>
<form:form commandName="documentLocation">
<p>Name: <form:input path="name"/></p>
<p>XPath Expression: <form:input path="xpathExpression"/></p>
<p>Description: <form:textarea path="description"/></p>
<input type="submit" value="Create" />
</form:form>
</body>
</html>