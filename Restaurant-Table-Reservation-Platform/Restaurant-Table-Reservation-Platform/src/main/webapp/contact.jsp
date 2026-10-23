<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link rel="icon" type="image/png" href="images/Favicon.png">
    <title>Los Pollos Hermanos - Table Reservation</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        @font-face {
            font-family: 'JI Burrito';
            src: url('${pageContext.request.contextPath}/fonts/JI Burrito.ttf') format('truetype');
        }
        @font-face {
            font-family: 'Shannon Extra Bold Regular';
            src: url('${pageContext.request.contextPath}/fonts/Shannon Extra Bold Regular.ttf') format('truetype');
        }
        body {
            font-family: 'JI Burrito', sans-serif;
            background: linear-gradient(to bottom, #FFC107, #FFD54F);
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .header-bar {
            background: #3977d6;
            padding: 1rem 0;
        }
        .zigzag {
            width: 120px;
            height: 12px;
            background: linear-gradient(45deg, transparent 45%, #FFD54F 45%, #f8c625 55%, transparent 55%),
            linear-gradient(-45deg, transparent 45%, #FFD54F 45%, #f8c625 55%, transparent 55%);
            background-size: 24px 24px;
            margin: 0 auto;
        }
        .hero-section {
            background: url('${pageContext.request.contextPath}/images/indexback2.png') no-repeat center center/cover;
            height: 100vh;
            width: 100vw;
            position: relative;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
            z-index: 0;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.0);
            z-index: 1;
        }
        .container {
            position: relative;
            z-index: 2;
        }
    </style>
</head>
<body class="text-black">
<jsp:include page="WEB-INF/views/header.jsp"/>
<div class="hero-section fade-in">
    <div class="my-20"></div>
    <div class="container mx-auto p-8 flex-grow">
        <div class="text-center mb-12 fade-in">
            <div class="zigzag mb-6"></div>
            <h1 class="text-5xl font-bold text-yellow drop-shadow-none">Contct Us</h1>
            <div class="zigzag mt-6"></div>
            <div class="my-40"></div>
            <div class="sketchfab-embed-wrapper"> <iframe title="HERMANO LOS POLOS" frameborder="0" allowfullscreen mozallowfullscreen="true" webkitallowfullscreen="true" allow="autoplay; fullscreen; xr-spatial-tracking" xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share src="https://sketchfab.com/models/c32bae401ce04b70b9cccc989e006de8/embed?autospin=1&preload=1&transparent=1&dnt=1"> </iframe> </div>
        </div>
    </div>
</div>

<jsp:include page="WEB-INF/views/footer.jsp"/>




    <script>
    tailwind.config = { theme: { extend: { colors: { 'yellow': '#FFC107', 'blue': '#3977d6', 'maroon': '#8B0000' } } } }
    </script>

</body>
</html>