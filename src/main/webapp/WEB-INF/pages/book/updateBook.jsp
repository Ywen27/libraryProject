<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Modify book</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <h2>Edit book info</h2>
    <form id="modifyBookForm">
        <input type="hidden" name="id" value="${info.id}">

        <div class="form-group">
            <label for="name" class="required">Name</label>
            <input type="text" class="form-control" id="name" name="name" required value="${info.name}">
        </div>

        <div class="form-group">
            <label for="isbn" class="required">ISBN</label>
            <input type="text" class="form-control" id="isbn" name="isbn" required value="${info.isbn}">
        </div>

        <div class="form-group">
            <label for="typeId" class="required">Type</label>
            <select class="form-control" id="typeId" name="typeId" required>
                <option value="">Please select</option>
                <!-- Options will be added here dynamically -->
            </select>
        </div>

        <div class="form-group">
            <label for="author" class="required">Author</label>
            <input type="text" class="form-control" id="author" name="author" required value="${info.author}">
        </div>

        <div class="form-group">
            <label for="publish" class="required">Publishing House</label>
            <input type="text" class="form-control" id="publish" name="publish" required value="${info.publish}">
        </div>

        <div class="form-group">
            <label for="language">Language</label>
            <input type="text" class="form-control" id="language" name="language" value="${info.language}">
        </div>

        <div class="form-group">
            <label for="price">Price</label>
            <input type="number" class="form-control" id="price" name="price" value="${info.price}">
        </div>

        <div class="form-group">
            <label for="publishDate">Publication Date</label>
            <input type="date" class="form-control" id="publishDate" name="publishDate" value="<fmt:formatDate value="${info.publishDate}" pattern="yyyy-MM-dd"/>">
        </div>

        <div class="form-group">
            <label for="introduction">Introduction</label>
            <textarea class="form-control" id="introduction" name="introduction" rows="3">${info.introduction}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Modify</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $.get("${pageContext.request.contextPath}/findAllList", function(data) {
            var typeId = ${info.typeId};
            $.each(data, function(index, item) {
                var selected = item.id == typeId ? " selected" : "";
                $("#typeId").append('<option value="'+ item.id + '"' + selected + '>'+ item.name +'</option>');
            });
        }, "json");

        // Handle form submission
        $("#modifyBookForm").submit(function(e) {
            e.preventDefault();
            var formDataArray = $(this).serializeArray();
            var formDataObj = {};
            $(formDataArray).each(function(index, obj){
                formDataObj[obj.name] = obj.value;
            });

            $.ajax({
                url: "updateBookSubmit",
                type: "POST",
                contentType: 'application/json',
                data: JSON.stringify(formDataObj),
                success: function(result) {
                    if (result.code === 0) {
                        alert("Successfully modified");
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert("Failed to modify");
                    }
                },
                error: function() {
                    alert("An error occurred");
                }
            });
        });
    });
</script>
</body>
</html>

