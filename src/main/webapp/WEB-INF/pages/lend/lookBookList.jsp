<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
    <meta charset="utf-8">
    <title>Timeline query</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        body {
            background-color: #f7f7f7;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2>Book Lending Timeline</h2>

        <c:choose>
            <c:when test="${not empty info}">
                <ul class="timeline">
                <c:forEach var="lend" items="${info}" varStatus="status">
                    <li class="timeline-item">
                        <div class="timeline-marker"></div>
                        <div class="timeline-content">
                            <p class="timeline-time">
                                <fmt:formatDate value="${lend.lendDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </p>
                            <h5 class="timeline-title">
                                <span style="color: #007bff">${lend.readerInfo.realName}</span> borrows <span style="color: #17a2b8">"${lend.bookInfo.name}"</span>
                            </h5>
                            <div class="timeline-body">
                                <c:if test="${lend.backDate == null}">
                                    <p>Not returned yet</p>
                                </c:if>
                                <c:if test="${lend.backDate != null}">
                                    <p>Returned on <span style="color: #28a745"><fmt:formatDate value="${lend.backDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span></p>
                                </c:if>
                            </div>
                        </div>
                    </li>
                </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info text-center">No loan records found</div>
            </c:otherwise>
        </c:choose>

</div>

<c:if test="${not sessionScope.type.equals('reader')}">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</c:if>
</body>
</html>