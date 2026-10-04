<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- basic -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- mobile metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- site metas -->
        <title>Đăng nhập - Quản lý Khách Sạn</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">
        
        <!-- bootstrap css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <!-- style css -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <!-- Responsive-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
        <!-- fevicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/images/fevicon.png" type="image/gif" />
        <!-- Scrollbar Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.mCustomScrollbar.min.css">
        <!-- Tweaks for older IEs-->
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">

        <!-- CSS TÙY CHỈNH HIỆU ỨNG GLASSMORPHISM -->
     <style>
 
      body.main-layout.inner_page {
         background: url('${pageContext.request.contextPath}/images/hotel-bg.jpg') no-repeat center center fixed !important;
         background-size: cover !important;
         position: relative;
         height: 100vh;
         overflow-x: hidden;
       
         animation: hotelBreathingGlow 8s ease-in-out infinite;
      }

   
      @keyframes hotelBreathingGlow {
         0% {
            filter: brightness(0.7) contrast(1.0);
         }
         50% {
          
            filter: brightness(1.15) contrast(1.05) drop-shadow(0 0 40px rgba(255, 183, 77, 0.3));
         }
         100% {
            filter: brightness(0.7) contrast(1.0);
         }
      }

    
      body.main-layout.inner_page::before {
         content: "";
         position: absolute;
         top: 0; left: 0; width: 100%; height: 100%;
         background: rgba(0, 0, 0, 0.45);
         z-index: -1;
      }

   
      .back_re {
         display: none !important;
      }

      /* Bao bọc form chính */
      .glass-login-container {
         min-height: 80vh;
         display: flex;
         align-items: center;
         justify-content: center;
      }

      
      .glass-card {
         position: relative;
         width: 100%;
         max-width: 440px;
         padding: 40px;
         background: rgba(255, 255, 255, 0.05); 
         backdrop-filter: blur(16px);            
         -webkit-backdrop-filter: blur(16px);
         border: 1px solid rgba(255, 255, 255, 0.15); 
         border-radius: 20px;
         box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
         color: #fff;
         z-index: 2;
      }

    
      .glow-circle-1 {
         position: absolute;
         top: -30px; right: -20px;
         width: 130px; height: 130px;
         background: linear-gradient(135deg, #9333ea, #ec4899);
         border-radius: 50%;
         filter: blur(40px);
         z-index: -1;
      }

      .glow-circle-2 {
         position: absolute;
         bottom: -30px; left: -20px;
         width: 130px; height: 130px;
         background: linear-gradient(135deg, #7c3aed, #3b82f6);
         border-radius: 50%;
         filter: blur(40px);
         z-index: -1;
      }

     
      .glass-card .contactus {
         background: rgba(255, 255, 255, 0.08) !important;
         border: 1px solid rgba(255, 255, 255, 0.2) !important;
         border-radius: 10px !important;
         color: #fff !important;
         padding: 15px 18px !important;
         margin-bottom: 20px !important;
         width: 100% !important;
         font-size: 15px !important;
      }

      .glass-card .contactus::placeholder {
         color: rgba(255, 255, 255, 0.5) !important;
      }

      .glass-card .contactus:focus {
         background: rgba(255, 255, 255, 0.15) !important;
         border-color: rgba(255, 255, 255, 0.5) !important;
         box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
      }

     
      .glass-card .send_btn {
         background: rgba(255, 255, 255, 0.2) !important;
         border: 1px solid rgba(255, 255, 255, 0.3) !important;
         color: #fff !important;
         border-radius: 10px !important;
         padding: 12px !important;
         font-weight: 600 !important;
         width: auto !important;
         min-width: 160px !important;    
         margin: 0 auto !important;     
         display: block !important;      
         
         font-size: 16px !important;
         transition: all 0.3s ease;
         text-transform: none !important;
      }

      .glass-card .send_btn:hover {
         background: rgba(255, 255, 255, 0.35) !important;
         box-shadow: 0 0 15px rgba(255, 255, 255, 0.4);
      }

      /* Căn chỉnh chữ tiêu đề */
      .glass-card h3 {
         color: #fff !important;
         font-weight: 700 !important;
         font-size: 26px !important;
      }

      .glass-card p {
         color: rgba(255, 255, 255, 0.7) !important;
      }
   </style>
    </head>
    
    <!-- body -->
    <body class="main-layout inner_page">
        <!-- loader  -->
        <div class="loader_bg">
            <div class="loader"><img src="${pageContext.request.contextPath}/images/loading.gif" alt="#"/></div>
        </div>
        <!-- end loader -->

        <!-- NHÚNG NAVBAR CHUNG -->
        <jsp:include page="/layout/navbar.jsp" />


        <div class="container glass-login-container">
            <div class="glass-card">
                <!-- Đốm sáng phát quang trang trí góc -->
                <div class="glow-circle-1"></div>
                <div class="glow-circle-2"></div>

                <form id="loginForm" class="main_form" action="${pageContext.request.contextPath}/login" method="post">
                    <div class="row">
                        <div class="col-md-12 text-center mb-3">
                            <h3>Hotel Login</h3>
                            <p>Nhập thông tin tài khoản để Đăng Nhập</p>
                        </div>

                        <!-- Khu vực hiển thị thông báo lỗi từ Servlet (Giữ nguyên logic cũ của bạn) -->
                        <% if (request.getAttribute("error") != null) {%>
                        <div class="col-md-12">
                            <div class="alert alert-danger py-2 bg-danger text-white border-0 rounded-3 mb-3 text-center" role="alert" style="font-size: 14px;">
                                <%= request.getAttribute("error")%>
                            </div>
                        </div>
                        <% }%>

                        <div class="col-md-12">
                            <input class="contactus" placeholder="Tên đăng nhập hoặc Email" type="text" name="username" required autocomplete="off"> 
                        </div>
                        <div class="col-md-12">
                            <input class="contactus" placeholder="Mật khẩu" type="password" name="password" required>         
                        </div>
                        
                        <div class="col-md-12 text-center">
                            <button class="send_btn" type="submit">Login</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- end login section -->

        <!-- NHÚNG FOOTER CHUNG -->
        <jsp:include page="/layout/footer.jsp" />

        <!-- Javascript files-->
        <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery-3.0.0.min.js"></script>
        <!-- sidebar -->
        <script src="${pageContext.request.contextPath}/js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    </body>
</html>