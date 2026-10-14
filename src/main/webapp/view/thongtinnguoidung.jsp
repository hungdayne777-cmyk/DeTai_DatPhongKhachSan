<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Tin Cá Nhân & Đổi Mật Khẩu</title>

    <!-- Các file CSS nền tảng & giao diện chuẩn của template -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">

    <style>
        body { background-color: #f4f6f9; }
        .profile-card {
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            padding: 30px;
            margin-top: 30px;
            margin-bottom: 50px;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid #ff3333;
            object-fit: cover;
        }
        .btn-update {
            background-color: #ff3333;
            color: #fff;
            font-weight: bold;
            border-radius: 20px;
            padding: 8px 25px;
            border: none;
        }
        .btn-update:hover { background-color: #cc0000; color: #fff; }
    </style>
</head>
<body>

    <!-- Nhúng Header / Navbar -->
    <jsp:include page="/layout/navbar.jsp" />

    <div class="container my-4">
        <div class="profile-card">
            <div class="row">
                
                <!-- Cột trái: Avatar -->
                <div class="col-md-4 text-center border-right">
                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="profile-avatar mb-3" alt="Avatar">
                    <h4 class="font-weight-bold text-dark">${sessionScope.acc.username}</h4>
                    <p class="text-muted">Khách hàng</p>
                </div>

                <!-- Cột phải: Form nhập liệu & Đổi mật khẩu -->
                <div class="col-md-8">
                    <c:if test="${not empty message}">
                        <div class="alert alert-info">${message}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/AccountServlet" method="POST">
                        <h4 class="text-danger font-weight-bold mb-3">THÔNG TIN CÁ NHÂN</h4>

                        <div class="form-group mb-3">
                            <label class="font-weight-bold text-dark">Tên đăng nhập (Cố định):</label>
                            <input type="text" class="form-control" name="username" value="${sessionScope.acc.username}" readonly style="background-color: #e9ecef; cursor: not-allowed;">
                        </div>

                        <div class="form-group mb-3">
                            <label class="font-weight-bold text-dark">Họ và tên người dùng:</label>
                            <input type="text" class="form-control" name="fullname" value="${sessionScope.acc.fullname}">
                        </div>

                        <div class="form-row row">
                            <div class="form-group col-md-6 mb-3">
                                <label class="font-weight-bold text-dark">Số điện thoại người dùng:</label>
                                <input type="text" class="form-control" name="phone" value="${sessionScope.acc.phone}">
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <label class="font-weight-bold text-dark">Gmail:</label>
                                <input type="email" class="form-control" name="email" value="${sessionScope.acc.email}">
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <label class="font-weight-bold text-dark">Địa chỉ:</label>
                            <input type="text" class="form-control" name="address" value="${sessionScope.acc.address}">
                        </div>

                        <hr class="my-4">

                        <h4 class="text-danger font-weight-bold mb-3">ĐỔI MẬT KHẨU</h4>

                        <div class="form-group mb-3">
                            <label class="font-weight-bold text-dark">Mật khẩu hiện tại:</label>
                            <input type="password" class="form-control" name="oldPassword">
                        </div>

                        <div class="form-row row">
                            <div class="form-group col-md-6 mb-3">
                                <label class="font-weight-bold text-dark">Mật khẩu mới:</label>
                                <input type="password" class="form-control" name="newPassword">
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <label class="font-weight-bold text-dark">Xác nhận mật khẩu mới:</label>
                                <input type="password" class="form-control" name="confirmPassword">
                            </div>
                        </div>

                        <div class="text-right mt-4">
                            <a href="${pageContext.request.contextPath}/Trang-chu" class="btn btn-secondary mr-2" style="border-radius: 20px; padding: 8px 20px;">
                                Trang chủ
                            </a>
                            <button type="submit" class="btn btn-update">
                                Cập Nhật Thông Tin
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <!-- Nhúng Footer -->
    <jsp:include page="/layout/footer.jsp" />

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>