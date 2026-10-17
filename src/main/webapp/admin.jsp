<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Trang Quản Trị - Hệ Thống Khách Sạn</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/bootstrap.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        /* =====================================
           GIAO DIỆN NỀN TỐI CHỈ CHO TRANG ADMIN
           ===================================== */

        body.admin-theme {
            background-color: #121212 !important;
            color: #f1f1f1;
            min-height: 100vh;
        }

        .admin-theme .admin-wrapper {
            display: flex;
            width: 100%;
            min-height: 100vh;
            background-color: #121212;
        }

        .admin-theme .admin-content {
            flex: 1;
            min-width: 0;
            margin-left: 250px;
            padding: 30px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background-color: #121212;
            color: #f1f1f1;
        }

        /* Khung chứa nội dung JSP */
        .admin-theme .admin-main-card {
            background-color: #1c1c1c !important;
            color: #f1f1f1;
            border: 1px solid #333;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
        }

        /* Tiêu đề và chữ bên trong */
        .admin-theme .admin-main-card h1,
        .admin-theme .admin-main-card h2,
        .admin-theme .admin-main-card h3,
        .admin-theme .admin-main-card h4,
        .admin-theme .admin-main-card h5,
        .admin-theme .admin-main-card h6 {
            color: #f1f1f1;
        }

        .admin-theme .admin-main-card p,
        .admin-theme .admin-main-card label {
            color: #ddd;
        }

        /* Đường phân cách */
        .admin-theme .admin-main-card .border-bottom,
        .admin-theme .admin-main-card .border-top {
            border-color: #383838 !important;
        }

        /* Các khung card con */
        .admin-theme .admin-main-card .card {
            background-color: #1c1c1c;
            color: #f1f1f1;
            border-color: #383838;
        }

        /* Các ô nhập liệu */
        .admin-theme .admin-main-card .form-control,
        .admin-theme .admin-main-card .form-select {
            background-color: #292929;
            color: #f1f1f1;
            border-color: #444;
        }

        .admin-theme .admin-main-card .form-control:focus,
        .admin-theme .admin-main-card .form-select:focus {
            background-color: #292929;
            color: #fff;
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.2);
        }

        .admin-theme .admin-main-card .form-control::placeholder {
            color: #999;
        }

        .admin-theme .admin-main-card .form-select option {
            background-color: #292929;
            color: #fff;
        }

        /* Bảng dữ liệu */
        .admin-theme .admin-main-card .table {
            --bs-table-bg: #1c1c1c;
            --bs-table-color: #f1f1f1;
            --bs-table-border-color: #383838;
            color: #f1f1f1;
        }

        /* Navbar bên trong khu vực admin */
        .admin-theme .admin-content .logo_section {
            flex: 0 0 18% !important;
            max-width: 18% !important;
        }

        .admin-theme .admin-content .col-xl-10 {
            flex: 0 0 82% !important;
            max-width: 82% !important;
        }

        .admin-theme .admin-content .navbar-nav {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: flex-end;
        }

        @media (max-width: 768px) {
            .admin-theme .admin-content {
                margin-left: 0;
                padding: 12px;
            }
        }
    </style>
</head>

<!-- Bật class admin-theme cho layout quản trị -->
<body class="admin-theme">

    <div class="admin-wrapper">

        <jsp:include page="layout/slidebar.jsp" />

        <div class="admin-content">

            <div class="mb-4">
                <jsp:include page="/layout/navbar.jsp" />
            </div>

            <!-- Khung nội dung đã đổi từ bg-white sang nền tối -->
            <div class="admin-main-card p-4 mb-4">
                <jsp:include page="${not empty contentPage ? 'view/'.concat(contentPage) : 'view/admin_room.jsp'}" />
            </div>

            <jsp:include page="layout/footer.jsp" />

        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

</body>
</html>