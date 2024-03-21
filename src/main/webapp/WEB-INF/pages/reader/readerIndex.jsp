<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Reader</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col">
            <h2>Reader</h2>
            <div class="form-row mb-3">
                <div class="col">
                    <input type="text" class="form-control" placeholder="Reader No." id="readerNumber">
                </div>
                <div class="col">
                    <input type="text" class="form-control" placeholder="Username" id="username">
                </div>
                <div class="col">
                    <input type="text" class="form-control" placeholder="Real Name" id="realName">
                </div>
                <div class="col">
                    <input type="text" class="form-control" placeholder="Telephone" id="tel">
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-secondary" type="button" id="searchButton">Search</button>
                </div>
            </div>
            <div class="btn-group mb-3" role="group">
                <button type="button" class="btn btn-primary mr-2" id="addButton">Add</button>
                <button type="button" class="btn btn-danger" id="deleteSelectedButton">Delete</button>
            </div>
            <table class="table" id="readersTable">
                <thead>
                <tr>
                    <th scope="col"><input type="checkbox" class="checkAll"></th>
                    <th scope="col">Reader No.</th>
                    <th scope="col">Username</th>
                    <th scope="col">Real Name</th>
                    <th scope="col">Sex</th>
                    <th scope="col">Telephone</th>
                    <th scope="col">Register Date</th>
                    <th scope="col">Email</th>
                    <th scope="col">Operations</th>
                </tr>
                </thead>
                <tbody>
                <!-- Data will be added here dynamically -->
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
    // Load books into the table
    function loadReaders(filters = {}) {
        $.ajax({
            url: '${pageContext.request.contextPath}/readerAll',
            type: 'GET',
            data: filters,
            success: function(response) {
                $('#readersTable tbody').empty();
                if (response.data.length === 0) {
                    $('#noDataMessage').show();
                } else {
                    $('#noDataMessage').hide();
                    response.data.forEach(function(reader) {
                        var operationButtons = '<a href="#" class="btn btn-info btn-sm editButton" style="margin-bottom: 5px;">' +
                            'Modify</a> ' + '&nbsp;&nbsp' + '<a href="#" ' +
                            'class="btn btn-danger btn-sm deleteButton">Delete</a>'
                        var row = '<tr>' +
                            '<td><input type="checkbox" class="item-check" data-id="' + reader.id + '"></td>' +
                            '<td>' + reader.readerNumber + '</td>' +
                            '<td>' + reader.username + '</td>' +
                            '<td class="text-truncate2"><a href="javascript:void(0);" class="reader-info" data-reader-id="' + reader.id + '">' + reader.realName + '</td>' +
                            '<td>' + reader.sex + '</td>' +
                            '<td>' + reader.tel + '</td>' +
                            '<td>' + new Date(reader.registerDate).toLocaleString() + '</td>' +
                            '<td>' + reader.email + '</td>' +
                            '<td>'+ operationButtons +'</td>' +
                            '</tr>';
                        $('#readersTable tbody').append(row);
                    });
                }

            },
            error: function(xhr, status, error) {
                console.error("Error loading readers: ", error);
            }
        });
    }

    function loadReadersData(page, limit) {
        var filters = {
            readerNumber: $('#readerNumber').val(),
            username: $('#username').val(),
            realName: $('#realName').val(),
            tel: $('#tel').val(),
            pageNum: page,
            limit: limit
        };
        loadReaders(filters);
    }

    function openAddReaderDialog() {
        var url = '${pageContext.request.contextPath}/readerAdd';
        $('#MultifunctionModalLabel').text('Add Reader');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }


    function openLendingTimelineDialog(id) {
        var url = '${pageContext.request.contextPath}/queryLookBookList?id=' + id + '&flag=' + 'reader';
        $('#MultifunctionModalLabel').text('Timeline query');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    function openModifyDialog(readerId) {
        var url = '${pageContext.request.contextPath}/queryReaderInfoById?id='+readerId;
        $('#MultifunctionModalLabel').text('Modify Reader info');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }
    $(document).ready(function() {
        var currentPage = 1;
        var itemsPerPage = 10;
        loadReadersData(currentPage, itemsPerPage);
        $('#readerNumber, #username, #realName, #tel').on('input', function() {
            var allFieldsEmpty = $('#readerNumber').val().trim() === '' &&
                $('#username').val().trim() === '' &&
                $('#realName').val().trim() === ''&&
                $('#tel').val().trim() === '';

            if(allFieldsEmpty) {
                loadReadersData(currentPage, itemsPerPage);
            }
        });

        $('.go-to-page-btn').on('click', function () {
            var pageNumber = $('.page-number-input').val();
            if (pageNumber) {
                pageNumber = parseInt(pageNumber, 10);
                if (pageNumber > 0) {
                    currentPage = pageNumber;
                    $('.page-number-input').val(currentPage);
                    loadReadersData(currentPage, itemsPerPage);
                } else {
                    alert('Please enter a valid page number.');
                }
            }
        });

        $('.items-per-page-select').on('change', function () {
            itemsPerPage = $(this).val();
            loadReadersData(currentPage, itemsPerPage);
        });

        $('#previousPage').on('click', function (e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                $('.page-number-input').val(currentPage);
                loadReadersData(currentPage, itemsPerPage);
            }
        });

        $('#nextPage').on('click', function (e) {
            e.preventDefault();
            currentPage++;
            $('.page-number-input').val(currentPage);
            loadReadersData(currentPage, itemsPerPage);
        });

        $('#searchButton').click(function() {
            currentPage = 1;
            var filters = {
                readerNumber: $('#readerNumber').val(),
                username: $('#username').val(),
                realName: $('#realName').val(),
                tel: $('#tel').val(),
                pageNum: 1,
                limit: itemsPerPage
            };
            loadReadersData(filters);
        });

        $('#addButton').click(function() {
            openAddReaderDialog();
        });

        $('#deleteSelectedButton').click(function() {
            var selectedChecks = $('.item-check:checked');
            if (selectedChecks.length === 0) {
                alert('Please select at least one record to delete.');
                return;
            }
            var ReaderIds = selectedChecks.map(function () {
                return $(this).data('id');
            }).get().join(',');

            deleteReader(ReaderIds);
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

        $(document).on('click', '.reader-info', function () {
            var readerId = $(this).data('reader-id');
            openLendingTimelineDialog(readerId);
        });

        $(document).on('click', '.editButton', function () {
            var readerId = $(this).closest('tr').find('.item-check').data('id');
            openModifyDialog(readerId);
        });

        //Make sure the click event is only bound once.
        $(document).off('click', '.deleteButton').on('click', '.deleteButton', function () {
            var readerId = $(this).closest('tr').find('.item-check').data('id');
            deleteReader(readerId);
        });

        $('#MultifunctionModal').on('hidden.bs.modal', function () {
            loadReadersData(currentPage, itemsPerPage);
        });

        function deleteReader(bookId) {
            if (confirm('Are you sure you want to delete it?')) {
                deleteReaderByIds(bookId);
            }
        }

        function deleteReaderByIds(ids) {
            $.ajax({
                url: "deleteReader",
                type: "POST",
                data: { ids: ids },
                success: function(result) {
                    if (result.code === 0) {
                        alert('Successfully deleted');
                        loadReadersData(currentPage, itemsPerPage);
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
