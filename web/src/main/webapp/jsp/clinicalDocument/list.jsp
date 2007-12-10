<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Clinical documents</title>
        <link rel="stylesheet" href="<c:url value="/css/structure.css"/>" type="text/css" />
        <link rel="stylesheet" href="<c:url value="/css/form.css"/>" type="text/css" />
        <link rel="stylesheet" href="<c:url value="/css/theme.css"/>" type="text/css" />
        
    </head>
    <body>
        <img id="top" src="<c:url value="/images/top.png"/>" alt="" />
        <div id="container">
            <h1><a id="logo" href="">Laika</a></h1>
            <div class="wufoo">
        <jsp:include page="../partials/header.jsp"/>
        <div class="info">
            <h2>Clinical documents stored in Laika</h2>
            <p>All of the documents uploaded into Laika</p>
        </div>
        
        <c:forEach var="doc" items="${clinicalDocumentList}">
            <div class="doc">
                <h3><c:out value="${doc.name}"/></h3>
                <ul class="docActions">
                    <li><a href="">View</a></li>
                    <li><a href="">Validate</a></li>
                    <li><a href="">Run Test</a></li>
                    <li><a href="<c:url value="/clinicalDocument/delete.lk"><c:param name="cd_id" value="${doc.id}"/></c:url>">Delete</a></li>
                </ul>
            </div>
        </c:forEach>
        
</div>
    </div>
    </body>
    <img id="bottom" src="images/bottom.png" alt="" />
</html>