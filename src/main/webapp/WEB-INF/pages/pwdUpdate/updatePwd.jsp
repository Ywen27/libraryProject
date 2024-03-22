<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Change password</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <h2>Change Password</h2>
    <form id="changePasswordForm">
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

        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
<script>
    $(document).ready(function () {
        $('#changePasswordForm').on('submit', function (e) {
            e.preventDefault();
            var oldPassword = $('#oldPwd').val();
            var newPassword = $('#newPwd').val();
            var confirmPassword = $('#newPwdAgain').val();

            if (newPassword !== confirmPassword) {
                alert("The new password entered twice is inconsistent, please re-enter it.");
            } else {
                $.ajax({
                    url: "updatePwdSubmit2",
                    type: "POST",
                    data: {
                        oldPwd: oldPassword,
                        newPwd: newPassword
                    },
                    success: function (result) {
                        if (result.code == 0) {
                            alert("Successfully modified");
                            $('#changePasswordForm')[0].reset();
                        } else {
                            alert(result.msg);
                        }
                    }
                });
            }
        });
    });
</script>
</body>
</html>