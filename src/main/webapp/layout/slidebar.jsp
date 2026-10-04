<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* Làm nổi bật tiêu đề Admin */
    .sidebar-heading, .admin-title {
        font-weight: bold !important;
        font-size: 1.25rem !important;
        color: #ffffff !important;
        text-transform: uppercase;
        letter-spacing: 1px;
        padding: 20px 15px;
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }
    /* Làm cho các chữ trong menu sidebar rõ nét hơn */
    .sidebar a, .list-group-item {
        font-weight: 500;
        font-size: 1rem;
    }

    /* HIỆU ỨNG HOVER MƯỢT MÀ CHO SIDEBAR */
    .sidebar .nav-link {
        transition: all 0.3s ease-in-out; /* Tạo độ mượt khi chuyển màu/dịch chuyển */
        border-radius: 6px;
    }
    .sidebar .nav-link:hover {
        background-color: #e03727 !important; /* Màu nền khi rê chuột */
        color: #ffffff !important;
        transform: translateX(6px); /* Dịch chuyển nhẹ sang phải tạo cảm giác sinh động */
    }
</style>

<!-- Sidebar Admin -->
<div class="sidebar bg-dark text-white p-3" style="width: 250px; min-height: 100vh; position: fixed; top: 0; left: 0;">
    <h3 class="text-center py-3 border-bottom text-white">Admin QLKS</h3>
    <ul class="nav flex-column nav-pills">
        <li class="nav-item mb-2">
            <a href="${pageContext.request.contextPath}/admin/overview" class="nav-link text-white ${pageContext.request.requestURI.contains('overview') ? 'active bg-primary' : ''}">
                📊 Tổng Quan
            </a>
        </li>
        <li class="nav-item mb-2">
            <a href="${pageContext.request.contextPath}/admin/room?action=list" 
               class="nav-link text-white ${pageContext.request.requestURI.contains('room') ? 'active bg-primary' : ''}">
                🛏️ Quản Lý Phòng
            </a>
        </li>
        <li class="nav-item mb-2">
            <a href="${pageContext.request.contextPath}/admin/adminloaiphong?action=list" class="nav-link text-white ${pageContext.request.requestURI.contains('adminloaiphong') ? 'active bg-primary' : ''}">
                🏷️ Quản Lý Loại Phòng
            </a>
        </li>
        <li class="nav-item mb-2">
            <a href="${pageContext.request.contextPath}/admin/customer-manage" class="nav-link text-white ${pageContext.request.requestURI.contains('customer-manage') ? 'active bg-primary' : ''}">
                👥 Quản Lý Khách Hàng
            </a>
        </li>
        <li class="nav-item mb-2">
            <a href="${pageContext.request.contextPath}/admin/booking-manage" class="nav-link text-white ${pageContext.request.requestURI.contains('booking-manage') ? 'active bg-primary' : ''}">
                📅 Quản Lý Đặt Phòng
            </a>
        </li>
        <!-- Mục Quản Lý Liên Hệ mới thêm vào -->
        <li class="nav-item mb-2">
            <a href="${pageContext.request.contextPath}/admin/lien-he" class="nav-link text-white ${pageContext.request.requestURI.contains('lien-he') ? 'active bg-primary' : ''}">
                ✉️ Quản Lý Liên Hệ
            </a>
        </li>
        <li class="nav-item mb-2">
            <a href="${pageContext.request.contextPath}/admin/accounts" 
               class="nav-link text-white ${pageContext.request.requestURI.contains('accounts') ? 'active bg-primary' : ''}">
                🛡️ Quản Lý Tài Khoản
            </a>
        </li>
    </ul>
</div>