<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Announcement</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="container mt-3">
    <div class="row">
        <div class="col">
            <h2>Announcement</h2>
            <div class="form-row mb-3">
                <div class="col">
                    <input type="text" class="form-control" placeholder="Announcement topic" id="topic" aria-label="Announcement topic">
                </div>
                <div class="icol-auto">
                    <button class="btn btn-outline-secondary" type="button" id="searchButton">Search</button>
                </div>
            </div>

            <div class="mb-3">
                <button class="btn btn-primary mr-2" type="button" id="addButton">Announce</button>
                <button class="btn btn-danger" type="button" id="deleteSelectedButton">Delete</button>
            </div>

            <table class="table" id="announcementTable">
                <thead>
                <tr>
                    <th scope="col"><input type="checkbox" id="checkAll"></th>
                    <th scope="col">Topic</th>
                    <th scope="col">Content</th>
                    <th scope="col">Announcer</th>
                    <th scope="col">Release time</th>
                    <th scope="col">Operation</th>
                </tr>
                </thead>
                <tbody>
                <!-- Table rows will be added here -->
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
    function loadAnnouncements(filters={}) {
        $.ajax({
            url: '${pageContext.request.contextPath}/noticeAll',
            type: 'GET',
            data: filters,
            success: function(response) {
                $('#announcementTable tbody').empty();
                if (response.data.length === 0) {
                    $('#noDataMessage').show();
                } else {
                    $('#noDataMessage').hide();
                    response.data.forEach(function(item) {
                        var row = '<tr>' +
                            '<td><input type="checkbox" class="item-check" data-id="' + item.id + '"></td>' +
                            '<td>' + item.topic + '</td>' +
                            '<td class="text-truncate2">' + item.content + '</td>' +
                            '<td>' + item.author + '</td>' +
                            '<td>' + item.createDate + '</td>' +
                            '<td>' +
                            '<button class="btn btn-sm btn-info editButton" style="margin-bottom: 5px;">Detail</button> ' +
                            '<button class="btn btn-sm btn-danger deleteButton">Delete</button>' +
                            '</td>' +
                            '</tr>';
                        $('#announcementTable tbody').append(row);
                    });
                }

            },
            error: function(xhr, status, error) {
                console.error("Failed to load announcements:", error);
            }
        });
    }
    function loadNoticesData(page, limit) {
        var filters = {
            topic: $('#topic').val(),
            pageNum: page,
            limit: limit
        };
        loadAnnouncements(filters);
    }

    function openAddNoticeDialog() {
        var url = '${pageContext.request.contextPath}/noticeAdd';
        $('#MultifunctionModalLabel').text('Add notice');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    function openEditDialog(noticeId) {
        var url = '${pageContext.request.contextPath}/queryNoticeById?id='+noticeId;
        $('#MultifunctionModalLabel').text('Notice info');
        $('#MultifunctionModal .modal-body').html('<iframe src="' + url + '" style="width:100%;height:100%;"></iframe>');
        $('#MultifunctionModal').modal('show');
    }

    $(document).ready(function() {
        var currentPage = 1;
        var itemsPerPage = 10;
        loadNoticesData(currentPage, itemsPerPage);
        $('#topic').on('input', function() {
            var allFieldsEmpty = $('#topic').val().trim() === '';

            if(allFieldsEmpty) {
                loadNoticesData(currentPage, itemsPerPage);
            }
        });

        $('.go-to-page-btn').on('click', function () {
            var pageNumber = $('.page-number-input').val();
            if (pageNumber) {
                pageNumber = parseInt(pageNumber, 10);
                if (pageNumber > 0) {
                    currentPage = pageNumber;
                    $('.page-number-input').val(currentPage);
                    loadNoticesData(currentPage, itemsPerPage);
                } else {
                    alert('Please enter a valid page number.');
                }
            }
        });

        $('.items-per-page-select').on('change', function () {
            itemsPerPage = $(this).val();
            loadNoticesData(currentPage, itemsPerPage);
        });

        $('#previousPage').on('click', function (e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                $('.page-number-input').val(currentPage);
                loadNoticesData(currentPage, itemsPerPage);
            }
        });

        $('#nextPage').on('click', function (e) {
            e.preventDefault();
            currentPage++;
            $('.page-number-input').val(currentPage);
            loadNoticesData(currentPage, itemsPerPage);
        });

        $('#searchButton').click(function() {
            currentPage = 1;
            var filters = {
                name: $('#typeName').val(),
                pageNum: 1,
                limit: itemsPerPage
            };
            loadNoticesData(filters);
        });

        $('#addButton').click(function() {
            openAddNoticeDialog()
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

            deleteNotice(bookTypeIds);
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
            var noticeId = $(this).closest('tr').find('.item-check').data('id');
            openEditDialog(noticeId);
        });

        //Make sure the click event is only bound once.
        $(document).off('click', '.deleteButton').on('click', '.deleteButton', function () {
            var noticeId = $(this).closest('tr').find('.item-check').data('id');
            deleteNotice(noticeId);
        });

        $('#MultifunctionModal').on('hidden.bs.modal', function () {
            loadNoticesData(currentPage, itemsPerPage);
        });

        function deleteNotice(bookId) {
            if (confirm('Are you sure you want to delete it?')) {
                deleteNoticeByIds(bookId);
            }
        }

        function deleteNoticeByIds(ids) {
            $.ajax({
                url: "deleteNoticeByIds",
                type: "POST",
                data: { ids: ids },
                success: function(result) {
                    if (result.code === 0) {
                        alert('Successfully deleted');
                        loadNoticesData(currentPage, itemsPerPage);
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
