<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <link rel="icon" type="image/png" href="images/Favicon.png">
    <title>Los Pollos Hermanos - Admin Panel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        @font-face {
            font-family: 'JI Burrito';
            src: url('${pageContext.request.contextPath}/fonts/JI Burrito.ttf') format('truetype');
        }
        @font-face {
            font-family: 'Shannon Extra Bold';
            src: url('${pageContext.request.contextPath}/fonts/Shannon Extra Bold Regular.ttf') format('truetype');
        }
        body {
            font-family: 'Shannon Extra Bold', sans-serif;
            background: linear-gradient(to bottom, #FFC107, #ffd54f);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }
        .header-bar {
            background: #003087;
            padding: 0.5rem 0;
            height: 90px;
            position: relative;
        }
        .logo {
            width: 120px;
            height: 120px;
            position: relative;
            top: 10px;
            transform: translateY(0);
            z-index: 10;
        }
        .header-title, .nav-link {
            font-family: 'Shannon Extra Bold', sans-serif;
            line-height: 60px;
        }
        .sidebar {
            background: #FFFFFF;
            border: 2px solid #8B0000;
            width: 200px;
            height: calc(90vh - 100px);
            position: fixed;
            top: 140px;
            left: 5px;
            padding: 1rem;
            border-radius: 10px;
        }
        .sidebar button {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 0.5rem;
            background: #FFFFFF;
            border: 2px solid #8B0000;
            border-radius: 8px;
            font-family: 'Shannon Extra Bold', sans-serif;
            font-size: 1.1rem;
            color: #8B0000;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .sidebar button:hover {
            background: #8B0000;
            color: #FFFFFF;
        }
        .sidebar button.active {
            background: #8B0000;
            color: #FFFFFF;
        }
        .main-content {
            margin-left: 200px;
            padding: 2rem;
            flex-grow: 1;
        }
        .zigzag {
            width: 120px;
            height: 12px;
            background: linear-gradient(45deg, transparent 45%, #8B0000 45%, #8B0000 55%, transparent 55%),
            linear-gradient(-45deg, transparent 45%, #8B0000 45%, #8B0000 55%, transparent 55%);
            background-size: 24px 24px;
            margin: 0 auto;
        }
        .section-title {
            font-family: 'JI Burrito', sans-serif;
            font-size: 2.5rem;
            color: #8B0000;
            text-align: center;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }
        .reservation-card, .table-card {
            background: rgba(255, 255, 255, 0.95);
            border: 2px solid #8B0000;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease;
        }
        .reservation-card:hover, .table-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        .reservation-details, .table-details {
            font-family: 'Shannon Extra Bold', sans-serif;
            font-size: 1.1rem;
            color: #8B0000;
        }
        .action-btn {
            padding: 6px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-family: 'Shannon Extra Bold', sans-serif;
            font-size: 1rem;
            cursor: pointer;
        }
        .edit-btn {
            background: #003087;
            color: white;
        }
        .edit-btn:hover {
            background: #8B0000;
        }
        .delete-btn {
            background: #8B0000;
            color: white;
        }
        .delete-btn:hover {
            background: #003087;
        }
        .search-bar {
            width: 100%;
            max-width: 400px;
            padding: 0.75rem;
            margin-bottom: 1.5rem;
            border: 2px solid #8B0000;
            border-radius: 8px;
            font-family: 'Shannon Extra Bold', sans-serif;
            font-size: 1rem;
            color: #8B0000;
        }
        .add-table-form {
            background: #FFFFFF;
            border: 2px solid #8B0000;
            border-radius: 8px;
            padding: 2rem;
            max-width: 500px;
            margin: 0 auto;
        }
        .add-table-form label {
            display: block;
            font-family: 'Shannon Extra Bold', sans-serif;
            font-size: 1.1rem;
            color: #8B0000;
            margin-bottom: 0.5rem;
        }
        .add-table-form input, .add-table-form select {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 2px solid #8B0000;
            border-radius: 8px;
            font-family: 'Shannon Extra Bold', sans-serif;
            font-size: 1rem;
            color: #8B0000;
        }
        .add-table-form button {
            width: 100%;
            padding: 0.75rem;
            background: #8B0000;
            border: none;
            border-radius: 8px;
            font-family: 'Shannon Extra Bold', sans-serif;
            font-size: 1.1rem;
            color: #FFFFFF;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .add-table-form button:hover {
            background: #003087;
        }
        .fade-in {
            animation: fadeIn 1s ease-in forwards;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="text-black">
<!-- Header -->
<jsp:include page="header.jsp"/>

<!-- Sidebar -->
<div class="sidebar">
    <button id="reservations-btn" class="active">Reservations</button>
    <button id="tables-btn">Tables</button>
    <button id="add-table-btn">Add Table</button>
    <button id="feedback-btn">Feedbacks</button>
    <button id="users-btn">Users</button>
    <button id="admin-btn">Admin</button>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="my-20"></div>
    <!-- Reservations Section -->
    <div id="reservations-section">
        <div class="text-center mb-12">
            <div class="zigzag mb-6"></div>
            <h2 class="section-title">Current Reservations</h2>
            <div class="zigzag mt-6"></div>
        </div>
        <div class="bg-white p-8 rounded-xl shadow-lg border border-maroon max-w-3xl mx-auto">
            <input type="text" id="searchInput" placeholder="Search by name..." class="search-bar">
            <c:if test="${not empty reservations}">
                <ul id="reservationList" class="space-y-6">
                    <c:forEach var="reservation" items="${reservations}" varStatus="loop">
                        <c:if test="${reservation != null}">
                            <li class="reservation-card" data-name="${fn:toLowerCase(reservation.name)}">
                                <span class="reservation-details">
                                    ${reservation.name} - ${reservation.date} at
                                    <c:set var="hour" value="${fn:substringBefore(reservation.time, ':')}" />
                                    <c:set var="minute" value="${fn:substringAfter(reservation.time, ':')}" />
                                    <c:set var="hourNum" value="${hour}" />
                                    <c:set var="displayHour" value="${hourNum > 12 ? hourNum - 12 : (hourNum == 0 ? 12 : hourNum)}" />
                                    <c:set var="period" value="${hourNum < 12 ? 'AM' : 'PM'}" />
                                    ${displayHour}:${minute} ${period} (Party of ${reservation.partySize})
                                </span>
                                <div class="space-x-4">
                                    <a href="${pageContext.request.contextPath}/reservations/edit?index=${loop.index}" class="action-btn edit-btn">Edit</a>
                                    <a href="${pageContext.request.contextPath}/reservations/delete?index=${loop.index}" class="action-btn delete-btn" data-index="${loop.index}">Delete</a>
                                </div>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </c:if>
            <c:if test="${empty reservations}">
                <p id="noReservations" class="text-center text-maroon text-xl">No reservations yet.</p>
            </c:if>
        </div>
    </div>

    <!-- Tables Section -->
    <div id="tables-section" style="display: none;">
        <div class="text-center mb-12">
            <div class="zigzag mb-6"></div>
            <h2 class="section-title">Current Tables</h2>
            <div class="zigzag mt-6"></div>
        </div>
        <div class="bg-white p-8 rounded-xl shadow-lg border border-maroon max-w-3xl mx-auto">
            <input type="text" id="tableSearchInput" placeholder="Search by table number..." class="search-bar">
            <c:if test="${not empty tables}">
                <ul id="tableList" class="space-y-6">
                    <c:forEach var="table" items="${tables}" varStatus="loop">
                        <li class="table-card" data-table-number="${table.tableNumber}">
                            <span class="table-details">
                                Table ${table.tableNumber} - Capacity: ${table.capacity}, Status: ${table.status}
                            </span>
                            <div class="space-x-4">
                                <a href="${pageContext.request.contextPath}/tables/edit?index=${loop.index}" class="action-btn edit-btn">Edit</a>
                                <a href="${pageContext.request.contextPath}/tables/delete?index=${loop.index}" class="action-btn delete-btn" data-index="${loop.index}">Delete</a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <c:if test="${empty tables}">
                <p class="text-center text-maroon text-xl">No tables yet.</p>
            </c:if>
        </div>
    </div>

    <!-- Add Table Section -->
    <div id="add-table-section" style="display: none;">
        <div class="text-center mb-12">
            <div class="zigzag mb-6"></div>
            <h2 class="section-title">Add New Table</h2>
            <div class="zigzag mt-6"></div>
        </div>
        <form class="add-table-form" action="${pageContext.request.contextPath}/tables" method="post">
            <label for="table-number">Table Number</label>
            <input type="number" id="table-number" name="tableNumber" placeholder="Enter table number" required>
            <label for="table-capacity">Capacity</label>
            <input type="number" id="table-capacity" name="capacity" placeholder="Enter capacity" required>
            <label for="table-location">Location</label>
            <select id="table-location" name="location" required>
                <option value="available">Window</option>
                <option value="occupied">Main Area</option>
                <option value="reserved">Outdoor</option>
            </select>
            <button type="submit">Add Table</button>
        </form>
    </div>

    <!-- Placeholder Sections -->
    <div id="users-section" style="display: none;">
        <div class="text-center mb-12">
            <div class="zigzag mb-6"></div>
            <h2 class="section-title">Users</h2>
            <div class="zigzag mt-6"></div>
        </div>
        <p class="text-center text-maroon text-xl">Users management section will be implemented here.</p>
    </div>
    <div id="feedback-section" style="display: none;">
        <div class="text-center mb-12">
            <div class="zigzag mb-6"></div>
            <h2 class="section-title">Feedbacks</h2>
            <div class="zigzag mt-6"></div>
        </div>
        <p class="text-center text-maroon text-xl">Feedback section will be implemented here.</p>
    </div>
    <div id="admin-section" style="display: none;">
        <div class="text-center mb-12">
            <div class="zigzag mb-6"></div>
            <h2 class="section-title">Admin Settings</h2>
            <div class="zigzag mt-6"></div>
        </div>
        <p class="text-center text-maroon text-xl">Admin settings section will be implemented here.</p>
    </div>
</div>

<script>
    // Tailwind configuration
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    'yellow': '#FFC107',
                    'blue': '#003087',
                    'maroon': '#8B0000'
                }
            }
        }
    }

    // Sidebar navigation logic
    const sections = {
        'reservations-btn': 'reservations-section',
        'tables-btn': 'tables-section',
        'add-table-btn': 'add-table-section',
        'feedback-btn': 'feedback-section',
        'users-btn': 'users-section',
        'admin-btn': 'admin-section'
    };

    Object.keys(sections).forEach(btnId => {
        const btn = document.getElementById(btnId);
        btn.addEventListener('click', () => {
            Object.values(sections).forEach(sectionId => {
                document.getElementById(sectionId).style.display = 'none';
            });
            document.getElementById(sections[btnId]).style.display = 'block';
            document.querySelectorAll('.sidebar button').forEach(button => {
                button.classList.remove('active');
            });
            btn.classList.add('active');
        });
    });

    // Search functionality for reservations
    document.addEventListener('DOMContentLoaded', () => {
        const searchInput = document.getElementById('searchInput');
        const reservationList = document.getElementById('reservationList');
        const reservationItems = reservationList ? Array.from(reservationList.getElementsByTagName('li')) : [];

        searchInput.addEventListener('input', () => {
            const searchTerm = searchInput.value.toLowerCase();
            for (let item of reservationItems) {
                const name = item.getAttribute('data-name');
                item.style.display = name.includes(searchTerm) ? 'flex' : 'none';
            }
        });

        // Delete confirmation
        const deleteButtons = document.querySelectorAll('.delete-btn');
        deleteButtons.forEach(button => {
            button.addEventListener('click', (e) => {
                e.preventDefault();
                const url = button.getAttribute('href');
                Swal.fire({
                    title: 'Are you sure?',
                    text: "Do you want to delete this reservation?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#8B0000',
                    cancelButtonColor: '#003087',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = url;
                    }
                });
            });
        });

        // Tables search
        const tableSearchInput = document.getElementById('tableSearchInput');
        const tableList = document.getElementById('tableList');
        const tableItems = tableList ? Array.from(tableList.getElementsByTagName('li')) : [];

        tableSearchInput.addEventListener('input', () => {
            const searchTerm = tableSearchInput.value.toLowerCase();
            for (let item of tableItems) {
                const tableNumber = item.getAttribute('data-table-number');
                item.style.display = tableNumber.includes(searchTerm) ? 'flex' : 'none';
            }
        });
    });
</script>
</body>
</html>