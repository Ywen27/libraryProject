<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Add Reader</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-3">
    <h2>Add Reader</h2>
    <form id="addReaderForm">
        <div class="form-group">
            <label for="readerNumber" class="required">Reader No.</label>
            <input type="text" class="form-control" id="readerNumber" name="readerNumber" placeholder="Please enter reader No." required>
        </div>
        <div class="form-group">
            <label for="username" class="required">Username</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Please enter username" required>
        </div>
        <div class="form-group">
            <label for="realName" class="required">Real name</label>
            <input type="text" class="form-control" id="realName" name="realName" placeholder="Please enter real name" required>
        </div>
        <div class="form-group">
            <label class="required">Sex</label>
            <div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="sex" id="male" value="Male" checked>
                    <label class="form-check-label" for="male">Male</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="sex" id="female" value="Female">
                    <label class="form-check-label" for="female">Female</label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="birthday" class="required">Date of birth</label>
            <input type="date" class="form-control" id="birthday" name="birthday" placeholder="Select date of birth" required>
        </div>
        <div class="form-group">
            <label for="tel" class="required">Telephone</label>
            <input type="text" class="form-control" id="tel" name="tel" placeholder="Enter telephone" required>
        </div>
        <div class="form-group">
            <label for="email" class="required">Email</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        $('#addReaderForm').on('submit', function(e) {
            e.preventDefault();
            var formDataArray = $(this).serializeArray();
            var formDataObj = {};

            $(formDataArray).each(function(index, obj){
                formDataObj[obj.name] = obj.value;
            });
            $.ajax({
                url: "${pageContext.request.contextPath}/addReaderSubmit",
                type: 'POST',
                contentType:'application/json',
                data:JSON.stringify(formDataObj),
                success: function(result) {
                    if(result.code == 0) {
                        alert('Added successfully');
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert('Add failed');
                    }
                },
                error: function(xhr) {
                    if(xhr.status == 500) {
                        alert("Reader No. already exists");
                    } else {
                        alert('Error adding reader');
                    }
                }
            });
        });
    });
</script>
</body>
</html>

