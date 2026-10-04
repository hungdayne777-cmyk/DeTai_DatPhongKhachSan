<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .glass-booking-container {
        position: relative;
        background: rgba(15, 23, 42, 0.45);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 24px;
        padding: 40px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
        max-width: 480px;
        margin: 40px auto;
        color: #fff;
        overflow: hidden;
    }

    .glass-booking-container::before {
        content: '';
        position: absolute;
        top: -50px;
        right: -50px;
        width: 170px;
        height: 170px;
        background: rgba(217, 119, 6, 0.25);
        filter: blur(60px);
        z-index: -1;
    }

    .glass-booking-container::after {
        content: '';
        position: absolute;
        bottom: -50px;
        left: -50px;
        width: 170px;
        height: 170px;
        background: rgba(59, 130, 246, 0.22); 
        filter: blur(60px);
        z-index: -1;
    }

    .glass-booking-container h1 {
        text-align: center;
        font-weight: 600;
        margin-bottom: 8px;
        font-size: 26px;
        color: #fff;
    }

    .glass-subtitle {
        text-align: center;
        font-size: 14px;
        color: rgba(255, 255, 255, 0.65);
        margin-bottom: 25px;
    }

    .glass-input {
        width: 100% !important;
        background: rgba(255, 255, 255, 0.06) !important;
        border: 1px solid rgba(255, 255, 255, 0.15) !important;
        border-radius: 12px !important;
        padding: 14px 45px 14px 20px !important; 
        color: #fff !important;
        font-size: 15px;
        outline: none;
        transition: all 0.3s ease;
    }

    .glass-input::placeholder {
        color: rgba(255, 255, 255, 0.4);
    }

    .glass-input:focus {
        border-color: rgba(255, 255, 255, 0.4) !important;
        background: rgba(255, 255, 255, 0.1) !important;
        box-shadow: 0 0 15px rgba(255, 255, 255, 0.08);
    }

    .glass-btn {
        width: 100%;
        background: rgba(255, 255, 255, 0.15);
        border: 1px solid rgba(255, 255, 255, 0.25);
        border-radius: 12px;
        padding: 14px;
        color: #fff;
        font-weight: 600;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 10px;
    }

    /* --- HIỆU ỨNG NEON ĐỎ KHI HOVER --- */
    .glass-btn:hover {
        background: rgba(239, 68, 68, 0.25); 
        border-color: #ff4d4d; 
        color: #ffffff; 
        text-shadow: 0 0 10px rgba(255, 77, 77, 0.9), 0 0 20px rgba(255, 77, 77, 0.6); 
        box-shadow: 0 0 20px rgba(239, 68, 68, 0.6), inset 0 0 10px rgba(239, 68, 68, 0.4);
    }
</style>

<!-- banner -->
<section class="banner_main">
    <div id="myCarousel" class="carousel slide banner" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="first-slide" src="${pageContext.request.contextPath}/images/banner1.jpg" alt="First slide">
                <div class="container">
                </div>
            </div>
            <div class="carousel-item">
                <img class="second-slide" src="${pageContext.request.contextPath}/images/banner2.jpg" alt="Second slide">
            </div>
            <div class="carousel-item">
                <img class="third-slide" src="${pageContext.request.contextPath}/images/banner3.jpg" alt="Third slide">
            </div>
        </div>
        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <div class="booking_ocline">
        <div class="container">
            <div class="row">
                <div class="col-md-5">
                   <div class="glass-booking-container">
    <h1>Book a Room Online</h1>
    <p class="glass-subtitle">Chọn ngày nhận và trả phòng để bắt đầu</p>
    
    <form class="book_now">
        <div class="row">
            <div class="col-md-12 mb-3" style="position: relative;">
                <input class="online_book glass-input" placeholder="Arrival (dd/mm/yyyy)" type="text" name="arrival">
                <img class="date_cua" src="${pageContext.request.contextPath}/images/date.png" style="position: absolute; right: 20px; top: 30%; transform: translateY(-50%); pointer-events: none; filter: invert(1); opacity: 0.75;">
            </div>
            
            <div class="col-md-12 mb-3" style="position: relative;">
                <input class="online_book glass-input" placeholder="Departure (dd/mm/yyyy)" type="text" name="departure">
                <img class="date_cua" src="${pageContext.request.contextPath}/images/date.png" style="position: absolute; right: 20px; top: 30%; transform: translateY(-50%); pointer-events: none; filter: invert(1); opacity: 0.75;">
            </div>
            
            <div class="col-md-12">
                <button class="book_btn glass-btn" type="submit">Book Now</button>
            </div>
        </div>
    </form>
</div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end banner -->