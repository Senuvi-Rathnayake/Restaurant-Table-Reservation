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
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            border: 2px solid #8B0000;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
            position: relative;
            z-index: 3;
        }
        .form-container:hover {
            transform: translateY(-5px);
        }
        .form-container label {
            text-shadow: none !important;
        }
        input[type="text"],
        input[type="date"],
        input[type="number"],
        select {
            font-family: 'Shannon Extra Bold Regular', sans-serif !important;
            position: relative;
            z-index: 4;
            color: #8B0000 !important;
            background-color: #FFFFFF !important;
            appearance: auto;
            padding: 0.75rem;
        }
        select {
            -webkit-appearance: menulist;
            -moz-appearance: menulist;
            appearance: menulist;
        }
        #submitBtn {
            font-family: 'JI Burrito', sans-serif !important;
            background: linear-gradient(45deg, #8B0000, #A52A2A);
            border: 2px solid #3977d6;
            padding: 14px 28px;
            font-size: 1.6rem;
            color: #FFC107;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
            border-radius: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 4;
        }
        #submitBtn:hover {
            background: linear-gradient(45deg, #3977d6, #0047AB);
            color: #FFFFFF;
            transform: scale(1.1);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.4);
        }
        #submitBtn:disabled {
            background: #666;
            cursor: not-allowed;
        }
        .fade-in {
            animation: fadeIn 1s ease-in forwards;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body class="text-black">
<jsp:include page="WEB-INF/views/header.jsp"/>
<div class="hero-section fade-in">
    <div class="my-20"></div>
    <div class="container mx-auto p-8 flex-grow">
        <div class="text-center mb-12 fade-in">
            <div class="zigzag mb-6"></div>
            <h1 class="text-5xl font-bold text-yellow drop-shadow-none">Reserve Your Table</h1>
            <div class="zigzag mt-6"></div>
        </div>
        <div class="form-container p-10 rounded-3xl max-w-lg mx-auto fade-in">
            <form id="reservationForm" action="${pageContext.request.contextPath}/reservations" method="post" class="space-y-8">
                <div>
                    <label for="name" class="block text-lg font-medium text-maroon">NAME</label>
                    <input type="text" id="name" name="name" class="mt-2 p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue focus:border-blue" required>
                    <p id="nameError" class="text-red-600 text-sm mt-1 hidden">Name must be at least 2 characters long.</p>
                </div>
                <div>
                    <label for="date" class="block text-lg font-medium text-maroon">DATE</label>
                    <input type="date" id="date" name="date" class="mt-2 p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue focus:border-blue" required>
                    <p id="dateError" class="text-red-600 text-sm mt-1 hidden">Please select a future date.</p>
                </div>
                <div>
                    <label for="time" class="block text-lg font-medium text-maroon">TIME</label>
                    <select id="time" name="time" class="mt-2 p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue focus:border-blue" required>
                        <option value="" disabled selected>SELECT A TIME</option>
                        <option value="09:30 AM">9:30 AM</option>
                        <option value="10:00 AM">10:00 AM</option>
                        <option value="10:30 AM">10:30 AM</option>
                        <option value="11:00 AM">11:00 AM</option>
                        <option value="11:30 AM">11:30 AM</option>
                        <option value="12:00 PM">12:00 PM</option>
                        <option value="12:30 PM">12:30 PM</option>
                        <option value="13:00 PM">1:00 PM</option>
                        <option value="13:30 PM">1:30 PM</option>
                        <option value="14:00 PM">2:00 PM</option>
                        <option value="14:30 PM">2:30 PM</option>
                        <option value="15:00 PM">3:00 PM</option>
                        <option value="15:30 PM">3:30 PM</option>
                        <option value="16:00 PM">4:00 PM</option>
                        <option value="16:30 PM">4:30 PM</option>
                        <option value="17:00 PM">5:00 PM</option>
                        <option value="17:30 PM">5:30 PM</option>
                        <option value="18:00 PM">6:00 PM</option>
                        <option value="18:30 PM">6:30 PM</option>
                        <option value="19:00 PM">7:00 PM</option>
                        <option value="19:30 PM">7:30 PM</option>
                        <option value="20:00 PM">8:00 PM</option>
                        <option value="20:30 PM">8:30 PM</option>
                        <option value="21:00 PM">9:00 PM</option>
                        <option value="21:30 PM">9:30 PM</option>
                    </select>
                    <p id="timeError" class="text-red-600 text-sm mt-1 hidden">Please select a valid time.</p>
                </div>
                <div>
                    <label for="partySize" class="block text-lg font-medium text-maroon">PARTY SIZE</label>
                    <input type="number" id="partySize" name="partySize" min="1" class="mt-2 p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue focus:border-blue" required>
                    <p id="partySizeError" class="text-red-600 text-sm mt-1 hidden">PARTY SIZE MUST BE AT LEAST 1.</p>
                </div>
                <div class="text-center">
                    <button type="submit" id="submitBtn">Reserve a Table</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="WEB-INF/views/footer.jsp"/>

<script>
    tailwind.config = { theme: { extend: { colors: { 'yellow': '#FFC107', 'blue': '#3977d6', 'maroon': '#8B0000' } } } }

    document.addEventListener('DOMContentLoaded', () => {
        const form = document.getElementById('reservationForm');
        const nameInput = document.getElementById('name');
        const dateInput = document.getElementById('date');
        const timeSelect = document.getElementById('time');
        const partySizeInput = document.getElementById('partySize');
        const nameError = document.getElementById('nameError');
        const dateError = document.getElementById('dateError');
        const timeError = document.getElementById('timeError');
        const partySizeError = document.getElementById('partySizeError');
        const submitBtn = document.getElementById('submitBtn');

        // Real-time validation
        nameInput.addEventListener('input', () => {
            if (nameInput.value.length < 2) {
                nameError.classList.remove('hidden');
                nameInput.classList.add('border-red-600');
            } else {
                nameError.classList.add('hidden');
                nameInput.classList.remove('border-red-600');
            }
        });

        dateInput.addEventListener('change', () => {
            const selectedDate = new Date(dateInput.value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate <= today) {
                dateError.classList.remove('hidden');
                dateInput.classList.add('border-red-600');
            } else {
                dateError.classList.add('hidden');
                dateInput.classList.remove('border-red-600');
            }
            dateInput.style.color = '#000000';
        });

        timeSelect.addEventListener('change', () => {
            if (!timeSelect.value) {
                timeError.classList.remove('hidden');
                timeSelect.classList.add('border-red-600');
            } else {
                timeError.classList.add('hidden');
                timeSelect.classList.remove('border-red-600');
            }
            timeSelect.style.color = '#000000';
        });

        partySizeInput.addEventListener('input', () => {
            if (partySizeInput.value < 1) {
                partySizeError.classList.remove('hidden');
                partySizeInput.classList.add('border-red-600');
            } else {
                partySizeError.classList.add('hidden');
                partySizeInput.classList.remove('border-red-600');
            }
        });

        form.addEventListener('submit', (e) => {
            let hasError = false;

            if (nameInput.value.length < 2) {
                nameError.classList.remove('hidden');
                nameInput.classList.add('border-red-600');
                hasError = true;
            }

            const selectedDate = new Date(dateInput.value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate <= today) {
                dateError.classList.remove('hidden');
                dateInput.classList.add('border-red-600');
                hasError = true;
            }

            if (!timeSelect.value) {
                timeError.classList.remove('hidden');
                timeSelect.classList.add('border-red-600');
                hasError = true;
            }

            if (partySizeInput.value < 1) {
                partySizeError.classList.remove('hidden');
                partySizeInput.classList.add('border-red-600');
                hasError = true;
            }

            if (hasError) {
                e.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Please fix the errors in the form before submitting!',
                    confirmButtonColor: '#8B0000'
                });
                return;
            }

            e.preventDefault();
            Swal.fire({
                title: 'Confirm Reservation',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#8B0000',
                cancelButtonColor: '#666',
                confirmButtonText: 'Confirm',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit(); // Submit the form directly
                }
            });
        });

        // Check for success message from server
        <c:if test="${not empty success}">
        Swal.fire({
            title: 'Reservation Confirmed',
            text: 'Your reservation has been successfully recorded!',
            icon: 'success',
            confirmButtonColor: '#8B0000',
            confirmButtonText: 'OK'
        }).then(() => {
            form.reset(); // Reset form after success
        });
        </c:if>

        <c:if test="${not empty error}">
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: '${error}',
            confirmButtonColor: '#8B0000'
        });
        </c:if>
    });
</script>

<style>
    .swal2-font {
        font-family: 'JI Burrito', sans-serif !important;
        font-size: 1.2rem !important;
    }
    .swal2-html-container {
        font-family: 'JI Burrito', sans-serif !important;
        font-size: 1.2rem !important;
    }
</style>
</body>
</html>