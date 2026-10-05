<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Trang Quản Trị - Hệ Thống Khách Sạn</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .admin-wrapper {
                display: flex;
                width: 100%;
                min-height: 100vh;
            }
            .admin-content {
                flex: 1;
                margin-left: 250px;
                padding: 30px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .admin-content .logo_section {
                flex: 0 0 18% !important;
                max-width: 18% !important;
            }
            .admin-content .col-xl-10 {
                flex: 0 0 82% !important;
                max-width: 82% !important;
            }
            .admin-content .navbar-nav {
                display: flex;
                flex-direction: row;
                align-items: center;
                justify-content: flex-end;
            }

            @media (max-width: 768px) {
                .admin-content {
                    margin-left: 0;
                }

            }
        </style>
    </head>
    <body>

        <div class="admin-wrapper">


            <jsp:include page="layout/slidebar.jsp" />


            <div class="admin-content">
                <div class="mb-4">
                    <jsp:include page="/layout/navbar.jsp" />
                </div>

                <div class="container-fluid bg-white p-4 rounded shadow-sm mb-4">
                    <jsp:include page="${not empty contentPage ? 'view/'.concat(contentPage) : 'view/admin_room.jsp'}" />
                </div>


                <jsp:include page="layout/footer.jsp" />
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>