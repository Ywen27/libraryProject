<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Lending</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>

<body>
<div class="container mt-3">
    <div class="row">
        <div class="col">
            <h2>Lending</h2>
            <div class="form-row mb-3">
                <div class="col">
                    <input type="text" class="form-control" placeholder="Reader No." id="readerNumber" autocomplete="off">
                </div>
                <div class="col">
                    <input type="text" class="form-control" placeholder="Book name" id="name" autocomplete="off">
                </div>
                <div class="col">
                    <select class="custom-select" id="type">
                        <option value="">Please select return type</option>
                        <option value="0">Normally</option>
                        <option value="1">Late</option>
                        <option value="2">Damaged</option>
                        <option value="3">Lost</option>
                    </select>
                </div>
                <div class="col">
                    <select class="custom-select" id="status">
                        <option value="">Please select book state</option>
                        <option value="0">Not lent</option>
                        <option value="1">On loan</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-secondary" type="button" id="searchButton">Search</button>
                </div>
            </div>
            <div class="btn-group mb-3" role="group" aria-label="Basic example">
                <button type="button" class="btn btn-primary mr-2" id="lendButton">Lend</button>
                <button type="button" class="btn btn-primary mr-2" id="returnButton">Return</button>
                <button type="button" class="btn btn-danger" id="deleteButton">Delete</button>
            </div>
            <table class="table" id="lendingTable">
                <thead>
                <tr>
                    <th scope="col"><input type="checkbox" class="checkAll"></th>
                    <th scope="col">Book Name</th>
                    <th scope="col">Reader No.</th>
                    <th scope="col">Lender</th>
                    <th scope="col">Lending Time</th>
                    <th scope="col">Return Time</th>
                    <th scope="col">Return Type</th>
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
    function loadTableData(filters = {}) {
        $.ajax({
            url: '${pageContext.request.contextPath}/lendListAll',
            type: 'GET',
            data: filters,
            success: function (response) {
                $('#lendingTable tbody').empty();
                if (response.data.length === 0) {
                    $('#noDataMessage').show();
                } else {
                    $('#noDataMessage').hide();
                    response.data.forEach(function (item) {
                        var operationButtons = '';
                        if (item.backDate == null) {
                            operationButtons = '<a href="#" class="btn btn-info btn-sm editButton" style="margin-bottom: 5px;">' +
                                'Abnormal return</a> ' + '&nbsp;&nbsp' + '<a href="#" ' +
                                'class="btn btn-danger btn-sm deleteButton">Delete</a>';
                        } else {
                            operationButtons = '<a href="#" class="btn btn-danger btn-sm deleteButton">Delete</a>';
                        }

                        var row = '<tr>' +
                            '<td><input type="checkbox" class="item-check" data-book-id="'+ item.bookId +'" data-id="' + item.id + '"></td>' +
                            '<td class="text-truncate2"><a href="javascript:void(0);" class="book-info" data-book-id="' + item.bookId + '">' + item.bookInfo.name + '</td>' +
                            '<td>' + item.readerInfo.readerNumber + '</td>' +
                            '<td class="text-truncate2"><a href="javascript:void(0);" class="reader-info" data-reader-id="' + item.readerId + '">' + item.readerInfo.realName + '</td>' +
                            '<td>' + formatDateTime(item.lendDate) + '</td>' +
                            '<td>' + (item.backDate ? formatDateTime(item.backDate) : '') + '</td>' +
                            '<td>' + formatBackType(item.backType) + '</td>' +
                            '<td>' + operationButtons + '</td>' +
                            '</tr>';
                        $('#lendingTable tbody').append(row);
                    });
                }
            },
            error: function (xhr, status, error) {
                console.error("Error loading table data", error);
            }
        });
    }

    function formatBackType(backType) {
        switch (backType) {
            case 0: return '<span class="badge badge-success">Normally</span>';;
            case 1: return '<span class="badge badge-secondary">Late</span>';
            case 2: return '<span class="badge badge-info">Damaged</span>';
            case 3: return '<span class="badge badge-dark">Lost</span>';
            default: return '<span class="badge badge-danger">On loan</span>';
        }
    }

    function formatDateTime(datetime) {
        if (!datetime) return '';
        var date = new Date(datetime);
        return date.toLocaleString();
    }

    function loadPageData(page, limit) {
        var filters = {
            name: $('#name').val(),
            readerNumber: $('#readerNumber').val(),
            type: $('#type').val(),
            status: $('#status').val(),
            page: page,
            limit: limit
        };
        loadTableData(filters);
    }

    function openLendBookDialog(){
        var url = '${pageContext.request.contextPath}/addLendList';
        $('#MultifunctionModalLabel').text('Lend Book');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    function openAbnormalReturnDialog(dataId, bookId) {
        var url = '${pageContext.request.contextPath}/excBackBook?id=' + dataId + '&bookId=' + bookId;
        $('#MultifunctionModalLabel').text('Abnormal Return');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    function openLendingTimelineDialog(flag, id) {
        var url = '${pageContext.request.contextPath}/queryLookBookList?id=' + id + '&flag=' + flag;
        $('#MultifunctionModalLabel').text('Timeline query');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    $(document).ready(function () {
        var currentPage = 1;
        var itemsPerPage = 10;
        loadPageData(currentPage, itemsPerPage);

        $('#readerNumber, #name, #type, #status').on('input', function() {
            var allFieldsEmpty = $('#readerNumber').val().trim() === '' &&
                $('#name').val().trim() === '' &&
                $('#type').val().trim() === '' &&
                $('#status').val().trim() === '';

            if(allFieldsEmpty) {
                loadPageData(currentPage, itemsPerPage);
            }
        });

        $('.go-to-page-btn').on('click', function () {
            var pageNumber = $('.page-number-input').val();
            if (pageNumber) {
                pageNumber = parseInt(pageNumber, 10);
                if (pageNumber > 0) {
                    currentPage = pageNumber;
                    $('.page-number-input').val(currentPage);
                    loadPageData(currentPage, itemsPerPage);
                } else {
                    alert('Please enter a valid page number.');
                }
            }
        });

        $('.items-per-page-select').on('change', function () {
            itemsPerPage = $(this).val();
            loadPageData(currentPage, itemsPerPage);
        });

        $('#previousPage').on('click', function (e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                $('.page-number-input').val(currentPage);
                loadPageData(currentPage, itemsPerPage);
            }
        });

        $('#nextPage').on('click', function (e) {
            e.preventDefault();
            currentPage++;
            $('.page-number-input').val(currentPage);
            loadPageData(currentPage, itemsPerPage);
        });


        $('#searchButton').on('click', function () {
            currentPage = 1;
            var filters = {
                name: $('#name').val(),
                readerNumber: $('#readerNumber').val(),
                type: $('#type').val(),
                status: $('#status').val(),
                page: 1,
                limit: itemsPerPage
            };
            loadTableData(filters);
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

        $('#lendButton').on('click', function () {
            var dataId = $(this).closest('tr').find('.item-check').data('id');
            var bookId = $(this).closest('tr').find('.book-info').data('book-id');
            openLendBookDialog(dataId, bookId);
        });

        $('#returnButton').on('click', function () {
            var selectedChecks = $('.item-check:checked');
            if (selectedChecks.length === 0) {
                alert('Please select at least one record to delete.');
                return;
            }
            var ids = selectedChecks.map(function () {
                return $(this).data('id');
            }).get().join(',');

            var bookIds = selectedChecks.map(function () {
                return $(this).data('book-id');
            }).get().join(',');

            returnBooksByIds(ids, bookIds);
        });

        $('#deleteButton').on('click', function () {
            var selectedChecks = $('.item-check:checked');
            if (selectedChecks.length === 0) {
                alert('Please select at least one record to delete.');
                return;
            }
            var ids = selectedChecks.map(function () {
                return $(this).data('id');
            }).get().join(',');

            var bookIds = selectedChecks.map(function () {
                return $(this).data('book-id');
            }).get().join(',');

            deleteRecord(ids, bookIds);
        });

        $(document).on('click', '.editButton', function () {
            var dataId = $(this).closest('tr').find('.item-check').data('id');
            var bookId = $(this).closest('tr').find('.book-info').data('book-id');
            openAbnormalReturnDialog(dataId, bookId);
        });

        //Make sure the click event is only bound once.
        $(document).off('click', '.deleteButton').on('click', '.deleteButton', function () {
            var dataId = $(this).closest('tr').find('.item-check').data('id');
            var bookId = $(this).closest('tr').find('.book-info').data('book-id');
            deleteRecord(dataId, bookId);
        });

        $(document).on('click', '.book-info', function () {
            var bookId = $(this).data('book-id');
            openLendingTimelineDialog('book', bookId);
        });

        $(document).on('click', '.reader-info', function () {
            var readerId = $(this).data('reader-id');
            openLendingTimelineDialog('user', readerId);
        });

        $('#MultifunctionModal').on('hidden.bs.modal', function () {
            loadPageData(currentPage, itemsPerPage);
        });

        function deleteRecord(dataId, bookId) {
            if (confirm('Are you sure you want to delete it?')) {
                deleteInfoByIds(dataId, bookId);
            }
        }

        function deleteInfoByIds(ids, bookIds) {
            $.ajax({
                url: "deleteLendListByIds",
                type: "POST",
                data: { ids: ids,bookIds: bookIds},
                success: function (result) {
                    console.log(result.code);
                    if (result.code == 0) {
                        alert('Successfully deleted');
                        loadPageData(currentPage, itemsPerPage);
                    } else {
                        alert("Failed to delete");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error deleting record:", error);
                    alert("Failed to delete. Please try again later.");
                }
            });
        }

        function returnBooksByIds(ids, bookIds) {
            $.ajax({
                url: "backLendListByIds",
                type: "POST",
                data: { ids: ids, bookIds: bookIds },
                success: function (result) {
                    if (result.code == 0) {
                        alert('Return successfully');
                        loadPageData(currentPage, itemsPerPage);
                    } else {
                        alert("Failed to return book");
                    }
                }
            });
        }


    });
</script>

</body>
</html>
