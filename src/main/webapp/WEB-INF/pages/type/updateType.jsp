<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Modify Book Type</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <h2>Modify Book Type</h2>
    <form id="modifyBookTypeForm">
        <input type="hidden" name="id" value="${info.id}">

        <div class="form-group">
            <label for="typeName" class="required">Type Name</label>
            <input type="text" name="name" class="form-control" id="typeName" value="${info.name}" required>
        </div>

        <div class="form-group">
            <label for="remarks">Remarks</label>
            <textarea name="remarks" class="form-control" id="remarks">${info.remarks}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function () {
        $('#modifyBookTypeForm').submit(function (event) {
            event.preventDefault();
            var formDataArray = $(this).serializeArray();
            var formDataObj = {};
            $(formDataArray).each(function(index, obj){
                formDataObj[obj.name] = obj.value;
            });

            $.ajax({
                url: "updateTypeSubmit",
                type: "POST",
                contentType: 'application/json',
                data: JSON.stringify(formDataObj),
                success: function (result) {
                    if (result.code == 0) {
                        alert('Successfully modified');
                        parent.$('#MultifunctionModal').modal('hide');
                    } else {
                        alert('Fail to modify');
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error modifying book type: ", error);
                    alert('Error modifying book type');
                }
            });
        });
    });
</script>
</body>
</html>

