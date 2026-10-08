<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .navigation.navbar-dark .navbar-nav .nav-link {
        white-space: nowrap;
        padding-left: 8px !important;
        padding-right: 8px !important;
        font-size: 13.5px;
    }
    
    .logo img {
        max-height: 45px;
        width: auto;
    }

    .navbar-nav .nav-item:first-child {
        margin-left: 25px;
    }
</style>

<!-- header -->
<header>
    <!-- header inner -->
    <div class="header">
        <div class="container">
            <div class="row align-items-center">
                
                <!-- CHỈ HIỂN THỊ LOGO KHI: CHƯA ĐĂNG NHẬP HOẶC LÀ ADMIN (role == 1) -->
                <c:if test="${empty sessionScope.acc || sessionScope.acc.role == 1}">
                    <div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col logo_section">
                        <div class="full">
                            <div class="center-desk">
                                <div class="logo">
                                    <a href="${pageContext.request.contextPath}/Trang-chu"><img src="${pageContext.request.contextPath}/images/logo.png" alt="#" /></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Cột menu: Nếu là khách thường (ẩn logo) thì chiếm trọn col-12, ngược lại chiếm col-xl-10 -->
                <div class="${(empty sessionScope.acc || sessionScope.acc.role == 1) ? 'col-xl-10 col-lg-10 col-md-10 col-sm-10' : 'col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12'}">
                    <nav class="navigation navbar navbar-expand-md navbar-dark ">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse ${(not empty sessionScope.acc && sessionScope.acc.role != 1) ? 'justify-content-end' : ''}" id="navbarsExample04">
                            <ul class="navbar-nav ${(not empty sessionScope.acc && sessionScope.acc.role != 1) ? 'ml-auto' : 'mr-auto'}">
                                <li class="nav-item ">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/Trang-chu">Trang chủ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/GioiThieu">Giới thiệu</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/room">Phòng cho thuê</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/ThuVien">Thư viện ảnh</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/TinTuc">Tin tức</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/gui-lien-he">Liên hệ</a>
                                </li>

                                <!-- Nếu CHƯA ĐĂNG NHẬP (Session acc trống) -->
                                <c:if test="${empty sessionScope.acc}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                            <i class="fa fa-user" aria-hidden="true"></i> ĐĂNG NHẬP
                                        </a>
                                    </li>
                                </c:if>

                                <!-- Nếu ĐÃ ĐĂNG NHẬP -->
                                <c:if test="${not empty sessionScope.acc}">
                                    
                                    <!-- CHỈ HIỂN THỊ NẾU KHÔNG PHẢI ADMIN -->
                                    <c:if test="${sessionScope.acc.role != 1}">
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/my-booking">
                                                <i class="fa fa-bookmark" aria-hidden="true"></i> PHÒNG CỦA TÔI
                                            </a>
                                        </li>
                                    </c:if>

                                    <li class="nav-item">
                                        <a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/logout">
                                            <i class="fa fa-sign-out-alt me-1"></i> ĐĂNG XUẤT (${sessionScope.acc.username})
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const currentPath = window.location.pathname;
        const menuLinks = document.querySelectorAll('.navbar-nav .nav-link');

        menuLinks.forEach(link => {
            const linkHref = link.getAttribute('href');
            if (linkHref && currentPath.includes(linkHref)) {
                link.classList.add('active');
            }
        });
    });
</script>
<!-- end header inner -->
<!-- end header -->