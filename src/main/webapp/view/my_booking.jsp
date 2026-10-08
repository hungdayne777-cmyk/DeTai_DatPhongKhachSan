<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch Sử Đặt Phòng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function confirmCancel(maDP, trangThai) {
            let msg = "";
            // Kiểm tra trạng thái để hiển thị thông báo phù hợp
            if (trangThai.trim() === 'Đã xác nhận' || trangThai.trim() === '1') {
                msg = "⚠️ Đơn phòng này ĐÃ ĐƯỢC XÁC NHẬN!\nNếu hủy, bạn SẼ BỊ PHẠT CỌC.\nBạn có chắc chắn muốn hủy không?";
            } else if (trangThai.trim() === 'Chờ xác nhận' || trangThai.trim() === '0') {
                msg = "ℹ️ Đơn phòng đang CHỜ XÁC NHẬN.\nNếu hủy, bạn SẼ ĐƯỢC HOÀN CỌC 100%.\nBạn có chắc chắn muốn hủy không?";
            } else {
                msg = "Bạn có chắc chắn muốn hủy đơn đặt phòng này không?";
            }
            
            if (confirm(msg)) {
                window.location.href = '${pageContext.request.contextPath}/cancel-booking?maDP=' + maDP;
            }
        }
    </script>
</head>
<body class="bg-light">
    <div class="container my-5">
        <h2 class="text-center mb-4 fw-bold text-danger">Tình Trạng Xử Lý Đặt Phòng Của Bạn</h2>
        
        <!-- Hiển thị thông báo thành công hoặc lỗi -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("message"); %>
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("errorMessage"); %>
        </c:if>

        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Mã ĐP</th>
                            <th>Tên Phòng</th>
                            <th>Ngày Đặt</th>
                            <th>Ngày Nhận</th>
                            <th>Ngày Trả</th>
                            <th>Tổng Tiền</th>
                            <th>Tình Trạng Xử Lý</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty myBookings}">
                            <tr>
                                <td colspan="8" class="text-center text-muted py-4">Bạn chưa có đơn đặt phòng nào.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="b" items="${myBookings}">
                            <tr>
                                <td class="fw-bold">${b.maDP}</td>
                                <td>${b.tenPhong}</td>
                                <td>${b.ngayDat}</td>
                                <td>${b.ngayNhan}</td>
                                <td>${b.ngayTra}</td>
                                <td style="color: red; font-weight: bold;">
                                    <fmt:formatNumber value="${b.tongTien}" type="number" groupingUsed="true"/> VNĐ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${b.trangThai == 'Chờ xác nhận' || b.trangThai == '0'}">
                                            <span class="badge bg-warning text-dark">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${b.trangThai == 'Đã xác nhận' || b.trangThai == '1'}">
                                            <span class="badge bg-info text-dark">Đã xác nhận</span>
                                        </c:when>
                                        <c:when test="${b.trangThai == 'Đã thuê'}">
                                            <span class="badge bg-primary">Đang sử dụng</span>
                                        </c:when>
                                        <c:when test="${b.trangThai == 'Hoàn thành'}">
                                            <span class="badge bg-success">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${b.trangThai == 'Đã hủy'}">
                                            <span class="badge bg-danger">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${b.trangThai}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <!-- Chỉ hiển thị nút hủy nếu đơn chưa bị hủy và chưa hoàn thành -->
                                    <c:if test="${b.trangThai != 'Đã hủy' && b.trangThai != 'Hoàn thành' && b.trangThai != 'Đã thuê'}">
                                        <button type="button" class="btn btn-outline-danger btn-sm" 
                                                onclick="confirmCancel('${b.maDP}', '${b.trangThai}')">
                                            Hủy phòng
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary mt-3">Quay về trang chủ</a>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>