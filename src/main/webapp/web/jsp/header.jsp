<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${title}</title>

    <link rel="stylesheet" type="text/css"
          href="<spring:url value="/web/css/bootstrap.css"/>"/>
    <link rel="stylesheet" type="text/css"
          href="<spring:url value="/web/css/tabs.css"/>"/>
    <link rel="stylesheet" type="text/css"
          href="<spring:url value="/web/css/bootstrap-select.css"/>"/>
    <link rel="stylesheet" type="text/css"
          href="<spring:url value="/web/css/eventCalendar.css"/>"/>
    <link rel="stylesheet" type="text/css"
          href="<spring:url value="/web/css/eventCalendar_theme.css"/>"/>
    <link rel="stylesheet" type="text/css"
          href="<spring:url value="/web/css/bootstrap-datetimepicker.css"/>"/>
    <link rel="stylesheet" type="text/css"
          href="<spring:url value="/web/css/style.css"/>"/>

</head>

<body>

<div class="header navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <%
            String style = "";
            if (request.getAttribute("username") == null)
                style = "style='display: none;'";
            else
                style = "style='display: block;'";
        %>
        <div class="navbar-header">
            <button type="button" class="navbar-toggle open-menu" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">EMT</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="navbar-nav nav">
                <c:forEach var="type" items="${navigation}">
                    <li><a href="<spring:url value="${type.value}"/>">${type.key}</a></li>
                </c:forEach>
            </ul>
            <ul <%=style%> class="navbar-nav nav navbar-right">
                <li><a>User Name: ${username}</a></li>
                <li><a href="<spring:url value="/j_spring_security_logout" />"> Logout</a></li>
            </ul>
        </div>
        <!-- /navbar -->
    </div>
</div>
<div id="content">
    <div class="container">