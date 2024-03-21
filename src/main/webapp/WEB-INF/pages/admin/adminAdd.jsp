<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Admin add</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Add Administrator</h2>
    <form id="adminForm">
        <div class="form-group">
            <label for="username" class="form-label required">Username</label>
            <input type="text" class="form-control" id="username" name="username" required placeholder="Please enter username">
        </div>
        <div class="form-group">
            <label for="password" class="form-label required">Password</label>
            <input type="password" class="form-control" id="password" name="password" required placeholder="Please enter password">
        </div>
        <div class="form-group">
            <label for="adminType" class="form-label required">Administrator Type</label>
            <select class="form-control" id="adminType" name="adminType">
                <option value="">Please select</option>
                <option value="0">Ordinary Administrator</option>
                <option value="1">Senior Administrator</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $('#adminForm').on('submit', function (e) {
            e.preventDefault();
            var formData = $(this).serialize();

            $.ajax({
                url: "addAdminSubmit", // Your submission URL
                type: "POST",
                data: formData,
                success: function (result) {
                    if (result.code === 0) {
                        alert('Add success');
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert("Add failed");
                    }
                },
                error: function (xhr, status, error) {
                    alert('Error: ' + error.message);
                }
            });
        });
    });
</script>
</body>
</html>
