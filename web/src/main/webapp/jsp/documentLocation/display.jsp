<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${documentLocation.name}</title>
</head>
<body>
<h2>${documentLocation.name}</h2>
<p>XPath Experssion: ${documentLocation.xpathExpression}</p>
<p>Description: ${documentLocation.description}</p>
<c:forEach var="ns" items="${documentLocation.namespaces}">
<p>Namespace Prefix: ${ns.prefix} Namespace URI: ${ns.uri}</p>
</c:forEach>
</body>
</html>