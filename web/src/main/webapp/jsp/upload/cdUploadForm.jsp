<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Clinical Document Upload</title>
</head>
<body>
<h2>Upload a Clinical Document</h2>
<form:form enctype="multipart/form-data" commandName="clinicalDocument">
<p>Clinical Document Name: <form:input path="name"/></p>
<p>XML Document: <input type="file" id="xmlContent" name="xmlContent"/></p>
<input type="submit" value="Upload" />
</form:form>
</body>
</html>