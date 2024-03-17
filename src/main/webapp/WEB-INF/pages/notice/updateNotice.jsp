<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Announcement</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">

</head>
<div class="container mt-4">
    <h2>Announcement</h2>
    <form id="modifyAnnouncementForm">
        <input type="hidden" name="id" value="${info.id}">

        <div class="form-group">
            <label for="topic">Topic</label>
            <input type="text" class="form-control" id="topic" name="topic" value="${info.topic}" readonly>
        </div>

        <div class="form-group">
            <label for="topic">Author</label>
            <input type="text" class="form-control" id="author" name="author" value="${info.author}" readonly>
        </div>

        <div class="form-group">
            <label for="topic">Release time</label>
            <input type="text" class="form-control" id="createDate" name="createDate"
                   value="<fmt:formatDate value="${info.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly>
        </div>

        <div class="form-group">
            <label for="content">Content</label>
            <textarea class="form-control" id="content" name="content" rows="5" readonly>${info.content}</textarea>
        </div>
    </form>
</div>
</body>
</html>
