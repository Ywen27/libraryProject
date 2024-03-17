<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Abnormal return</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <form id="abnormalReturnForm">
        <input type="hidden" name="id" value="${id}"/>
        <input type="hidden" name="bookId" value="${bid}"/>

        <div class="form-group">
            <label for="backType" class="required">Exception type</label>
            <select class="form-control" name="backType" id="backType" required>
                <option value="">Please select</option>
                <option value="1">Late</option>
                <option value="2">Damaged</option>
                <option value="3">Lost</option>
            </select>
        </div>

        <div class="form-group">
            <label for="remarks">Exception remarks</label>
            <textarea class="form-control" name="exceptRemarks" id="remarks"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Return book</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $('#abnormalReturnForm').submit(function (event) {
            event.preventDefault();
            var formData = $(this).serialize();

            $.ajax({
                url: "updateLendInfoSubmit",
                type: "POST",
                data: formData,
                success: function (result) {
                    if (result.code == 0) {
                        alert('Return successfully');
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert("Failed to return");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error when returning: ", error);
                }
            });
        });
    });
</script>
</body>
</html>
