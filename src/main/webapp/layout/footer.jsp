<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--  footer -->
<footer>
   <div class="footer">
      <div class="container">
         <div class="row">
            <div class=" col-md-4">
               <h3>Thông tin liên hệ</h3>
               <ul class="conta">
                  <li><i class="fa fa-map-marker" aria-hidden="true"></i> TP. Hồ Chí Minh, Việt Nam</li>
                  <li><i class="fa fa-mobile" aria-hidden="true"></i> +84 123 456 789</li>
                  <li> <i class="fa fa-envelope" aria-hidden="true"></i><a href="#"> quanlyphongtro@gmail.com</a></li>
               </ul>
            </div>
            <div class="col-md-4">
               <h3>Danh mục chính</h3>
               <ul class="link_menu">
                  <li class="active"><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                  <li><a href="${pageContext.request.contextPath}/view/about.jsp">Giới thiệu</a></li>
                  <li><a href="${pageContext.request.contextPath}/view/room.jsp">Phòng cho thuê</a></li>
                  <li><a href="${pageContext.request.contextPath}/view/gallery.jsp">Thư viện ảnh</a></li>
                  <li><a href="${pageContext.request.contextPath}/view/blog.jsp">Tin tức</a></li>
                  <li><a href="${pageContext.request.contextPath}/view/contact.jsp">Liên hệ</a></li>
               </ul>
            </div>
            <div class="col-md-4">
               <h3>Đăng ký nhận tin</h3>
               <form class="bottom_form">
                  <input class="enter" placeholder="Nhập email của bạn" type="text" name="email">
                  <button class="sub_btn">Đăng ký</button>
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