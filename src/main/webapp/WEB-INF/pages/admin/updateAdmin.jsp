<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Change Password</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <h2>Change Password</h2>
    <form id="changePasswordForm">
        <input type="hidden" name="id" value="${id}">

        <div class="form-group">
            <label for="oldPwd" class="required">Old Password</label>
            <input type="password" class="form-control" id="oldPwd" name="oldPwd" required placeholder="Enter old password">
        </div>

        <div class="form-group">
            <label for="newPwd" class="required">New Password</label>
            <input type="password" class="form-control" id="newPwd" name="newPwd" required placeholder="Enter new password">
        </div>

        <div class="form-group">
            <label for="newPwdAgain" class="required">Confirm New Password</label>
            <input type="password" class="form-control" id="newPwdAgain" name="newPwdAgain" required placeholder="Confirm new password">
        </div>

        <button type="submit" class="btn btn-primary">Confirm Change</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $('#changePasswordForm').on('submit', function (e) {
            e.preventDefault(); // Prevent the default form submit action

            var oldPwd = $('#oldPwd').val();
            var newPwd = $('#newPwd').val();
            var newPwdAgain = $('#newPwdAgain').val();

            if (newPwd !== newPwdAgain) {
                alert("The new password entered twice is inconsistent, please re-enter it.");
                return;
            }

            var formData = {
                id: $('input[name=id]').val(),
                oldPwd: oldPwd,
                newPwd: newPwd
            };

            $.ajax({
                url: "updatePwdSubmit",
                type: "POST",
                data: formData,
                success: function (result) {
                    if (result.code === 0) {
                        alert("Password successfully changed.");
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert(result.msg);
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
