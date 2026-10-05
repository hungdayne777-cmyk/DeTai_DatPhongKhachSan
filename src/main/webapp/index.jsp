<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (request.getAttribute("roomList") == null) {
        Dao.PhongDAO pDao = new Dao.PhongDAO();
        java.util.List<Model.Phong> list = pDao.getAllRooms();
        request.setAttribute("roomList", list);
    }
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
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
        <!-- basic -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- mobile metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <!-- site metas -->
        <title>Đặt Phòng </title>
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
     
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css">
        
    </head>
    <!-- body -->
    <body class="main-layout">
      

        <!-- 1. Nhúng Navbar (Nằm trong thư mục layout) -->
        <jsp:include page="/layout/navbar.jsp" />

        <!-- 2. Nhúng Banner (Nằm trong thư mục view) -->
        <jsp:include page="/view/banner.jsp" />
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
      
       
<jsp:include page="layout/room_card.jsp" />
        </div>
        <!-- end our_room -->
           <!-- banner inner -->
      <div class="back_re">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="title">
                     <h2>Thư Viện Ảnh</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end banner inner -->

      <!-- gallery -->
      <div class="gallery">
         <div class="container">
            <div class="row">
               <div class="col-md-3 col-sm-6">
                  <div class="gallery_img">
                     <figure><img src="${pageContext.request.contextPath}/images/gallery1.jpg" alt="#"/></figure>
                  </div>
               </div>
               <div class="col-md-3 col-sm-6">
                  <div class="gallery_img">
                     <figure><img src="${pageContext.request.contextPath}/images/gallery2.jpg" alt="#"/></figure>
                  </div>
               </div>
               <div class="col-md-3 col-sm-6">
                  <div class="gallery_img">
                     <figure><img src="${pageContext.request.contextPath}/images/gallery3.jpg" alt="#"/></figure>
                  </div>
               </div>
               <div class="col-md-3 col-sm-6">
                  <div class="gallery_img">
                     <figure><img src="${pageContext.request.contextPath}/images/gallery4.jpg" alt="#"/></figure>
                  </div>
               </div>
               <div class="col-md-3 col-sm-6">
                  <div class="gallery_img">
                     <figure><img src="${pageContext.request.contextPath}/images/gallery5.jpg" alt="#"/></figure>
                  </div>
               </div>
               <div class="col-md-3 col-sm-6">
                  <div class="gallery_img">
                     <figure><img src="${pageContext.request.contextPath}/images/gallery6.jpg" alt="#"/></figure>
                  </div>
               </div>
               <div class="col-md-3 col-sm-6">
                  <div class="gallery_img">
                     <figure><img src="${pageContext.request.contextPath}/images/gallery7.jpg" alt="#"/></figure>
                  </div>
               </div>
               <div class="col-md-3 col-sm-6">
                  <div class="gallery_img">
                     <figure><img src="${pageContext.request.contextPath}/images/gallery8.jpg" alt="#"/></figure>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end gallery -->
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
          <!-- banner inner -->
      <div class="back_re">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="title">
                     <h2>Liên Hệ Với Chúng Tôi</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end banner inner -->

     <!-- contact -->
      <div class="contact">
         <div class="container">
            <!-- Hiển thị thông báo trạng thái gửi (nếu có) -->
            <div class="row">
               <div class="col-md-12">
                  <c:if test="${not empty sessionScope.message}">
                     <div class="alert alert-info alert-dismissible fade show text-center" role="alert">
                         ${sessionScope.message}
                         <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                     </div>
                     <% session.removeAttribute("message"); %>
                  </c:if>
               </div>
            </div>

            <div class="row">
               <div class="col-md-6">
                  <!-- ĐÃ SỬA: Thêm action trỏ về Servlet /gui-lien-he và method="POST" -->
                  <form id="request" class="main_form" action="${pageContext.request.contextPath}/gui-lien-he" method="POST">
                      <div class="row">
                         <div class="col-md-12">
                            <!-- ĐÃ SỬA: Đổi name thành hoTen để khớp với Backend -->
                            <input class="contactus" placeholder="Họ và tên" type="text" name="hoTen" required> 
                         </div>
                         <div class="col-md-12">
                            <!-- ĐÃ SỬA: Đổi name thành email -->
                            <input class="contactus" placeholder="Email" type="email" name="email"> 
                         </div>
                         <div class="col-md-12">
                            <!-- ĐÃ SỬA: Đổi name thành sdt -->
                            <input class="contactus" placeholder="Số điện thoại" type="text" name="sdt" required>         
                         </div>
                         <div class="col-md-12">
                            <!-- ĐÃ SỬA: Đổi name thành noiDung -->
                            <textarea class="textarea" placeholder="Nội dung lời nhắn" name="noiDung" required></textarea>
                         </div>
                         <div class="col-md-12">
                            <button class="send_btn" type="submit">Gửi</button>
                         </div>
                      </div>
                  </form>
               </div>
               <div class="col-md-6">
                  <div class="map_main">
                     <div class="map-responsive">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.419813388276!2d106.678810974805!3d10.77912348936983!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f261d27435d%3A0x48f683d896fb00cd!2sMjUyIEzDvSBDaMOtbmggVGjhuq9uZywgTmhpw6p1IEzhu5ljLCBI4buTIENow60gTWluaCwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1790171015489!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="strict-origin-when-cross-origin"></iframe>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end contact -->
        <!-- 8. Nhúng Footer (Nằm trong thư mục layout) -->
        <jsp:include page="/layout/footer.jsp" />

        <!-- Javascript files-->
        <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery-3.0.0.min.js"></script>
        <!-- sidebar -->
        <script src="${pageContext.request.contextPath}/js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js"></script>

        <script>
            // Kích hoạt bảng lịch cho tất cả các ô input có class là .online_book
            flatpickr(".online_book", {
                dateFormat: "d/m/Y", // Định dạng ngày/tháng/năm
                allowInput: true, // Cho phép gõ tay trực tiếp nếu muốn
               
            });
        </script>
    </body>
</html>
