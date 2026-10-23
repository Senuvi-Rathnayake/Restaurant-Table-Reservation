<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header-bar">
  <div class="container mx-auto flex justify-between items-center relative">
    <!-- Left Section: Logo and Title -->
    <div class="flex items-center">
      <a href="${pageContext.request.contextPath}/home">
        <img src="${pageContext.request.contextPath}/images/los-pollos-hermanos-header.png" alt="Los Pollos Hermanos Logo" class="logo">
      </a>
      <a href="${pageContext.request.contextPath}/home">
      <h1 class="header-title ml-4 text-3xl font-bold text-yellow drop-shadow-lg">LOS POLLOS HERMANOS</h1>
      </a>
    </div>
    <!-- Right Section: Navigation Links -->
    <div class="flex space-x-6">
      <a href="${pageContext.request.contextPath}/home" class="nav-link text-yellow hover:text-maroon transition duration-300 text-xl">HOME</a>
      <a href="${pageContext.request.contextPath}/index.jsp" class="nav-link text-yellow hover:text-maroon transition duration-300 text-xl">RESERVE</a>
      <a href="${pageContext.request.contextPath}/contact.jsp" class="nav-link text-yellow hover:text-maroon transition duration-300 text-xl">CONTACT</a>
      <a href="${pageContext.request.contextPath}/home" class="nav-link text-yellow hover:text-maroon transition duration-300 text-xl">LOGIN</a>
      <a href="${pageContext.request.contextPath}/admin" class="nav-link text-yellow hover:text-maroon transition duration-300 text-xl">ADMIN</a>

    </div>
  </div>
</div>

<style>
  @font-face {
    font-family: 'Shannon Extra Bold Regular';
    src: url('${pageContext.request.contextPath}/fonts/Shannon Extra Bold Regular.ttf') format('truetype');
  }
  .header-bar {
    background: #2979d8; /* Blue background */
    padding: 0.5rem 0; /* Reduced padding to make the header thinner */
    height: 90px; /* Fixed height to make it thinner */
    position: fixed; /* Fixed positioning to stay at the top */
    top: 0; /* Ensure it stays at the top of the page */
    left: 0; /* Ensure it spans the full width of the page */
    width: 100%; /* Full width */
    z-index: 1000; /* Ensure it stays on top of other content */
  }

  .logo {
    width: 120px; /* Scaled down from 1999px to fit the header */
    height: 120px; /* Maintain aspect ratio (1999:2000 is nearly 1:1) */
    position: fixed;
    top: 10px; /* Adjusted to move the logo up (less extension below the header) */
    transform: translateY(0); /* Ensure no unintended shifts */
    z-index: 10; /* Ensure the logo is above other elements */
  }
  .header-title {
    font-family: 'JI Burrito', sans-serif;
    line-height: 90px;
    text-align: left; /* Aligns the text to the left */
    /* Or you can use right or center to adjust */
    margin-left: 150px;/* Vertically center the text within the 60px header */
  }
  .nav-link {
    font-family: 'Shannon Extra Bold Regular', sans-serif;
    line-height: 80px; /* Vertically center the links within the 60px header */
  }
  /* Ensure the logo pops out from the bottom */
  .container {
    overflow: visible !important; /* Allow the logo to extend outside the header */
  }
</style>