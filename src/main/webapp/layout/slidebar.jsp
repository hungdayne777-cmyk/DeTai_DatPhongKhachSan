<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    :root {
        --sidebar-bg: #0b0b0f;
        --sidebar-glass: rgba(255, 255, 255, 0.035);
        --sidebar-border: rgba(255, 255, 255, 0.09);
        --sidebar-red: #ff304f;
        --sidebar-red-dark: #b5122b;
        --sidebar-red-glow: rgba(255, 48, 79, 0.20);
        --sidebar-text: #b5b5c0;
        --sidebar-muted: #777783;
        --sidebar-width: 260px;
    }

    /* ===== SIDEBAR CỐ ĐỊNH BÊN TRÁI (MẶC ĐỊNH CHO MÁY TÍNH) ===== */
    .sidebar-modern {
        position: fixed;
        top: 0;
        left: 0;
        bottom: 0;
        z-index: 1050;

        display: flex;
        flex-direction: column;

        width: var(--sidebar-width);
        min-width: var(--sidebar-width);
        height: 100vh;
        min-height: 100vh;

        box-sizing: border-box;

        background:
            radial-gradient(
                circle at 0% 0%,
                rgba(255, 48, 79, 0.13),
                transparent 38%
            ),
            linear-gradient(
                180deg,
                rgba(18, 18, 24, 0.97),
                rgba(9, 9, 13, 0.99)
            );

        border-right: 1px solid var(--sidebar-border);

        box-shadow:
            10px 0 35px rgba(0, 0, 0, 0.25),
            inset -1px 0 rgba(255, 255, 255, 0.015);

        backdrop-filter: blur(22px);
        -webkit-backdrop-filter: blur(22px);

        font-family: 'Inter', 'Segoe UI', sans-serif;
        overflow-x: hidden;
        overflow-y: auto;

        scrollbar-width: thin;
        scrollbar-color: #39303a transparent;
        transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .sidebar-modern *,
    .sidebar-modern *::before,
    .sidebar-modern *::after {
        box-sizing: border-box;
    }

    /* ===== LOGO / BRAND ===== */
    .sidebar-modern .sidebar-brand {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;

        min-height: 86px;
        flex-shrink: 0;
        padding: 20px 14px;

        color: #fff;
        font-size: 18px;
        font-weight: 800;
        letter-spacing: 1px;
        text-transform: uppercase;
        text-decoration: none;

        border-bottom: 1px solid var(--sidebar-border);

        background: linear-gradient(
            180deg,
            rgba(255, 48, 79, 0.10),
            rgba(255, 48, 79, 0.015)
        );
    }

    .sidebar-modern .brand-icon {
        display: flex;
        align-items: center;
        justify-content: center;

        width: 42px;
        height: 42px;
        flex-shrink: 0;

        border-radius: 13px;
        color: #fff;
        font-size: 20px;

        background: linear-gradient(
            135deg,
            var(--sidebar-red),
            var(--sidebar-red-dark)
        );

        box-shadow: 0 5px 20px var(--sidebar-red-glow);
    }

    .sidebar-modern .brand-text {
        line-height: 1.2;
    }

    .sidebar-modern .brand-text span {
        display: block;
        margin-top: 5px;

        color: var(--sidebar-muted);
        font-size: 10px;
        font-weight: 600;
        letter-spacing: 2.5px;
    }

    /* ===== NHÃN MENU ===== */
    .sidebar-modern .sidebar-section {
        flex-shrink: 0;
        padding: 25px 22px 10px;

        color: #666672;
        font-size: 10px;
        font-weight: 800;
        letter-spacing: 1.8px;
        text-transform: uppercase;
    }

    /* ===== DANH SÁCH MENU ===== */
    .sidebar-modern .nav {
        display: flex;
        flex-direction: column;
        gap: 7px;

        width: 100%;
        padding: 8px 12px 24px;
        margin: 0;

        list-style: none;
    }

    .sidebar-modern .nav-item {
        width: 100%;
        margin: 0;
    }

    .sidebar-modern .nav-link {
        position: relative;

        display: flex;
        align-items: center;
        gap: 13px;

        width: 100%;
        min-height: 48px;
        padding: 12px 14px;

        color: var(--sidebar-text) !important;
        font-size: 13px;
        font-weight: 550;
        line-height: 1.5;
        text-decoration: none;

        background: transparent !important;
        border: 1px solid transparent;
        border-radius: 12px;

        transition:
            color .25s ease,
            background .25s ease,
            border-color .25s ease,
            transform .25s ease,
            box-shadow .25s ease;
    }

    .sidebar-modern .menu-icon {
        display: flex;
        align-items: center;
        justify-content: center;

        width: 24px;
        height: 24px;
        flex-shrink: 0;

        color: #92929e;
        font-size: 17px;

        transition: color .25s ease, transform .25s ease;
    }

    .sidebar-modern .menu-text {
        flex: 1;
        min-width: 0;
    }

    /* ===== HOVER ===== */
    .sidebar-modern .nav-link:hover {
        color: #fff !important;
        background: rgba(255, 48, 79, 0.075) !important;
        border-color: rgba(255, 48, 79, 0.15);
        transform: translateX(3px);
    }

    .sidebar-modern .nav-link:hover .menu-icon {
        color: #ff667d;
        transform: scale(1.08);
    }

    /* ===== MENU Đang ĐƯỢC CHỌN ===== */
    .sidebar-modern .nav-link.active {
        color: #fff !important;
        font-weight: 700;

        background: linear-gradient(
            110deg,
            rgba(255, 48, 79, 0.23),
            rgba(181, 18, 43, 0.10)
        ) !important;

        border-color: rgba(255, 48, 79, 0.27);

        box-shadow:
            0 5px 18px rgba(0, 0, 0, 0.12),
            inset 0 0 20px rgba(255, 48, 79, 0.025);

        transform: none;
    }

    .sidebar-modern .nav-link.active::before {
        content: "";
        position: absolute;
        left: -1px;
        top: 10px;
        bottom: 10px;

        width: 3px;
        border-radius: 0 4px 4px 0;

        background: var(--sidebar-red);
        box-shadow: 0 0 12px var(--sidebar-red-glow);
    }

    .sidebar-modern .nav-link.active .menu-icon {
        color: #ff526b;
        filter: drop-shadow(0 0 5px rgba(255, 48, 79, 0.2));
    }

    /* ===== CHÂN SIDEBAR ===== */
    .sidebar-modern .sidebar-footer {
        margin-top: auto;
        flex-shrink: 0;
        padding: 16px 14px 20px;
        border-top: 1px solid var(--sidebar-border);
    }

    .sidebar-modern .admin-status {
        display: flex;
        align-items: center;
        gap: 11px;

        padding: 13px;

        border: 1px solid var(--sidebar-border);
        border-radius: 13px;

        background: rgba(255, 255, 255, 0.025);
    }

    .sidebar-modern .admin-avatar {
        display: flex;
        align-items: center;
        justify-content: center;

        width: 37px;
        height: 37px;
        flex-shrink: 0;

        color: white;
        font-size: 15px;
        border-radius: 11px;

        background: linear-gradient(
            135deg,
            var(--sidebar-red),
            var(--sidebar-red-dark)
        );
    }

    .sidebar-modern .admin-info {
        min-width: 0;
    }

    .sidebar-modern .admin-name {
        color: #f4f4f5;
        font-size: 12px;
        font-weight: 700;
    }

    .sidebar-modern .admin-role {
        display: flex;
        align-items: center;
        gap: 6px;

        margin-top: 4px;
        color: var(--sidebar-muted);
        font-size: 10px;
    }

    .sidebar-modern .status-dot {
        width: 6px;
        height: 6px;
        flex-shrink: 0;
        border-radius: 50%;

        background: #4ade80;
        box-shadow: 0 0 8px rgba(74, 222, 128, 0.4);
    }

    /* ===== NÚT HAMBURGER (MẶC ĐỊNH ẨN TRÊN MÁY TÍNH) ===== */
    .mobile-sidebar-toggle {
        display: none;
        position: fixed;
        top: 15px;
        left: 15px;
        z-index: 1060;
        background: #121218;
        color: #fff;
        border: 1px solid var(--sidebar-border);
        padding: 8px 12px;
        border-radius: 8px;
        font-size: 18px;
        cursor: pointer;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
    }

    /* ===== LỚP PHỦ MÀN HÌNH (OVERLAY) ===== */
    .sidebar-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(2px);
        z-index: 1040;
    }
    .sidebar-overlay.show {
        display: block;
    }

    /* ===== RESPONSIVE CHO IPHONE & MÀN HÌNH NHỎ (<= 991px) ===== */
    @media (max-width: 991.98px) {
        .mobile-sidebar-toggle {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .sidebar-modern {
            transform: translateX(-100%); /* Trên điện thoại thì ẩn sang trái mặc định */
        }

        .sidebar-modern.show {
            transform: translateX(0); /* Trượt ra khi bấm nút 3 gạch */
        }
    }

    @media (prefers-reduced-motion: reduce) {
        .sidebar-modern *,
        .sidebar-modern *::before,
        .sidebar-modern *::after {
            transition: none !important;
        }
    }
</style>

<!-- NÚT BẤM 3 GẠCH TRÊN ĐIỆN THOẠI -->
<button class="mobile-sidebar-toggle" id="sidebarToggleBtn" aria-label="Toggle Sidebar">
    <i class="fas fa-bars"></i>
</button>

<!-- LỚP PHỦ MỜ KHI MỞ MENU -->
<div class="sidebar-overlay" id="sidebarOverlay"></div>

<!-- SIDEBAR QUẢN TRỊ -->
<aside class="sidebar-modern" id="modernSidebar">

    <!-- Logo -->
    <a href="${pageContext.request.contextPath}/admin/overview"
       class="sidebar-brand">
        <span class="brand-icon">
            <i class="fas fa-fire"></i>
        </span>

        <span class="brand-text">
            Admin QLKS
            <span>HOTEL MANAGEMENT</span>
        </span>
    </a>

    <!-- Menu chính -->
    <div class="sidebar-section">Điều hướng chính</div>

    <ul class="nav">

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/overview"
               class="nav-link ${pageContext.request.requestURI.contains('overview') ? 'active' : ''}">
                <span class="menu-icon">
                    <i class="fas fa-chart-pie"></i>
                </span>
                <span class="menu-text">Tổng quan</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/room?action=list"
               class="nav-link ${pageContext.request.requestURI.contains('/room') ? 'active' : ''}">
                <span class="menu-icon">
                    <i class="fas fa-bed"></i>
                </span>
                <span class="menu-text">Quản lý phòng</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/adminloaiphong?action=list"
               class="nav-link ${pageContext.request.requestURI.contains('adminloaiphong') ? 'active' : ''}">
                <span class="menu-icon">
                    <i class="fas fa-layer-group"></i>
                </span>
                <span class="menu-text">Quản lý loại phòng</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/customer-manage"
               class="nav-link ${pageContext.request.requestURI.contains('customer-manage') ? 'active' : ''}">
                <span class="menu-icon">
                    <i class="fas fa-users"></i>
                </span>
                <span class="menu-text">Quản lý khách hàng</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/booking-manage"
               class="nav-link ${pageContext.request.requestURI.contains('booking-manage') ? 'active' : ''}">
                <span class="menu-icon">
                    <i class="fas fa-calendar-check"></i>
                </span>
                <span class="menu-text">Quản lý đặt phòng</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/lien-he"
               class="nav-link ${pageContext.request.requestURI.contains('lien-he') ? 'active' : ''}">
                <span class="menu-icon">
                    <i class="fas fa-envelope"></i>
                </span>
                <span class="menu-text">Quản lý liên hệ</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/accounts"
               class="nav-link ${pageContext.request.requestURI.contains('accounts') ? 'active' : ''}">
                <span class="menu-icon">
                    <i class="fas fa-shield-alt"></i>
                </span>
                <span class="menu-text">Quản lý tài khoản</span>
            </a>
        </li>

    </ul>

    <!-- Thông tin quản trị -->
    <div class="sidebar-footer">
        <div class="admin-status">
            <div class="admin-avatar">
                <i class="fas fa-user-shield"></i>
            </div>

            <div class="admin-info">
                <div class="admin-name">Quản trị viên</div>
                <div class="admin-role">
                    <span class="status-dot"></span>
                    Hệ thống đang hoạt động
                </div>
            </div>
        </div>
    </div>

</aside>

<!-- SCRIPT ĐIỀU KHIỂN ĐÓNG/MỞ SIDEBAR TRÊN ĐIỆN THOẠI -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggleBtn = document.getElementById("sidebarToggleBtn");
        const sidebar = document.getElementById("modernSidebar");
        const overlay = document.getElementById("sidebarOverlay");

        if (toggleBtn && sidebar && overlay) {
            // Bấm vào nút 3 gạch để bật/tắt sidebar
            toggleBtn.addEventListener("click", function () {
                sidebar.classList.toggle("show");
                overlay.classList.toggle("show");
            });

            // Bấm vào vùng tối bên ngoài để đóng sidebar
            overlay.addEventListener("click", function () {
                sidebar.classList.remove("show");
                overlay.classList.remove("show");
            });

            // Tự động đóng sidebar khi bấm chọn vào một link bất kỳ trong menu
            const navLinks = sidebar.querySelectorAll(".nav-link");
            navLinks.forEach(link => {
                link.addEventListener("click", function () {
                    if (window.innerWidth <= 991.98) {
                        sidebar.classList.remove("show");
                        overlay.classList.remove("show");
                    }
                });
            });
        }
    });
</script>