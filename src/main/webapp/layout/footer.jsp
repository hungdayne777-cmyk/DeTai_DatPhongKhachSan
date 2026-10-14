<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- footer -->
<footer>
   <div class="footer">
      <div class="container">
         <div class="row">
            <div class="col-md-4">
               <h3>Thông tin liên hệ</h3>
               <ul class="conta">
                  <li><i class="fa fa-map-marker" aria-hidden="true"></i> TP. Hồ Chí Minh, Việt Nam</li>
                  <li><i class="fa fa-mobile" aria-hidden="true"></i> +84 123 456 789</li>
                  <li><i class="fa fa-envelope" aria-hidden="true"></i><a href="mailto:quanlyphongtro@gmail.com"> quanlyphongtro@gmail.com</a></li>
               </ul>
            </div>
            
            <div class="col-md-4">
               <h3>Danh mục chính</h3>
               <ul class="link_menu">
                  <!-- Cập nhật đường dẫn trỏ về Servlet Controller đồng bộ với navbar -->
                  <li><a href="${pageContext.request.contextPath}/Trang-chu">Trang chủ</a></li>
                  <li><a href="${pageContext.request.contextPath}/GioiThieu">Giới thiệu</a></li>
                  <li><a href="${pageContext.request.contextPath}/room">Phòng cho thuê</a></li>
                  <li><a href="${pageContext.request.contextPath}/ThuVien">Thư viện ảnh</a></li>
                  <li><a href="${pageContext.request.contextPath}/TinTuc">Tin tức</a></li>
                  <li><a href="${pageContext.request.contextPath}/gui-lien-he">Liên hệ</a></li>
               </ul>
            </div>
            
            <div class="col-md-4">
               <h3>Đăng ký nhận tin</h3>
               <form class="bottom_form" action="#" method="POST">
                  <input class="enter" placeholder="Nhập email của bạn" type="email" name="email" required>
                  <button class="sub_btn" type="submit">Đăng ký</button>
               </form>
               <ul class="social_icon">
                  <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                  <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                  <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                  <li><a href="#"><i class="fa fa-youtube-play" aria-hidden="true"></i></a></li>
               </ul>
            </div>
         </div>
      </div>
      
      <div class="copyright">
         <div class="container">
            <div class="row">
               <div class="col-md-10 offset-md-1">
                  <p>
                     © 2026 Hệ thống Quản lý Phòng trọ. Bản quyền thuộc về THÁI HƯNG & TẤN TÀI.
                     <br><br>
                     Phát triển phục vụ đồ án / dự án cá nhân.
                  </p>
               </div>
            </div>
         </div>
      </div>
   </div>
</footer>
<!-- end footer -->