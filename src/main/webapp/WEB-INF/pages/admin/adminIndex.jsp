<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Administrator</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-3">
    <div class="row">
        <div class="col">
            <h2>Administrator</h2>
            <div class="form-row mb-3">
                <div class="col">
                    <input type="text" id="username" class="form-control" placeholder="Username" autocomplete="off">
                </div>
                <div class="col">
                    <select id="adminType" class="form-control">
                        <option value="">Please select admin type</option>
                        <option value="0">Ordinary administrator</option>
                        <option value="1">Senior Administrator</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button id="searchButton" class="btn btn-primary">Search</button>
                </div>
            </div>
            <div class="btn-group mb-3" role="group">
                <button type="button" id="addButton" class="btn btn-primary mr-2">Add</button>
                <button type="button" id="deleteSelectedButton" class="btn btn-danger">Delete</button>
            </div>
            <table class="table" id="adminTable">
                <thead>
                <tr>
                    <th scope="col"><input type="checkbox" id="checkAll"></th>
                    <th scope="col">Username</th>
                    <th scope="col">Administrator type</th>
                    <th scope="col">Operation</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
            <div id="noDataMessage" class="alert alert-warning text-center" style="display:none;">No corresponding data</div>
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item" id="previousPage"><a class="page-link" href="#">Previous</a></li>
                    <li class="page-item" id="nextPage"><a class="page-link" href="#">Next</a></li>
                    <li class="page-item">
                        <input type="number" class="form-control page-number-input" placeholder="Page #" min="1"
                               style="width: 100px; text-align: center;" value="1">
                    </li>
                    <li class="page-item">
                        <button class="btn btn-primary go-to-page-btn">Go</button>
                    </li>


                    <li class="page-item">
                        <select class="custom-select items-per-page-select">
                            <option value="10" selected>10 per page</option>
                            <option value="15">15 per page</option>
                            <option value="20">20 per page</option>
                            <option value="30">30 per page</option>
                        </select>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<div class="modal fade" id="MultifunctionModal" tabindex="-1" role="dialog" aria-labelledby="MultifunctionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content custom-modal-height">
            <div class="modal-header">
                <h5 class="modal-title" id="MultifunctionModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
        </div>
    </div>
</div>
<script>
    function loadAdmin(filters = {}) {
        $.ajax({
            url: '${pageContext.request.contextPath}/adminAll',
            type: 'GET',
            data: filters,
            success: function (response) {
                $('#adminTable tbody').empty();
                if (response.data.length === 0) {
                    $('#noDataMessage').show();
                } else {
                    $('#noDataMessage').hide();
                    response.data.forEach(function (item) {
                        var operationButtons = '<a href="#" class="btn btn-info btn-sm editButton" style="margin-bottom: 5px;">' +
                            'Change Password</a> ' + '&nbsp;&nbsp' + '<a href="#" ' +
                            'class="btn btn-danger btn-sm deleteButton">Delete</a>';
                        var row = '<tr>' +
                            '<td><input type="checkbox" class="item-check" data-id="' + item.id + '"></td>' +
                            '<td>' + item.username + '</td>' +
                            '<td>' + formatAdminType(item.adminType) + '</td>' +
                            '<td>' + operationButtons + '</td>' +
                            '</tr>';
                        $('#adminTable tbody').append(row);
                    });
                }

            },
            error: function (xhr, status, error) {
                console.error("Error loading table data", error);
            }
        });
    }

    function formatAdminType(adminType) {
        switch (adminType) {
            case 0: return '<span class="badge badge-primary">Ordinary administrator</span>';;
            case 1: return '<span class="badge badge-warning">Senior Administrator</span>';
        }
    }

    function loadAdminsData(page, limit) {
        var filters = {
            username: $('#username').val(),
            adminType: $('#adminType').val(),
            pageNum: page,
            limit: limit
        };
        loadAdmin(filters);
    }

    function openAddAdminDialog() {
        var url = '${pageContext.request.contextPath}/adminAdd';
        $('#MultifunctionModalLabel').text('Add Admin');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    function openEditDialog(adminId) {
        var url = '${pageContext.request.contextPath}/queryAdminById?id='+adminId;
        $('#MultifunctionModalLabel').text('Modify admin password');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    $(document).ready(function () {
        var currentPage = 1;
        var itemsPerPage = 10;
        loadAdminsData(currentPage, itemsPerPage);
        $('#username, #adminType').on('input', function() {
            var allFieldsEmpty = $('#username').val().trim() === '' &&
                $('#adminType').val().trim() === '';

            if(allFieldsEmpty) {
                loadAdminsData(currentPage, itemsPerPage);
            }
        });

        $('.go-to-page-btn').on('click', function () {
            var pageNumber = $('.page-number-input').val();
            if (pageNumber) {
                pageNumber = parseInt(pageNumber, 10);
                if (pageNumber > 0) {
                    currentPage = pageNumber;
                    $('.page-number-input').val(currentPage);
                    loadAdminsData(currentPage, itemsPerPage);
                } else {
                    alert('Please enter a valid page number.');
                }
            }
        });

        $('.items-per-page-select').on('change', function () {
            itemsPerPage = $(this).val();
            loadAdminsData(currentPage, itemsPerPage);
        });

        $('#previousPage').on('click', function (e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                $('.page-number-input').val(currentPage);
                loadAdminsData(currentPage, itemsPerPage);
            }
        });

        $('#nextPage').on('click', function (e) {
            e.preventDefault();
            currentPage++;
            $('.page-number-input').val(currentPage);
            loadAdminsData(currentPage, itemsPerPage);
        });


        $('#searchButton').on('click', function () {
            currentPage = 1;
            var filters = {
                username: $('#username').val(),
                adminType: $('#adminType').val(),
                page: 1,
                limit: itemsPerPage
            };
            loadAdmin(filters);
        });

        $('#addButton').click(function() {
            openAddAdminDialog();
        });

        $('#deleteSelectedButton').click(function() {
            var selectedChecks = $('.item-check:checked');
            if (selectedChecks.length === 0) {
                alert('Please select at least one record to delete.');
                return;
            }
            var adminIds = selectedChecks.map(function () {
                return $(this).data('id');
            }).get().join(',');

            deleteAdmin(adminIds);
        });


        $(document).on('click', '.checkAll', function() {
            $('.item-check').prop('checked', this.checked);
        });

        $(document).on('change', '.item-check', function() {
            if ($('.item-check').length === $('.item-check:checked').length) {
                $('.checkAll').prop('checked', true);
            } else {
                $('.checkAll').prop('checked', false);
            }
        });

        $(document).on('click', '.editButton', function () {
            var adminId = $(this).closest('tr').find('.item-check').data('id');
            openEditDialog(adminId);
        });

        //Make sure the click event is only bound once.
        $(document).off('click', '.deleteButton').on('click', '.deleteButton', function () {
            var adminId = $(this).closest('tr').find('.item-check').data('id');
            deleteAdmin(adminId);
        });

        $('#MultifunctionModal').on('hidden.bs.modal', function () {
            loadAdminsData(currentPage, itemsPerPage);
        });

        function deleteAdmin(bookId) {
            if (confirm('Are you sure you want to delete it?')) {
                deleteAdminsByIds(bookId);
            }
        }

        function deleteAdminsByIds(ids) {
            $.ajax({
                url: "deleteAdminByIds",
                type: "POST",
                data: { ids: ids },
                success: function(result) {
                    if (result.code === 0) {
                        alert('Successfully deleted');
                        loadAdminsData(currentPage, itemsPerPage);
                    } else {
                        alert("Failed to delete");
                    }
                },
                error: function(xhr, textStatus, errorThrown) {
                    alert('Error: ' + textStatus + ' - ' + errorThrown);
                }
            });
        }
    });
</script>

</body>
</html>
