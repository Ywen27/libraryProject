<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Lend book</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-4">
    <div class="form-group">
        <label for="name" class="required">Book name</label>
        <input type="text" class="form-control" id="name" name="name" autocomplete="off">
        <small id="nameHelp" class="form-text text-muted">Please enter the name of the book to perform a search.</small>
        <button class="btn btn-primary" id="searchBook">Search</button>
    </div>
    <div class="form-group">
        <label class="required">Book list</label>
        <div class="table-responsive">
            <table class="table" id="booksTable">
                <thead>
                <tr>
                    <th scope="col"><input type="checkbox" class="checkAll"></th>
                    <th scope="col">ISBN</th>
                    <th scope="col">Type</th>
                    <th scope="col">Name</th>
                    <th scope="col">Author</th>
                    <th scope="col">Price</th>
                    <th scope="col">Language</th>
                </tr>
                </thead>
                <tbody>
                <!-- Les lignes du tableau seront ajoutées ici par jQuery -->
                </tbody>
            </table>
        </div>
    </div>
    <div class="form-group">
        <label for="readerNumber" class="required">Reader No.</label>
        <input type="text" class="form-control" id="readerNumber" name="readerNumber" placeholder="Please enter the reader No." required>
    </div>
    <button class="btn btn-primary" id="lendBook">Lend book</button>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function fetchBooks(filters = {}) {
        $.ajax({
            url: '${pageContext.request.contextPath}/bookAll',
            type: 'GET',
            data: filters,
            success: function(response) {
                $('#booksTable tbody').empty();
                response.data.forEach(function(book) {
                    var checkboxCell = book.status === 1 ? '' : '<input type="checkbox" class="item-check" data-id="' + book.id + '">';
                    var row = '<tr>' +
                        '<td>' + checkboxCell + '</td>' +
                        '<td>' + book.isbn + '</td>' +
                        '<td>' + book.typeInfo.name + '</td>' +
                        '<td>' + book.name + '</td>' +
                        '<td>' + book.author + '</td>' +
                        '<td>' + book.price + '</td>' +
                        '<td>' + book.language + '</td>' +
                        '</tr>';
                    $('#booksTable tbody').append(row);
                });
            },
            error: function(xhr, status, error) {
                console.error("Erreur lors de la récupération des livres: ", error);
            }
        });
    }
    function loadAvailableBooksData() {
        var filters = {
            name: $('#name').val(),
        };
        fetchBooks(filters);
    }

    function lendBook(datas) {
        $.ajax({
            url: "addLend",
            type: "POST",
            data: datas,
            success: function(result) {
                if (result.code == 0) {
                    alert('Lending book successfully');
                    parent.$('#MultifunctionModal').modal('hide');
                } else {
                    alert(result.msg);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error when borrowing : ", error);
            }
        });
    }

    $(document).ready(function() {
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


        $('#searchBook').click(function() {
            var name = $('#name').val().trim();
            if(name === '') {
                $('#nameHelp').text('Please enter the name of the book to perform a search.');
                $('#booksTable tbody').empty();
            } else {
                $('#nameHelp').text('Uncheckable books are unavailable.');
                loadAvailableBooksData();
            }
        });


        $('#lendBook').click(function(e) {
            e.preventDefault();
            var selectedChecks = $('.item-check:checked');
            if (selectedChecks.length === 0) {
                alert('Please select at least one book to lend.');
                return;
            }
            var ids = selectedChecks.map(function () {
                return $(this).data('id');
            }).get().join(',');

            var data = {
                ids: ids,
                readerNumber: $('#readerNumber').val(),
            };

            lendBook(data);
        });
    });
</script>
</body>
</html>
