<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Modify reader</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <h2>Profile Reader</h2>
    <form id="modifyReaderForm">
        <input type="hidden" name="id" value="${info.id}">

        <div class="form-group">
            <label for="readerNumber" class="required">Reader No.:</label>
            <input type="text" class="form-control" id="readerNumber" name="readerNumber" value="${info.readerNumber}" required readonly>
        </div>

        <div class="form-group">
            <label for="username" class="required">Username:</label>
            <input type="text" class="form-control" id="username" name="username" value="${info.username}" required readonly>
        </div>

        <div class="form-group">
            <label for="realName" class="required">Real Name:</label>
            <input type="text" class="form-control" id="realName" name="realName" value="${info.realName}" required readonly>
        </div>

        <div class="form-group">
            <label class="required">Sex:</label>
            <div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="sex" id="male" value="Male" ${"Male" eq info.sex ? "checked" : ""} disabled>
                    <label class="form-check-label" for="male">Male</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="sex" id="female" value="Female" ${"Female" eq info.sex ? "checked" : ""} disabled>
                    <label class="form-check-label" for="female">Female</label>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="birthday" class="required">Date of birth:</label>
            <input type="date" class="form-control" id="birthday" name="birthday" value="<fmt:formatDate value='${info.birthday}' pattern='yyyy-MM-dd'/>" required readonly>
        </div>

        <div class="form-group">
            <label for="tel" class="required">Telephone:</label>
            <input type="text" class="form-control" id="tel" name="tel" value="${info.tel}" required readonly>
        </div>

        <div class="form-group">
            <label for="email" class="required">Email:</label>
            <input type="email" class="form-control" id="email" name="email" value="${info.email}" required readonly>
        </div>

        <button type="button" id="editButton" class="btn btn-info">Modify</button>
        <button type="submit" id="saveButton" class="btn btn-primary" style="display:none;">Save</button>
    </form>
</div>
<c:if test="${not empty id}">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</c:if>
<script>
    $(document).ready(function() {
        $('#editButton').click(function() {
            $('#modifyReaderForm input').prop('readonly', false);
            $('#modifyReaderForm input[type=radio]').prop('disabled', false);
            $('#saveButton').show();
            $('#editButton').hide();
        });


        $("#modifyReaderForm").submit(function(e) {
            e.preventDefault();
            var formDataArray = $(this).serializeArray();
            var formDataObj = {};
            $(formDataArray).each(function(index, obj){
                formDataObj[obj.name] = obj.value;
            });
            $.ajax({
                url: "updateReaderSubmit",
                type: "POST",
                contentType: 'application/json',
                data: JSON.stringify(formDataObj),
                success: function(result) {
                    if (result.code === 0) {
                        alert('Successfully modified');
                        $('#modifyReaderForm input').prop('readonly', true);
                        $('#modifyReaderForm input[type=radio]').prop('disabled', true);
                        $('#saveButton').hide();
                        $('#editButton').show();
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert("Failed to modify");
                    }
                },
                error: function(xhr) {
                    if(xhr.status == 500) {
                        alert("Reader No. already exists");
                    } else {
                        alert('Error modifying reader');
                    }
                }
            });
        });
    });

</script>
</body>
</html>

