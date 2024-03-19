<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Book</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col">
            <h2>Book</h2>
            <div class="form-row mb-3">
                <div class="col">
                    <input type="text" class="form-control" placeholder="ISBN" id="isbn">
                </div>
                <div class="col">
                    <input type="text" class="form-control" placeholder="Name" id="name">
                </div>
                <div class="col">
                    <select class="custom-select" id="bookTypesSelect">
                        <option value="">Please select the book type</option>
                    </select>
                </div>
                <div class="col-auto">
                    <button class="btn btn-outline-secondary" type="button" id="searchButton">Search</button>
                </div>
            </div>
            <div class="btn-group mb-3" role="group">
                <button type="button" class="btn btn-primary mr-2" id="addButton">Add</button>
                <button type="button" class="btn btn-danger" id="deleteSelectedButton">Delete</button>
            </div>
            <table class="table" id="booksTable">
                <thead>
                <tr>
                    <th scope="col"><input type="checkbox" class="checkAll"></th>
                    <th scope="col">ISBN</th>
                    <th scope="col">Name</th>
                    <th scope="col">Type</th>
                    <th scope="col">Author</th>
                    <th scope="col">Price</th>
                    <th scope="col">Language</th>
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
    function loadBookTypes() {
        $.get("${pageContext.request.contextPath}/findAllList", function(data) {
            var select = $('#bookTypesSelect');
            $.each(data, function(index, item) {
                select.append($('<option>', {
                    value: item.id,
                    text: item.name
                }));
            });
        }, 'json');
    }

    // Load books into the table
    function loadBooks(filters = {}) {
        $.ajax({
            url: '${pageContext.request.contextPath}/bookAll',
            type: 'GET',
            data: filters,
            success: function(response) {
                $('#booksTable tbody').empty();
                if (response.data.length === 0) {
                    $('#noDataMessage').show();
                } else {
                    $('#noDataMessage').hide();
                    response.data.forEach(function(book) {
                        var operationButtons = '<a href="#" class="btn btn-info btn-sm editButton" style="margin-bottom: 5px;">' +
                            'Modify</a> ' + '&nbsp;&nbsp' + '<a href="#" ' +
                            'class="btn btn-danger btn-sm deleteButton">Delete</a>';
                        var checkboxCell = '<input type="checkbox" class="item-check" data-id="' + book.id + '">';
                        var row = '<tr>' +
                            '<td>' + checkboxCell + '</td>' +
                            '<td>' + book.isbn + '</td>' +
                            '<td class="text-truncate2"><a href="javascript:void(0);" class="book-info" data-book-id="' + book.id + '">' + book.name + '</td>' +
                            '<td>' + book.typeInfo.name + '</td>' +
                            '<td class="text-truncate2">' + book.author + '</td>' +
                            '<td>' + book.price + '</td>' +
                            '<td>' + book.language + '</td>' +
                            '<td>' + operationButtons + '</td>' +
                            '</tr>';
                        $('#booksTable tbody').append(row);
                    });
                }

            },
            error: function(xhr, status, error) {
                console.error("Error retrieving books: ", error);
            }
        });
    }

    function loadBooksData(page, limit) {
        var filters = {
            name: $('#name').val(),
            isbn: $('#isbn').val(),
            typeId: $('#bookTypesSelect').val(),
            pageNum: page,
            limit: limit
        };
        loadBooks(filters);
    }
    function openAddBookDialog() {
        var url = '${pageContext.request.contextPath}/bookAdd';
        $('#MultifunctionModalLabel').text('Add Book');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }


    function openLendingTimelineDialog(id) {
        var url = '${pageContext.request.contextPath}/queryLookBookList?id=' + id + '&flag=' + 'book';
        $('#MultifunctionModalLabel').text('Timeline query');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    function openModifyDialog(bookId) {
        var url = '${pageContext.request.contextPath}/queryBookInfoById?id='+bookId;
        $('#MultifunctionModalLabel').text('Modify book info');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    $(document).ready(function() {
        loadBookTypes();
        var currentPage = 1;
        var itemsPerPage = 10;
        loadBooksData(currentPage, itemsPerPage);
        $('#isbn, #name, #bookTypesSelect').on('input', function() {
            var allFieldsEmpty = $('#isbn').val().trim() === '' &&
                $('#name').val().trim() === '' &&
                $('#bookTypesSelect').val().trim() === '';

            if(allFieldsEmpty) {
                loadBooksData(currentPage, itemsPerPage);
            }
        });

        $('.go-to-page-btn').on('click', function () {
            var pageNumber = $('.page-number-input').val();
            if (pageNumber) {
                pageNumber = parseInt(pageNumber, 10);
                if (pageNumber > 0) {
                    currentPage = pageNumber;
                    $('.page-number-input').val(currentPage);
                    loadBooksData(currentPage, itemsPerPage);
                } else {
                    alert('Please enter a valid page number.');
                }
            }
        });

        $('.items-per-page-select').on('change', function () {
            itemsPerPage = $(this).val();
            loadBooksData(currentPage, itemsPerPage);
        });

        $('#previousPage').on('click', function (e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                $('.page-number-input').val(currentPage);
                loadBooksData(currentPage, itemsPerPage);
            }
        });

        $('#nextPage').on('click', function (e) {
            e.preventDefault();
            currentPage++;
            $('.page-number-input').val(currentPage);
            loadBooksData(currentPage, itemsPerPage);
        });

        $('#searchButton').click(function() {
            currentPage = 1;
            var filters = {
                isbn: $('#isbn').val(),
                name: $('#name').val(),
                typeId: $('#bookTypesSelect').val(),
                pageNum: 1,
                limit: itemsPerPage
            };
            loadBooks(filters);
        });

        $('#addButton').click(function() {
            openAddBookDialog();
        });

        $('#deleteSelectedButton').click(function() {
            var selectedChecks = $('.item-check:checked');
            if (selectedChecks.length === 0) {
                alert('Please select at least one record to delete.');
                return;
            }
            var bookIds = selectedChecks.map(function () {
                return $(this).data('id');
            }).get().join(',');

            deleteBook(bookIds);
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

        $(document).on('click', '.book-info', function () {
            var bookId = $(this).data('book-id');
            openLendingTimelineDialog(bookId);
        });

        $(document).on('click', '.editButton', function () {
            var bookId = $(this).closest('tr').find('.item-check').data('id');
            openModifyDialog(bookId);
        });

        //Make sure the click event is only bound once.
        $(document).off('click', '.deleteButton').on('click', '.deleteButton', function () {
            var bookId = $(this).closest('tr').find('.item-check').data('id');
            deleteBook(bookId);
        });

        $('#MultifunctionModal').on('hidden.bs.modal', function () {
            loadBooksData(currentPage, itemsPerPage);
        });

        function deleteBook(bookId) {
            if (confirm('Are you sure you want to delete it?')) {
                deleteBookByIds(bookId);
            }
        }

        function deleteBookByIds(ids) {
            $.ajax({
                url: "deleteBook",
                type: "POST",
                data: { ids: ids },
                success: function(result) {
                    if (result.code === 0) {
                        alert('Successfully deleted');
                        loadBooksData(currentPage, itemsPerPage);
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
