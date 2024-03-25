<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Type</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col">
            <h2>Book Type</h2>
            <div class="form-row mb-3">
                <div class="col">
                    <input type="text" id="typeName" class="form-control" placeholder="Book type name">
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-secondary" type="button" id="searchButton">Search</button>
                </div>
            </div>
            <div class="btn-group mb-3" role="group">
                <button type="button" class="btn btn-primary mr-2" id="addButton">Add</button>
                <button type="button" class="btn btn-danger" id="deleteSelectedButton">Delete</button>
            </div>
            <table class="table" id="bookTypesTable">
                <thead>
                <tr>
                    <th scope="col"><input type="checkbox" class="checkAll"></th>
                    <th scope="col">Type Name</th>
                    <th scope="col">Description</th>
                    <th scope="col">Operations</th>
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
    function loadBookTypes(filters={}) {
        $.ajax({
            url: '${pageContext.request.contextPath}/typeAll',
            type: 'GET',
            data:filters,
            success: function(response) {
                $('#bookTypesTable tbody').empty();
                if (response.data.length === 0) {
                    $('#noDataMessage').show();
                } else {
                    $('#noDataMessage').hide();
                    response.data.forEach(function(item) {
                        var row = '<tr>' +
                            '<td><input type="checkbox" class="item-check" data-id="' + item.id + '"></td>' +
                            '<td>' + item.name + '</td>' +
                            '<td class="text-truncate2">' + item.remarks + '</td>' +
                            '<td>' +
                            '<button class="btn btn-sm btn-info editButton">Edit</button> ' +
                            '<button class="btn btn-sm btn-danger deleteButton">Delete</button>' +
                            '</td>' +
                            '</tr>';
                        $('#bookTypesTable tbody').append(row);
                        ;
                    });
                }
            },
            error: function(xhr, status, error) {
                console.error("Failed to load book types:", error);
            }
        });
    }
    function loadBookTypesData(page, limit) {
        var filters = {
            name: $('#typeName').val(),
            pageNum: page,
            limit: limit
        };
        loadBookTypes(filters);
    }

    function openAddBookTypeDialog() {
        var url = '${pageContext.request.contextPath}/typeAdd';
        $('#MultifunctionModalLabel').text('Add Book Type');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    function openEditDialog(bookTypeId) {
        var url = '${pageContext.request.contextPath}/queryTypeInfoById?id='+bookTypeId;
        $('#MultifunctionModalLabel').text('Modify book type info');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    $(document).ready(function() {
        var currentPage = 1;
        var itemsPerPage = 10;
        loadBookTypesData(currentPage, itemsPerPage);
        $('#typeName').on('input', function() {
            var allFieldsEmpty = $('#typeName').val().trim() === '';

            if(allFieldsEmpty) {
                loadBookTypesData(currentPage, itemsPerPage);
            }
        });

        $('.go-to-page-btn').on('click', function () {
            var pageNumber = $('.page-number-input').val();
            if (pageNumber) {
                pageNumber = parseInt(pageNumber, 10);
                if (pageNumber > 0) {
                    currentPage = pageNumber;
                    $('.page-number-input').val(currentPage);
                    loadBookTypesData(currentPage, itemsPerPage);
                } else {
                    alert('Please enter a valid page number.');
                }
            }
        });

        $('.items-per-page-select').on('change', function () {
            itemsPerPage = $(this).val();
            loadBookTypesData(currentPage, itemsPerPage);
        });

        $('#previousPage').on('click', function (e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                $('.page-number-input').val(currentPage);
                loadBookTypesData(currentPage, itemsPerPage);
            }
        });

        $('#nextPage').on('click', function (e) {
            e.preventDefault();
            currentPage++;
            $('.page-number-input').val(currentPage);
            loadBookTypesData(currentPage, itemsPerPage);
        });

        $('#searchButton').click(function() {
            currentPage = 1;
            var filters = {
                name: $('#typeName').val(),
                pageNum: 1,
                limit: itemsPerPage
            };
            loadBookTypes(filters);
        });

        $('#addButton').click(function() {
            openAddBookTypeDialog()
        });

        $('#deleteSelectedButton').click(function() {
            var selectedChecks = $('.item-check:checked');
            if (selectedChecks.length === 0) {
                alert('Please select at least one record to delete.');
                return;
            }
            var bookTypeIds = selectedChecks.map(function () {
                return $(this).data('id');
            }).get().join(',');

            deleteBookType(bookTypeIds);
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
            var bookTypeId = $(this).closest('tr').find('.item-check').data('id');
            openEditDialog(bookTypeId);
        });

        //Make sure the click event is only bound once.
        $(document).off('click', '.deleteButton').on('click', '.deleteButton', function () {
            var bookTypeId = $(this).closest('tr').find('.item-check').data('id');
            deleteBookType(bookTypeId);
        });

        $('#MultifunctionModal').on('hidden.bs.modal', function () {
            loadBookTypesData(currentPage, itemsPerPage);
        });

        function deleteBookType(bookId) {
            if (confirm('Are you sure you want to delete it?')) {
                deleteBookTypeByIds(bookId);
            }
        }

        function deleteBookTypeByIds(ids) {
            $.ajax({
                url: "deleteType",
                type: "POST",
                data: { ids: ids },
                success: function(result) {
                    if (result.code === 0) {
                        alert('Successfully deleted');
                        loadBookTypesData(currentPage, itemsPerPage);
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

