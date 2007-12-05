<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Clinical Document Upload</title>

<script type="text/javascript" src="<c:url value="/javascripts/wufoo.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/css/structure.css"/>" type="text/css" />
<link rel="stylesheet" href="<c:url value="/css/form.css"/>" type="text/css" />
<link rel="stylesheet" href="<c:url value="/css/theme.css"/>" type="text/css" />
</head>
<body>
    <img id="top" src="<c:url value="/images/top.png"/>" alt="" />
    <div id="container">
        <h1><a id="logo" href="">Laika</a></h1>
        <form:form enctype="multipart/form-data" commandName="clinicalDocument" cssClass="wufoo">
            <jsp:include page="../partials/header.jsp"/>
            <div class="info">
                <h2>Upload a Clinical Document</h2>
                <p>Store a clinical document in Laika's database so that it can be viewed and tested.</p>
            </div>
            <ul>
                <li>
                <label class="desc">Clinical Document Name</label>
                    <div>
                        <form:input path="name" cssClass="field text small" maxlength="255"/>
                    </div>
                    
                    <p class="instruct">Enter a name that you would like to assign to this clinical document</p>
                </li>
                
                <li>
                <label class="desc">XML Document</label>
                    <div>
                    <input class="field file" type="file" id="xmlContent" name="xmlContent"/>
                    </div>
                </li>
                
                <li class="buttons">
                    <input id="saveForm" class="btTxt" type="submit" value="Upload" />
                </li>
            </ul>
        </form:form>
    </div>
    <img id="bottom" src="images/bottom.png" alt="" />
</body>
</html>