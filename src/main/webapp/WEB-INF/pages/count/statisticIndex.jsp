<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <head>
        <title>Statistical Data</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    </head>
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-body">
                    <div id="main" style="width: 100%; height: 500px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        var myChart = echarts.init(document.getElementById('main'));

        var option = {
            series : [
                {
                    name: 'Visit Source',
                    type: 'pie',
                    radius: '55%',
                    data:[
                        <c:forEach items="${list}" var="type">
                        { value: ${type.counts}, name: '${type.name}' },
                        </c:forEach>
                    ],
                    roseType: 'angle',
                    itemStyle: {
                        normal: {
                            shadowBlur: 200,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        myChart.setOption(option);
    });
</script>
</body>
</html>
