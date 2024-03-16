<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Home page</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-3">
    <div class="row">
        <div class="col-12">
            <h2>Home page</h2>
            <div class="announcement-header">
                <h4><i class="bi bi-megaphone mr-2"></i>System Announcement</h4>
            </div>
            <c:forEach var="notice" items="${noticeList}" varStatus="status">
                <div class="announcement-item ${status.index % 2 == 0 ? 'bg-light' : 'announcement-content'}">
                    <div class="announcement-title">
                        <i class="bi bi-bell" style="font-size: 1.3rem; color: red;"></i>
                        <h5>${notice.topic}</h5>
                    </div>
                    <p class="announcement-date"><fmt:formatDate value="${notice.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
                    <p class="announcement-content text-truncate">${notice.content}</p>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        $('.announcement-item').on('click', function() {
            var title = $(this).find('.announcement-title').text();
            var content = $(this).find('.announcement-content').text();
            var date = $(this).find('.announcement-date').text();
            var modalHtml = '<div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="noticeModalLabel" aria-hidden="true">' +
                '<div class="modal-dialog" role="document">' +
                '<div class="modal-content">' +
                '<div class="modal-header">' +
                '<h5 class="modal-title" id="noticeModalLabel">' + title + '</h5>' +
                '<button type="button" class="close" data-dismiss="modal" aria-label="Close">' +
                '<span aria-hidden="true">&times;</span>' +
                '</button>' +
                '</div>' +
                '<div class="modal-body">' +
                '<p class="announcement-date">' + date + '</p>' +
                content +
                '</div>' +
                '<div class="modal-footer">' +
                '<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>';
            $(modalHtml).modal('show');
        });
    });
</script>
</body>
</html>