<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <link rel="icon" type="image/png" href="images/Favicon.png">
    <title>Los Pollos Hermanos - Current Reservations</title>
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
            background: #2979d8;
            padding: 1rem 0;
        }
        .zigzag {
            width: 120px;
            height: 12px;
            background: linear-gradient(45deg, transparent 45%, #8B0000 45%, #8B0000 55%, transparent 55%),
            linear-gradient(-45deg, transparent 45%, #8B0000 45%, #8B0000 55%, transparent 55%);
            background-size: 24px 24px;
            margin: 0 auto;
        }
        .reservation-card {
            background: rgba(255, 255, 255, 0.95);
            border: 2px solid #8B0000;
            transition: all 0.3s ease;
        }
        .reservation-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        .reservation-details {
            font-family: 'Shannon Extra Bold Regular', sans-serif !important;
        }
        .action-btn {
            padding: 6px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .edit-btn {
            background: #2979d8;
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
            background: #2979d8;
        }
        .fade-in {
            animation: fadeIn 1s ease-in forwards;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body class="text-black">
<jsp:include page="header.jsp"/>
<div class="my-10"></div>
<div class="container mx-auto p-8 flex-grow">
    <div class="text-center mb-12 fade-in">
        <div class="zigzag mb-6"></div>
        <h1 class="text-5xl font-bold text-maroon drop-shadow-lg">Current Reservations</h1>
        <div class="zigzag mt-6"></div>
    </div>
    <div class="bg-white p-8 rounded-xl shadow-lg border border-maroon max-w-3xl mx-auto fade-in">
        <input type="text" id="searchInput" placeholder="Search by name..." class="p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue mb-6" style="font-family: Arial, sans-serif;">
        <c:if test="${not empty reservations}">
            <ul id="reservationList" class="space-y-6">
                <c:forEach var="reservation" items="${reservations}" varStatus="loop">
                    <li class="reservation-card p-6 rounded-lg flex justify-between items-center" data-name="${reservation.name.toLowerCase()}">
                        <span class="text-lg text-maroon reservation-details">
                            ${reservation.name} - ${reservation.date} at
                            <c:set var="hour" value="${fn:substringBefore(reservation.time, ':')}" />
                            <c:set var="minute" value="${fn:substringAfter(reservation.time, ':')}" />
                            <c:set var="displayHour" value="${hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)}" />
                            <c:set var="period" value="${hour < 12 ? 'AM' : 'PM'}" />
                            ${displayHour}:${minute} ${period}
                            (Party of ${reservation.partySize})
                        </span>
                        <div class="space-x-4">
                            <a href="${pageContext.request.contextPath}/reservations/edit?index=${loop.index}" class="action-btn edit-btn">Edit</a>
                            <a href="${pageContext.request.contextPath}/reservations/delete?index=${loop.index}" class="action-btn delete-btn" data-index="${loop.index}">Delete</a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </c:if>
        <c:if test="${empty reservations}">
            <p class="text-center text-maroon text-xl">No reservations yet.</p>
        </c:if>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script>
    tailwind.config = { theme: { extend: { colors: { 'yellow': '#FFC107', 'blue': '#2979d8', 'maroon': '#8B0000' } } } }

    document.addEventListener('DOMContentLoaded', () => {
        const searchInput = document.getElementById('searchInput');
        const reservationList = document.getElementById('reservationList');
        const reservationItems = reservationList ? Array.from(reservationList.getElementsByTagName('li')) : [];

        // Function to parse date and time into a comparable Date object
        function parseDateTime(item) {
            const text = item.querySelector('.reservation-details').textContent;
            const dateMatch = text.match(/\d{4}-\d{2}-\d{2}/); // e.g., "2025-03-26"
            const timeMatch = text.match(/\d+:\d+\s[AP]M/); // e.g., "3:00 PM"
            if (!dateMatch || !timeMatch) return null;

            const dateStr = dateMatch[0];
            const timeStr = timeMatch[0];
            const [time, period] = timeStr.split(' ');
            let [hours, minutes] = time.split(':').map(Number);

            if (period === 'PM' && hours !== 12) hours += 12;
            if (period === 'AM' && hours === 12) hours = 0;

            return new Date(`${dateStr}T${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:00`);
        }

        // Merge function for merge sort (descending order)
        function merge(left, right) {
            const result = [];
            let leftIndex = 0;
            let rightIndex = 0;

            while (leftIndex < left.length && rightIndex < right.length) {
                const dateTimeLeft = parseDateTime(left[leftIndex]);
                const dateTimeRight = parseDateTime(right[rightIndex]);
                if (dateTimeLeft >= dateTimeRight) { // Changed <= to >= for descending order
                    result.push(left[leftIndex]);
                    leftIndex++;
                } else {
                    result.push(right[rightIndex]);
                    rightIndex++;
                }
            }

            // Add remaining elements
            return result.concat(left.slice(leftIndex)).concat(right.slice(rightIndex));
        }

        // Merge sort implementation
        function mergeSort(items) {
            if (items.length <= 1) return items;

            const mid = Math.floor(items.length / 2);
            const left = items.slice(0, mid);
            const right = items.slice(mid);

            return merge(mergeSort(left), mergeSort(right));
        }

        // Function to apply sorted array to DOM
        function applySortToDOM(sortedItems) {
            sortedItems.forEach(item => reservationList.appendChild(item));
        }

        // Sort the reservations by date and time on page load
        if (reservationItems.length > 0) {
            const sortedItems = mergeSort(reservationItems);
            applySortToDOM(sortedItems);
        }

        // Search functionality
        searchInput.addEventListener('input', () => {
            const searchTerm = searchInput.value.toLowerCase();
            for (let item of reservationItems) {
                const name = item.getAttribute('data-name');
                if (name.includes(searchTerm)) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
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
                    cancelButtonColor: '#2979d8',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = url;
                    }
                });
            });
        });
    });
</script>
</body>
</html>