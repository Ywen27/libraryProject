<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="${pageContext.request.contextPath}/images/logo.ico">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        body {padding-top: 60px;}
    </style>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <a class="navbar-brand" href="#">
        <img id="logo" src="${pageContext.request.contextPath}/images/logo.ico" alt="Library Logo" style="height:30px; margin-right: 10px;">
        Library
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarContent">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link refresh" href="javascript:;">
                    <i class="bi bi-arrow-clockwise"></i>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link cleanUp" href="javascript:;">
                    <i class="bi bi-trash"></i>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link full" href="javascript:;" d>
                    <i class="bi bi-arrows-fullscreen"></i>
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="userSettingsDropdown" role="button" data-toggle="dropdown" aria-expanded="false">
                    <span style="color: #BBBBBB">${sessionScope.user.username}</span>
                </a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userSettingsDropdown">
                    <a class="dropdown-item" href="javascript:;" id="pwd"><i class="bi bi-key-fill mr-2"></i>Change Password</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item loginOut" href="javascript:;"><i class="bi bi-box-arrow-right mr-2"></i>Logout</a>
                </div>
            </li>
        </ul>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar Navigation -->
        <nav class="col-12 col-md-3 col-lg-2 d-md-block sidebar">
            <div class="sidebar-sticky bg-dark">
                <ul id="sidebarMenu" class="nav flex-column">
                    <!-- Sidebar content -->
                </ul>
            </div>
        </nav>
        <!-- Main Content -->
        <main role="main" class="col-12 col-md-9 ml-sm-auto col-lg-10 px-md-4">
            <!-- Content goes here -->
        </main>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script>
    $(document).ready(function () {
        var iniUrl = '';
        var readerId;
        <c:choose>
        <c:when test="${sessionScope.type.equals('reader')}">
        iniUrl = '${pageContext.request.contextPath}/api/init2.json';
        readerId = ${sessionScope.readerId};
        </c:when>
        <c:when test="${sessionScope.type.equals('admin') && sessionScope.adminType == 1}">
        iniUrl = '${pageContext.request.contextPath}/api/init.json';
        </c:when>
        <c:when test="${sessionScope.type.equals('admin') && sessionScope.adminType == 0}">
        iniUrl = '${pageContext.request.contextPath}/api/init1.json';
        </c:when>
        </c:choose>

        function buildMenu(menuItems) {
            var html = '';
            menuItems.forEach(function (item, index) {
                var itemId = 'dropdown' + item.title.replace(/\s+/g, '') + index;
                if (item.child && item.child.length > 0) {
                    html += '<li class="active">';
                    html += '<a href="#' + itemId + '" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">';
                    html += '<i class="' + item.icon + '"></i> ' + item.title + '</a>';
                    html += '<ul class="collapse list-unstyled" id="' + itemId + '">';
                    item.child.forEach(function (childItem) {
                        html += '<li>';
                        html += '<a href="' + childItem.href + '" class="sidebar-link"><i class="' + childItem.icon + '"></i>';
                        html +=  childItem.title + '</a>';
                        html += '</li>';
                    });
                    html += '</ul>';
                    html += '</li>';
                } else {
                    html += '<li>';
                    html += '<a href="' + item.href + '" class="sidebar-link"><i class="' + item.icon + '"></i>'
                        + item.title + '</a>';
                    html += '</li>';
                }
            });
            return html;
        }

        if (iniUrl !== '') {
            $.getJSON(iniUrl, function (data) {
                var logoInfo = data.logoInfo;
                var homeHref = data.homeInfo.href;
                var menuHtml = buildMenu(data.menuInfo);

                if (logoInfo) {
                    var logoHtml = '<img id="logo" src="' + logoInfo.image + '" alt="Library Logo" style="height:30px; margin-right: 10px;">'
                        + logoInfo.title;
                    $('.navbar-brand').html(logoHtml);
                }

                $('.navbar-brand').on('click', function(e) {
                    e.preventDefault();
                    $('main').load(homeHref);
                });

                $('#sidebarMenu').html(menuHtml);
                $('.sidebar-link').on('click', function(e) {
                    e.preventDefault();
                    var pageUrl = $(this).attr('href');
                    $('main').load(pageUrl);
                });

                $('main').load(homeHref);
            });
        }

        $('#pwd').on('click', function(e) {
            e.preventDefault();
            $('main').load('${pageContext.request.contextPath}/updatePassword');
        });

        $('.refresh').on('click', function() {
            window.location.reload();
        });

        $('.cleanUp').on('click', function() {
            window.location.reload(true);
            alert("Cache deleted successfully");
        });

        $('.full').on('click', function() {
            if (!document.fullscreenElement) {
                document.documentElement.requestFullscreen().catch((e) => {
                    console.error(`Error attempting to enable full-screen mode: ${e.message} (${e.name})`);
                });
                $(this).find('i').removeClass('bi-arrows-fullscreen').addClass('bi-arrows-angle-contract');
            } else {
                if (document.exitFullscreen) {
                    document.exitFullscreen();
                    $(this).find('i').removeClass('bi-arrows-angle-contract').addClass('bi-arrows-fullscreen');
                }
            }
        });

        document.addEventListener('fullscreenchange', function() {
            if (!document.fullscreenElement) {
                $('.full').find('i').removeClass('bi-arrows-angle-contract').addClass('bi-arrows-fullscreen');
            }
        });



        $('.loginOut').on('click', function () {
            window.location.href = '${pageContext.request.contextPath}/loginOut';
            alert('Log out successfully.');
        });
    });
</script>
</body>
</html>



