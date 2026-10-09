<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Đăng ký tài khoản - Quản lý Khách Sạn</title>
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
        <link rel="icon" href="${pageContext.request.contextPath}/images/fevicon.png" type="image/gif" />
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">

        <style>
            body.main-layout.inner_page {
                background: url('${pageContext.request.contextPath}/images/hotel-bg.jpg') no-repeat center center fixed !important;
                background-size: cover !important;
                position: relative;
                min-height: 100vh;
                overflow-x: hidden;
            }
            body.main-layout.inner_page::before {
                content: "";
                position: absolute;
                top: 0; left: 0; width: 100%; height: 100%;
                background: rgba(0, 0, 0, 0.45);
                z-index: -1;
            }
            .back_re { display: none !important; }
            .glass-login-container {
                min-height: 85vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 0;
            }
            .glass-card {
                position: relative;
                width: 100%;
                max-width: 480px;
                padding: 35px;
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
                padding: 10px 15px !important;
                margin-bottom: 12px !important;
                width: 100% !important;
                font-size: 14px !important;
            }
            .glass-card .contactus::placeholder { color: rgba(255, 255, 255, 0.5) !important; }
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
            }
            .glass-card .send_btn:hover {
                background: rgba(255, 255, 255, 0.35) !important;
                box-shadow: 0 0 15px rgba(255, 255, 255, 0.4);
            }
            .glass-card h3 { color: #fff !important; font-weight: 700 !important; font-size: 24px !important; }
            .glass-card p { color: rgba(255, 255, 255, 0.7) !important; font-size: 14px; }
            .login-link { color: #ffb74d; text-decoration: none; font-weight: 500; }
            .login-link:hover { color: #ffa726; text-decoration: underline; }
        </style>
    </head>
    
    <body class="main-layout inner_page">
        <div class="loader_bg">
            <div class="loader"><img src="${pageContext.request.contextPath}/images/loading.gif" alt="#"/></div>
        </div>

        <jsp:include page="/layout/navbar.jsp" />

        <div class="container glass-login-container">
            <div class="glass-card">
                <div class="glow-circle-1"></div>
                <div class="glow-circle-2"></div>

                <form class="main_form" action="${pageContext.request.contextPath}/register" method="post">
                    <div class="row">
                        <div class="col-md-12 text-center mb-3">
                            <h3>Đăng Ký Tài Khoản</h3>
                            <p>Tạo tài khoản khách mới và hồ sơ cá nhân</p>
                        </div>

                        <% if (request.getAttribute("error") != null) { %>
                        <div class="col-md-12">
                            <div class="alert alert-danger py-2 bg-danger text-white border-0 rounded-3 mb-3 text-center" role="alert" style="font-size: 13px;">
                                <%= request.getAttribute("error") %>
                            </div>
                        </div>
                        <% } %>

                        <div class="col-md-12">
                            <input class="contactus" placeholder="Tên đăng nhập" type="text" name="username" required autocomplete="off"> 
                        </div>
                        <div class="col-md-6">
                            <input class="contactus" placeholder="Mật khẩu" type="password" name="password" required>         
                        </div>
                        <div class="col-md-6">
                            <input class="contactus" placeholder="Nhập lại mật khẩu" type="password" name="re_password" required>         
                        </div>
                        <div class="col-md-12">
                            <input class="contactus" placeholder="Họ và tên" type="text" name="hoTen" required autocomplete="off"> 
                        </div>
                        <div class="col-md-12">
                            <input class="contactus" placeholder="Số điện thoại" type="text" name="sdt" required autocomplete="off"> 
                        </div>
                        <div class="col-md-12">
                            <input class="contactus" placeholder="Email" type="email" name="email" required autocomplete="off"> 
                        </div>
                        <div class="col-md-12">
                            <input class="contactus" placeholder="Địa chỉ" type="text" name="diachi" required autocomplete="off"> 
                        </div>
                        
                        <div class="col-md-12 text-center mb-3 mt-2">
                            <button class="send_btn" type="submit">Đăng Ký</button>
                        </div>

                        <div class="col-md-12 text-center">
                            <p style="font-size: 13px;">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="login-link">Đăng nhập ngay</a></p>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="/layout/footer.jsp" />

        <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    </body>
</html>