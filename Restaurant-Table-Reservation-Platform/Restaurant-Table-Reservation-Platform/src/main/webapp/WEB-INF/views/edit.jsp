<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <link rel="icon" type="image/png" href="images/Favicon.png">
  <title>Los Pollos Hermanos - Edit Reservation</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    @font-face {
      font-family: 'JI Burrito';
      src: url('${pageContext.request.contextPath}/fonts/JI Burrito.ttf') format('truetype');
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
    .form-container {
      background: rgba(255, 255, 255, 0.95);
      border: 2px solid #8B0000;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      transition: transform 0.3s ease;
    }
    .form-container:hover {
      transform: translateY(-5px);
    }
    #submitBtn {
      background: linear-gradient(45deg, #8B0000, #A52A2A);
      border: 2px solid #2979d8;
      padding: 14px 28px;
      font-size: 1.6rem;
      color: #FFC107;
      text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
      border-radius: 12px;
      transition: all 0.3s ease;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }
    #submitBtn:hover {
      background: linear-gradient(45deg, #2979d8, #0047AB);
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
<jsp:include page="header.jsp"/>

<div class="container mx-auto p-8 flex-grow">
  <div class="text-center mb-12 fade-in">
    <div class="my-20"></div>
    <div class="zigzag mb-6"></div>
    <h1 class="text-5xl font-bold text-maroon drop-shadow-lg">Edit Reservation</h1>
    <div class="zigzag mt-6"></div>
  </div>
  <div class="form-container p-10 rounded-xl max-w-lg mx-auto fade-in">
    <form id="editForm" action="${pageContext.request.contextPath}/reservations/edit" method="post" class="space-y-8">
      <input type="hidden" name="index" value="${index}">
      <div>
        <label for="name" class="block text-lg font-medium text-maroon">Name</label>
        <input type="text" id="name" name="name" value="${reservation.name}" class="mt-2 p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue focus:border-blue" required>
        <p id="nameError" class="text-red-600 text-sm mt-1 hidden">Name must be at least 2 characters long.</p>
      </div>
      <div>
        <label for="date" class="block text-lg font-medium text-maroon">Date</label>
        <input type="date" id="date" name="date" value="${reservation.date}" class="mt-2 p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue focus:border-blue" required>
        <p id="dateError" class="text-red-600 text-sm mt-1 hidden">Please select a future date.</p>
      </div>
      <div>
        <label for="time" class="block text-lg font-medium text-maroon">Time</label>
        <select id="time" name="time" class="mt-2 p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue focus:border-blue" required>
          <option value="" disabled>Select a time</option>
          <option value="09:30 AM" ${reservation.time == '09:30' ? 'selected' : ''}>9:30 AM</option>
          <option value="10:00 AM" ${reservation.time == '10:00' ? 'selected' : ''}>10:00 AM</option>
          <option value="10:30 AM" ${reservation.time == '10:30' ? 'selected' : ''}>10:30 AM</option>
          <option value="11:00 AM" ${reservation.time == '11:00' ? 'selected' : ''}>11:00 AM</option>
          <option value="11:30 AM" ${reservation.time == '11:30' ? 'selected' : ''}>11:30 AM</option>
          <option value="12:00 PM" ${reservation.time == '12:00' ? 'selected' : ''}>12:00 PM</option>
          <option value="12:30 PM" ${reservation.time == '12:30' ? 'selected' : ''}>12:30 PM</option>
          <option value="13:00 PM" ${reservation.time == '13:00' ? 'selected' : ''}>1:00 PM</option>
          <option value="13:30 PM" ${reservation.time == '13:30' ? 'selected' : ''}>1:30 PM</option>
          <option value="14:00 PM" ${reservation.time == '14:00' ? 'selected' : ''}>2:00 PM</option>
          <option value="14:30 PM" ${reservation.time == '14:30' ? 'selected' : ''}>2:30 PM</option>
          <option value="15:00 PM" ${reservation.time == '15:00' ? 'selected' : ''}>3:00 PM</option>
          <option value="15:30 PM" ${reservation.time == '15:30' ? 'selected' : ''}>3:30 PM</option>
          <option value="16:00 PM" ${reservation.time == '16:00' ? 'selected' : ''}>4:00 PM</option>
          <option value="16:30 PM" ${reservation.time == '16:30' ? 'selected' : ''}>4:30 PM</option>
          <option value="17:00 PM" ${reservation.time == '17:00' ? 'selected' : ''}>5:00 PM</option>
          <option value="17:30 PM" ${reservation.time == '17:30' ? 'selected' : ''}>5:30 PM</option>
          <option value="18:00 PM" ${reservation.time == '18:00' ? 'selected' : ''}>6:00 PM</option>
          <option value="18:30 PM" ${reservation.time == '18:30' ? 'selected' : ''}>6:30 PM</option>
          <option value="19:00 PM" ${reservation.time == '19:00' ? 'selected' : ''}>7:00 PM</option>
          <option value="19:30 PM" ${reservation.time == '19:30' ? 'selected' : ''}>7:30 PM</option>
          <option value="20:00 PM" ${reservation.time == '20:00' ? 'selected' : ''}>8:00 PM</option>
          <option value="20:30 PM" ${reservation.time == '20:30' ? 'selected' : ''}>8:30 PM</option>
          <option value="21:00 PM" ${reservation.time == '21:00' ? 'selected' : ''}>9:00 PM</option>
          <option value="21:30 PM" ${reservation.time == '21:30' ? 'selected' : ''}>9:30 PM</option>
        </select>
        <p id="timeError" class="text-red-600 text-sm mt-1 hidden">Please select a valid time.</p>
      </div>
      <div>
        <label for="partySize" class="block text-lg font-medium text-maroon">Party Size</label>
        <input type="number" id="partySize" name="partySize" value="${reservation.partySize}" min="1" class="mt-2 p-3 w-full border border-maroon rounded-lg focus:ring-2 focus:ring-blue focus:border-blue" required>
        <p id="partySizeError" class="text-red-600 text-sm mt-1 hidden">Party size must be at least 1.</p>
      </div>
      <div class="text-center">
        <button type="submit" id="submitBtn">Update Reservation</button>
      </div>
    </form>
  </div>
  <div class="text-center mt-8">
    <a href="${pageContext.request.contextPath}/admin" class="text-maroon hover:text-blue transition duration-300 text-lg font-semibold">Back to Reservations</a>
  </div>
</div>

<jsp:include page="footer.jsp"/>

<script>
  tailwind.config = { theme: { extend: { colors: { 'yellow': '#FFC107', 'blue': '#2979d8', 'maroon': '#8B0000' } } } }

  document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('editForm');
    const nameInput = document.getElementById('name');
    const dateInput = document.getElementById('date');
    const timeSelect = document.getElementById('time');
    const partySizeInput = document.getElementById('partySize');
    const nameError = document.getElementById('nameError');
    const dateError = document.getElementById('dateError');
    const timeError = document.getElementById('timeError');
    const partySizeError = document.getElementById('partySizeError');
    const submitBtn = document.getElementById('submitBtn');

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
      if (selectedDate < today) {
        dateError.classList.remove('hidden');
        dateInput.classList.add('border-red-600');
      } else {
        dateError.classList.add('hidden');
        dateInput.classList.remove('border-red-600');
      }
    });

    timeSelect.addEventListener('change', () => {
      if (!timeSelect.value) {
        timeError.classList.remove('hidden');
        timeSelect.classList.add('border-red-600');
      } else {
        timeError.classList.add('hidden');
        timeSelect.classList.remove('border-red-600');
      }
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
      if (selectedDate < today) {
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
      } else {
        e.preventDefault();
        Swal.fire({
          title: 'Confirm Update',
          icon: 'question',
          showCancelButton: true,
          confirmButtonColor: '#8B0000',
          cancelButtonColor: '#666',
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel'
        }).then((result) => {
          if (result.isConfirmed) {
            form.submit(); // Submit the form
          }
        });
      }
    });
  });
</script>
</body>
</html>