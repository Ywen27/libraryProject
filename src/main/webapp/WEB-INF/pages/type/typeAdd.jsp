<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add book type</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <form id="addBookTypeForm">
        <div class="form-group">
            <label for="typeName" class="required">Type Name</label>
            <input type="text" name="name" class="form-control" id="typeName" placeholder="Please enter a type name" required>
            <small class="form-text text-muted">Fill in with the new type name.</small>
        </div>
        <div class="form-group">
            <label for="remarks">Remarks</label>
            <textarea name="remarks" class="form-control" id="remarks" placeholder="Please enter remark information"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $('#addBookTypeForm').submit(function (event) {
            event.preventDefault();

            var formData = $(this).serialize();

            $.ajax({
                url: "addTypeSubmit",
                type: "POST",
                data: formData,
                success: function (result) {
                    if (result.code == 0) {
                        alert('Added successfully');
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert('Add failed');
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error adding book type: ", error);
                    alert('Error adding book type');
                }
            });
        });
    });
</script>
</body>
</html>

