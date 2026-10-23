<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <link rel="icon" type="image/png" href="images/Favicon.png">
  <title>Los Pollos Hermanos - Home</title>
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
      background: #2979d8;
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
    .header-title {
      font-family: 'Shannon Extra Bold', sans-serif;
      line-height: 60px;
    }
    .nav-link {
      font-family: 'Shannon Extra Bold', sans-serif;
      line-height: 60px;
    }
    .zigzag {
      width: 120px;
      height: 12px;
      background: linear-gradient(45deg, transparent 45%, #8B0000 45%, #8B0000 55%, transparent 55%),
      linear-gradient(-45deg, transparent 45%, #8B0000 45%, #8B0000 55%, transparent 55%);
      background-size: 24px 24px;
      margin: 0 auto;
    }
    .hero-section {
      background: url('${pageContext.request.contextPath}/images/Hero.png') no-repeat center center/cover;
      height: 100vh;
      width: 100vw;
      position: relative;
      color: white;
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
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
    .hero-content {
      position: relative;
      width: 100%;
      height: 100%;
      z-index: 2;
    }
    .hero-text {
      font-family: 'JI Burrito', sans-serif;
      position: absolute;
      text-align: center;
      top: 25%;
      left: 60%;
      transform: translateX(-50%);
      z-index: 3;
    }
    .hero-button {
      position: absolute;
      text-align: center;
      top: 60%;
      left: 22%;
      transform: translateX(-50%);
      z-index: 3;
    }
    .button-pretext {
      font-family: 'JI Burrito', sans-serif;
      font-size: 3rem;
      color: #FFC107;
      text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
      margin-bottom: 2px;
    }
    .hero-title {
      font-family: 'JI Burrito', sans-serif;
    }
    .cta-btn {
      font-family: 'JI Burrito', sans-serif;
      background: linear-gradient(45deg, #d32323, #A52A2A);
      border: 2px solid #2979d8;
      padding: 14px 28px;
      font-size: 1.6rem;
      color: #FFC107;
      text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
      border-radius: 12px;
      transition: all 0.3s ease;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    }
    .cta-btn:hover {
      background: linear-gradient(45deg, #2979d8, #0047AB);
      color: #FFFFFF;
      transform: scale(1.1);
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.4);
    }
    .feature-card, .feedback-card {
      background: rgba(255, 255, 255, 0.95);
      border: 2px solid #8B0000;
      transition: all 0.3s ease;
    }
    .feature-card:hover, .feedback-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }
    .fade-in {
      animation: fadeIn 1s ease-in forwards;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .section-title {
      font-family: 'JI Burrito', sans-serif;
    }
    .footer-text {
      font-family: 'JI Burrito', sans-serif;
    }
    .swal2-font, .swal2-html-container {
      font-family: 'Shannon Extra Bold', sans-serif !important;
      font-size: 1.2rem !important;
    }
    .about-section {
      position: relative;
    }
    .about-image-container {
      position: relative;
      height: 200px;
      margin-top: 20px;
    }
    .about-image {
      position: absolute;
      width: 300px;
      height: auto;
      top: 20%;
      left: 50%;
      transform: translateX(-50%) rotate(0deg);
      z-index: 5;
    }
    @media (max-width: 768px) {
      .about-image {
        top: -10%;
        left: 50%;
        transform: translateX(-50%) rotate(0deg);
        width: 100px;
      }
    }
  </style>
</head>
<div class="text-black">
<!-- Header -->
<jsp:include page="header.jsp"/>

<!-- Hero Section -->
<div class="hero-section fade-in">
  <div class="hero-content">
    <div class="hero-text">
      <p class="text-4xl mb-1.5">" Yes, the old ways are still best at</p>
      <p class="text-4xl mb-1.5">LOS POLLOS HERMANOS.</p>
      <p class="text-4xl mb-10">But don't take my word for it. One taste, and you'll know. "</p>
      <p class="text-2xl mb-10">~ Excerpt from the Los Pollos Hermanos ~</p>
    </div>
    <div class="hero-button">
      <p class="button-pretext">Taste the Los Pollos Hermanos</p>
      <p class="button-pretext">DIFFERENCE!</p>
      <a href="${pageContext.request.contextPath}/index.jsp" class="cta-btn">Reserve Your Table Now</a>
      <div class="relative w-full">
        <div class="absolute inset-0 -z-10">
          <img src="${pageContext.request.contextPath}/images/Taco1Artboard%204.png" alt="Image 1"
               class="absolute top-[0%] left-[170%] w-[200px] rotate-[30deg] opacity-50">
        </div>
      </div>
    </div>
  </div>
</div>

  <div class="relative w-full">
  <div class="absolute inset-0 -z-10">
    <img src="${pageContext.request.contextPath}/images/DrinkArtboard%204.png" alt="Image 1"
         class="absolute top-[5%] left-[10%] w-[200px] rotate-[10deg] opacity-50">
  </div>
</div>
  <div class="relative w-full">
    <div class="absolute inset-0 -z-10">
      <img src="${pageContext.request.contextPath}/images/Blue%20bucketArtboard%204.png" alt="Image 1"
           class="absolute top-[30%] left-[75%] w-[300px] rotate-[-15deg] opacity-50">
    </div>
  </div>

</div>

<!-- Main Content -->
<div class="container mx-auto p-8 flex-grow">
  <div class="my-20"></div>

  <!-- About Section -->
  <div class="text-center my-12 fade-in">
    <div class="zigzag mb-6"></div>
    <h2 class="text-4xl font-bold text-maroon drop-shadow-lg section-title">Our Story</h2>
    <div class="zigzag mt-6"></div>
  </div>
  <!-- Add a container for the image -->
  <div class="about-image-container relative">
    <img src="${pageContext.request.contextPath}/images/Building.png" alt="Chicken Image" class="about-image">
  </div>
  <div class="about-section max-w-3xl mx-auto text-center text-xl text-maroon fade-in">
    <p>
      Los Pollos Hermanos, translating to “The Chicken Brothers,” was founded in 1986 by brothers Maximino and Casimiro.
      From a single modest location, our commitment to quality ingredients and exceptional customer service has propelled us into a beloved chain renowned for our delectable fried chicken and inviting atmosphere.
    </p>
    <div class="my-8"></div>
    <p>
      We are thrilled to bring the Los Pollos Hermanos experience to Sri Lanka, offering the same dedication to culinary excellence and warm hospitality that has defined us since our inception.
    </p>
    <div class="my-8"></div>
    <p>
      Our Sri Lankan locations feature a menu tailored to local tastes while retaining the signature flavors that have made us a household name. We invite you to join us and become part of our growing family, where every meal is crafted with care and served with a smile.
    </p>
  </div>
  <div class="relative w-full">
    <div class="absolute inset-0 -z-10">
      <img src="${pageContext.request.contextPath}/images/ChickenArtboard%204.png" alt="Image 1"
           class="absolute top-[60%] left-[10%] w-[400px] rotate-[0deg] opacity-50">
    </div>
  </div>
  <div class="my-40"></div>

  <!-- Features Section -->
  <div class="text-center my-12 fade-in">
    <div class="zigzag mb-6"></div>
    <h2 class="text-4xl font-bold text-maroon drop-shadow-lg section-title">Why Choose Us?</h2>
    <div class="zigzag mt-6"></div>
  </div>
  <div class="grid grid-cols-1 md:grid-cols-3 gap-8 fade-in">
    <div class="feature-card p-6 rounded-lg text-center">
      <img src="${pageContext.request.contextPath}/images/FreshIngre.png" alt="Fresh Ingredients" class="w-24 h-24 mx-auto mb-4">
      <h3 class="text-2xl font-bold text-maroon mb-2">Fresh Ingredients</h3>
      <p class="text-maroon">We use only the freshest, locally-sourced ingredients to ensure every dish is bursting with flavor.</p>
    </div>
    <div class="feature-card p-6 rounded-lg text-center">
      <img src="${pageContext.request.contextPath}/images/FamilyFriendly.png" alt="Family Friendly" class="w-24 h-24 mx-auto mb-4">
      <h3 class="text-2xl font-bold text-maroon mb-2">Family Friendly</h3>
      <p class="text-maroon">A welcoming environment for families, with a menu that kids and adults alike will love.</p>
    </div>
    <div class="feature-card p-6 rounded-lg text-center">
      <img src="${pageContext.request.contextPath}/images/FastService.png" alt="Fast Service" class="w-24 h-24 mx-auto mb-4">
      <h3 class="text-2xl font-bold text-maroon mb-2">Fast Service</h3>
      <p class="text-maroon">Enjoy quick and efficient service without compromising on quality or taste.</p>
    </div>
    <div class="relative w-full">
      <div class="absolute inset-0 -z-10">
        <img src="${pageContext.request.contextPath}/images/BucketWhandleArtboard%201.png" alt="Image 1"
             class="absolute top-[10%] left-[220%] w-[400px] rotate-[-25deg] opacity-50">
      </div>
    </div>
  </div>
  <div class="my-40"></div>

  <!-- Testimonial Section -->
  <div class="text-center my-12 fade-in">
    <div class="zigzag mb-6"></div>
    <h2 class="text-4xl font-bold text-maroon drop-shadow-lg section-title">Testimonial</h2>
    <div class="zigzag mt-6"></div>
  </div>

  <!-- Feedback Section -->
  <div class="grid grid-cols-1 md:grid-cols-3 gap-8 fade-in">
    <div class="feedback-card p-6 rounded-lg text-center">
      <h3 class="text-2xl font-bold text-maroon mb-2">Ayesha</h3>
      <p class="text-maroon">"The best fried chicken I've ever had! The flavors are incredible, and the staff are so friendly. A must-visit!"</p>
    </div>
    <div class="feedback-card p-6 rounded-lg text-center">
      <h3 class="text-2xl font-bold text-maroon mb-2">Namal</h3>
      <p class="text-maroon">"Los Pollos Hermanos never disappoints. The food is always fresh, and the atmosphere is perfect for a family meal."</p>
    </div>
    <div class="feedback-card p-6 rounded-lg text-center">
      <h3 class="text-2xl font-bold text-maroon mb-2">Lalo</h3>
      <p class="text-maroon">"I love the vibe here! The chicken is so juicy and flavorful, and the service is top-notch. Highly recommend!"</p>
    </div>
  </div>
  <div class="my-40"></div>
</div>

<!-- Footer -->
<footer class="bg-blue text-white py-6 mt-12">
  <div class="container mx-auto text-center">
    <div class="zigzag mb-4"></div>
    <p class="text-lg footer-text">© 2025 LOS POLLOS HERMANOS. ALL RIGHTS RESERVED.</p>
    <p class="text-sm mt-2 footer-text">SERVING THE FINEST CHICKEN IN SRI LANKA SINCE 1998</p>
    <div class="zigzag mt-4"></div>
  </div>
</footer>

<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: {
          'yellow': '#FFC107',
          'blue': '#2979d8',
          'maroon': '#8B0000'
        }
      }
    }
  }

  document.addEventListener('DOMContentLoaded', () => {
    Swal.fire({
      icon: 'info',
      title: 'Welcome to Los Pollos Hermanos Sri Lanka!',
      text: 'Reserve your table today and enjoy the best chicken in Sri Lanka!',
      confirmButtonColor: '#8B0000',
      confirmButtonText: 'Let’s Eat!'
    });
  });
</script>
</body>
</html>