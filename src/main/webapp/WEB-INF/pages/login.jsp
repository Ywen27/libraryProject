<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management System</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="icon" href="${pageContext.request.contextPath}/images/logo.ico">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: url("${pageContext.request.contextPath}/images/loginbg.jpg") no-repeat center center fixed;
            background-size: cover;
        }
        .captcha-img {
            cursor: pointer;
            height: 38px;
        }
        .card {
            opacity: 0.9;
            width: 30rem; border-radius: 10px; box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
        }

        .password-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 2;
        }
        .password-icon:hover {
            color: #007bff;
        }
        input:focus + .password-icon {
            visibility: visible;
            z-index: 100;
        }
    </style>
</head>
<body>
<div class="loading-screen" id="loadingScreen" style="display:none;">
    <img id="loadingGif" src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading...">
</div>
<div class="container h-100 d-flex justify-content-center align-items-center">
    <div class="card">
        <div class="card-body">
            <h3 class="card-title text-center">Library Management System</h3>
            <form action="${pageContext.request.contextPath}/loginIn" method="post">
                <!-- Error message -->
                <div style="color: red; text-align: center;">${msg}</div>

                <!-- User type selection -->
                <div class="form-group form-group-centered">
                    <label for="userType">Log in as</label>
                    <div class="binary-switch" onclick="toggleUserType()">
                        <div class="binary-slider">
                            <span id="userTypeAdmin">Admin</span>
                            <span id="userTypeReader">Reader</span>
                        </div>
                    </div>
                    <input type="hidden" name="type" id="userType" value="2"> <!-- Default to Reader -->
                </div>

                <!-- Username field -->
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="bi bi-person-fill"></i>
                        </span>
                    </div>
                    <input type="text" class="form-control" name="username" id="username" placeholder="Username" required>
                </div>

                <!-- Password field -->
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="bi bi-lock-fill"></i>
                        </span>
                    </div>
                    <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
                    <i class="bi bi-eye-fill password-icon" id="togglePasswordVisibility"></i>
                </div>

                <!-- Captcha field -->
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="bi bi-shield-lock-fill"></i>
                        </span>
                    </div>
                    <input type="text" class="form-control" name="captcha" id="captcha" placeholder="Enter verification code" required>
                    <img id="code" class="captcha-img ml-2" alt="captcha" onclick="getCode()">
                </div>

                <!-- Login button -->
                <button type="submit" class="btn btn-block btn-primary shadow-sm" style="background-color: #4A90E2; border-radius: 0.25rem;">
                    Log in <i class="bi bi-box-arrow-in-right ml-2"></i>
                </button>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function getCode() {
        var src = timestamp("${pageContext.request.contextPath}/verifyCode");
        $("#code").attr("src", src);
    }
    // Function to add a timestamp to the URL (cache busting)
    function timestamp(url) {
        var time = new Date().getTime();
        return url + (url.indexOf("?") > -1 ? "&" : "?") + "timestamp=" + time;
    }

    function toggleUserType() {
        var switchElement = document.querySelector('.binary-switch');
        var userTypeInput = document.getElementById('userType');
        if (userTypeInput.value === '2') {
            userTypeInput.value = '1';
        } else {
            userTypeInput.value = '2';
        }
        switchElement.classList.toggle('active');
    }

    $(document).ready(function() {
        getCode(); // Initial call to load the captcha

        $('#userTypeSwitch').change(function() {
            if ($(this).is(':checked')) {
                $('#userType').val('1'); // Admin
            } else {
                $('#userType').val('2'); // Reader
            }
        });

        $('#togglePasswordVisibility').click(function() {
            var passwordInput = $("#password");
            if (passwordInput.attr("type") === "password") {
                passwordInput.attr("type", "text");
                $(this).removeClass('bi-eye-fill').addClass('bi-eye-slash-fill');
            } else {
                passwordInput.attr("type", "password");
                $(this).removeClass('bi-eye-slash-fill').addClass('bi-eye-fill');
            }
        });

        // Handle form submission with validation
        $("form").submit(function(event) {
            var username = $("input[name='username']").val();
            var password = $("input[name='password']").val();
            var captcha = $("input[name='captcha']").val();
            var type = $("input[name='type']").val();

            // Basic validation
            if (username === '') {
                alert('Username can not be empty');
                event.preventDefault(); // Prevent form submission
                return false;
            }
            if (password === '') {
                alert('Password can not be empty');
                event.preventDefault(); // Prevent form submission
                return false;
            }
            if (captcha === '') {
                alert('Verification code must be filled');
                event.preventDefault(); // Prevent form submission
                return false;
            }
            if (type === '') {
                alert('Type cannot be empty');
                event.preventDefault(); // Prevent form submission
                return false;
            }
            $("#loadingScreen").fadeIn();
        });
    });
</script>

</body>
</html>