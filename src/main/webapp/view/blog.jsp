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
      <title>Blog - Đặt Phòng Khách Sạn</title>
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

      <div class="back_re">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="title">
                     <h2>Bài Viết & Tin Tức</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- blog -->
      <div class="blog">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <p class="margin_0">Cập nhật các kinh nghiệm thuê phòng, mẹo tiết kiệm chi phí và tin tức trọ mới nhất</p>
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="col-md-4">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog1.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Kinh Nghiệm Thuê Phòng</h3>
                        <span>Bí quyết tìm phòng ưng ý</span>
                        <p>Tổng hợp những kinh nghiệm thực tế giúp bạn dễ dàng lựa chọn được phòng sạch sẽ, an ninh tốt và giá cả hợp lý phù hợp với nhu cầu.</p>
                     </div>
                  </div>
               </div>
               <div class="col-md-4">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog2.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Mẹo Tiết Kiệm Điện Nước</h3>
                        <span>Giảm chi phí hàng tháng</span>
                        <p>Chia sẻ các mẹo sử dụng thiết bị điện, nước thông minh và khoa học tại phòng trọ giúp bạn tiết kiệm tối đa khoản chi phí sinh hoạt.</p>
                     </div>
                  </div>
               </div>
               <div class="col-md-4">
                  <div class="blog_box">
                     <div class="blog_img">
                        <figure><img src="${pageContext.request.contextPath}/images/blog3.jpg" alt="#"/></figure>
                     </div>
                     <div class="blog_room">
                        <h3>Trang Trí Phòng Trọ</h3>
                        <span>Không gian sống tiện nghi</span>
                        <p>Gợi ý các cách bố trí nội thất, decor phòng trọ gọn gàng, đẹp mắt và tối ưu hóa diện tích sinh hoạt cho sinh viên và người đi làm.</p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end blog -->
      
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