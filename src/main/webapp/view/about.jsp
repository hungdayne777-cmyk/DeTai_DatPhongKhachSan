<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
   <head>
      <!-- basic -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>Danh sách phòng - Đặt Phòng Khách Sạn</title>
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
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->

      <style>
         /* --- HIỆU ỨNG TỰ ĐỘNG CHUYỂN ĐỘNG NGANG --- */
         .slider-container {
            overflow: hidden;
            width: 100%;
            position: relative;
            padding: 20px 0;
         }

         .slider-track {
            display: flex;
            width: max-content;
            animation: scrollLeftToRight 20s linear infinite;
         }

         .slider-track:hover {
            animation-play-state: paused;
         }

         .slide-item {
            width: 360px;
            margin-right: 30px;
            flex-shrink: 0;
         }

         @keyframes scrollLeftToRight {
            0% {
               transform: translateX(0);
            }
            100% {
               transform: translateX(-1170px);
            }
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

      <!-- banner inner -->
      <div class="back_re">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="title">
                     <h2>KHÁM PHÁ KHÔNG GIAN NGHỈ DƯỠNG</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end banner inner -->

      <!-- blog / room -->
      <div class="blog">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <p class="margin_0">Trải nghiệm không gian nghỉ dưỡng thoải mái, tiện nghi và sang trọng</p>
                  </div>
               </div>
            </div>
         </div>

         >
         <div class="slider-container">
            <div class="slider-track">
            
               <div class="slide-item">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog1.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Phòng Ngủ Đơn</h3>
                        <span>Tiêu chuẩn cao cấp</span>
                        <p>Không gian ấm cúng, thiết kế gọn gàng và đầy đủ tiện nghi, mang lại sự thoải mái tối ưu cho cá nhân.</p>
                     </div>
                  </div>
               </div>
               <div class="slide-item">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog2.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Phòng Đôi Tiện Nghi</h3>
                        <span>Không gian rộng rãi</span>
                        <p>Không gian rộng rãi, thoáng mát với nội thất sang trọng, hoàn hảo cho các cặp đôi hoặc nhóm bạn nghỉ dưỡng.</p>
                     </div>
                  </div>
               </div>
               <div class="slide-item">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog3.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Khách Sạn View Biển</h3>
                        <span>Đầy đủ nội thất</span>
                        <p>Tận hưởng kỳ nghỉ tuyệt vời tại khách sạn view biển sang trọng, nơi ngắm trọn bình minh và không gian thư giản đẳng cấp.</p>
                     </div>
                  </div>
               </div>

          
               <div class="slide-item">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog1.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Phòng Ngủ Đơn</h3>
                        <span>Tiêu chuẩn cao cấp</span>
                        <p>Không gian ấm cúng, thiết kế gọn gàng và đầy đủ tiện nghi, mang lại sự thoải mái tối ưu cho cá nhân.</p>
                     </div>
                  </div>
               </div>
               <div class="slide-item">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog2.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Phòng Đôi Tiện Nghi</h3>
                        <span>Không gian rộng rãi</span>
                        <p>Không gian rộng rãi, thoáng mát với nội thất sang trọng, hoàn hảo cho các cặp đôi hoặc nhóm bạn nghỉ dưỡng.</p>
                     </div>
                  </div>
               </div>
               <div class="slide-item">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog3.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Khách Sạn View Biển</h3>
                        <span>Đầy đủ nội thất</span>
                        <p>Tận hưởng kỳ nghỉ tuyệt vời tại khách sạn view biển sang trọng, nơi ngắm trọn bình minh và không gian thư giản đẳng cấp.</p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end blog / room -->
      
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