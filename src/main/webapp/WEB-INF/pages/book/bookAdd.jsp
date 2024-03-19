<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Add book</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container">
    <h2 class="my-4">Add Book</h2>
    <form id="addBookForm">
        <div class="form-group">
            <label for="bookName" class="required">Name</label>
            <input type="text" class="form-control" id="bookName" name="name" placeholder="Please enter the book name" required>
        </div>
        <div class="form-group">
            <label for="bookISBN" class="required">ISBN</label>
            <input type="text" class="form-control" id="bookISBN" name="isbn" placeholder="Please enter the ISBN" required>
        </div>
        <div class="form-group">
            <label for="bookType" class="required">Type</label>
            <select class="form-control" id="bookType" name="typeId" required>
                <option value="">Please select</option>
                <!-- Options will be added here dynamically -->
            </select>
        </div>
        <div class="form-group">
            <label for="bookAuthor" class="required">Author</label>
            <input type="text" class="form-control" id="bookAuthor" name="author" required>
        </div>
        <div class="form-group">
            <label for="publishingHouse" class="required">Publishing House</label>
            <input type="text" class="form-control" id="publishingHouse" name="publish" required>
        </div>
        <div class="form-group">
            <label for="bookLanguage">Language</label>
            <input type="text" class="form-control" id="bookLanguage" name="language">
        </div>
        <div class="form-group">
            <label for="bookPrice">Price</label>
            <input type="number" class="form-control" id="bookPrice" name="price">
        </div>
        <div class="form-group">
            <label for="publicationDate">Publication Date</label>
            <input type="date" class="form-control" id="publicationDate" name="publishDate">
        </div>
        <div class="form-group">
            <label for="bookIntroduction">Introduction</label>
            <textarea class="form-control" id="bookIntroduction" name="introduction" rows="3" placeholder="Please enter introduction information"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        $.get("${pageContext.request.contextPath}/findAllList", function(data) {
            $.each(data, function(index, item) {
                $('#bookType').append($('<option>', {
                    value: item.id,
                    text: item.name
                }));
            });
        });

        // Handle form submission
        $('#addBookForm').submit(function(e) {
            e.preventDefault();
            var formData = $(this).serialize(); // Serialize form data
            $.ajax({
                url: "${pageContext.request.contextPath}/addBookSubmit",
                type: "POST",
                data: formData,
                success: function(result) {
                    if (result.code === 0) {
                        alert('Added successfully');
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert('Add failed');
                    }
                },
                error: function() {
                    alert('Error adding book');
                }
            });
        });
    });
</script>
</body>
</html>

