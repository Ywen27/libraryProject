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
      <table class="table" id="booksTable">
        <thead>
        <tr>
          <th scope="col">ISBN</th>
          <th scope="col">Name</th>
          <th scope="col">Type</th>
          <th scope="col">Author</th>
          <th scope="col">Price</th>
          <th scope="col">Language</th>
          <th scope="col">Status</th>
          <th scope="col">Operation</th>
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

<div class="modal fade" id="BookModal" tabindex="-1" role="dialog" aria-labelledby="BookLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content custom-modal-height">
      <div class="modal-header">
        <h5 class="modal-title" id="BookModalLabel"></h5>
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
            var operationButtons = '<button class="btn btn-info detailButton" data-toggle="modal" data-target="#BookModal" ' +
                    'data-isbn="' + book.isbn + '" ' +
                    'data-name="' + book.name + '" ' +
                    'data-type="' + book.typeInfo.name + '" ' +
                    'data-author="' + book.author + '" ' +
                    'data-publish="' + book.publish + '" ' +
                    'data-publishdate="' + book.publishDate + '" ' +
                    'data-price="' + book.price + '" ' +
                    'data-language="' + book.language + '" ' +
                    'data-introduction="' + book.introduction + '">Detail</button>';
            var bookStatusClass = book.status == 1 ? 'badge badge-danger' : 'badge badge-success';
            var bookStatus = '<span class="' + bookStatusClass + '">' + (book.status == 1 ? 'Unavailable' : 'Available') + '</span>';
            var row = '<tr>' +
                    '<td>' + book.isbn + '</td>' +
                    '<td class="text-truncate2">' + book.name + '</td>' +
                    '<td>' + book.typeInfo.name + '</td>' +
                    '<td class="text-truncate2">' + book.author + '</td>' +
                    '<td>' + book.price + '</td>' +
                    '<td>' + book.language + '</td>' +
                    '<td>' + bookStatus + '</td>' +
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

    $(document).off('click', '.detailButton').on('click', '.detailButton', function () {
      var isbn = $(this).data('isbn');
      var name = $(this).data('name');
      var type = $(this).data('type');
      var author = $(this).data('author');
      var publishHouse = $(this).data('publish');
      var publishDate = $(this).data('publishdate');
      var price = $(this).data('price');
      var language = $(this).data('language');
      var introduction = $(this).data('introduction');

      var date = new Date(parseInt(publishDate, 10));
      var formattedDate = date.toISOString().split('T')[0];

      var modalContent = '<div class="card">' +
              '<div class="card-header">' + name + '</div>' +
              '<div class="card-body">' +
              '<h5 class="card-title">Details</h5>' +
              '<p class="card-text"><strong>ISBN:</strong> ' + isbn + '</p>' +
              '<p class="card-text"><strong>Type:</strong> ' + type + '</p>' +
              '<p class="card-text"><strong>Author:</strong> ' + author + '</p>' +
              '<p class="card-text"><strong>Publishing House:</strong> ' + publishHouse + '</p>' +
              '<p class="card-text"><strong>Publish Date:</strong> ' + formattedDate + '</p>' +
              '<p class="card-text"><strong>Price:</strong> ' + price + '</p>' +
              '<p class="card-text"><strong>Language:</strong> ' + language + '</p>' +
              '<p class="card-text"><strong>Introduction:</strong> ' + introduction + '</p>' +
              '</div>' +
              '</div>';

      $('#BookModal .modal-body').html(modalContent);
      $('#BookModalLabel').text('Book Details');
    });

  });
</script>

</body>
</html>
