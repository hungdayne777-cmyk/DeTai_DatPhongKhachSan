<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
      <title>Liên hệ - Đặt Phòng Khách Sạn</title>
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
            <!-- Hiển thị thông báo trạng thái gửi -->
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
                  <!-- Đã cấu hình action trỏ về Servlet và name chuẩn khớp backend -->
                 <form id="request" class="main_form" action="${pageContext.request.contextPath}/gui-lien-he" method="POST">
                     <div class="row">
                        <div class="col-md-12">
                           <input class="contactus" placeholder="Họ và tên" type="text" name="hoTen" required> 
                        </div>
                        <div class="col-md-12">
                           <input class="contactus" placeholder="Email" type="email" name="email"> 
                        </div>
                        <div class="col-md-12">
                           <input class="contactus" placeholder="Số điện thoại" type="text" name="sdt" required>         
                        </div>
                        <div class="col-md-12">
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