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
                            <th>Trạng Thái Cọc</th>
                            <th>Tình Trạng Xử Lý</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty myBookings}">
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">Bạn chưa có đơn đặt phòng nào.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="b" items="${myBookings}">
                            <tr>
                                <td class="fw-bold">${b.maDP}</td>
                                <td>${b.tenPhong}</td>
                                <td>
                                    <fmt:parseDate value="${b.ngayDat}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDat" parseLocale="vi_VN" />
                                    <c:if test="${empty parsedDat}">
                                        <fmt:parseDate value="${b.ngayDat}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDat" parseLocale="vi_VN" />
                                    </c:if>
                                    <fmt:formatDate value="${parsedDat}" pattern="dd/MM/yyyy HH:mm" />
                                </td>
                                <td>
                                    <fmt:parseDate value="${b.ngayNhan}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedNhan" parseLocale="vi_VN" />
                                    <c:if test="${empty parsedNhan}">
                                        <fmt:parseDate value="${b.ngayNhan}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedNhan" parseLocale="vi_VN" />
                                    </c:if>
                                    <c:if test="${empty parsedNhan}">
                                        <fmt:parseDate value="${b.ngayNhan}" pattern="yyyy-MM-dd" var="parsedNhan" parseLocale="vi_VN" />
                                    </c:if>
                                    <fmt:formatDate value="${parsedNhan}" pattern="dd/MM/yyyy" />
                                </td>
                                <td>
                                    <fmt:parseDate value="${b.ngayTra}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedTra" parseLocale="vi_VN" />
                                    <c:if test="${empty parsedTra}">
                                        <fmt:parseDate value="${b.ngayTra}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedTra" parseLocale="vi_VN" />
                                    </c:if>
                                    <c:if test="${empty parsedTra}">
                                        <fmt:parseDate value="${b.ngayTra}" pattern="yyyy-MM-dd" var="parsedTra" parseLocale="vi_VN" />
                                    </c:if>
                                    <fmt:formatDate value="${parsedTra}" pattern="dd/MM/yyyy" />
                                </td>
                                <td style="color: red; font-weight: bold;">
                                    <fmt:formatNumber value="${b.tongTien}" type="number" groupingUsed="true"/> VNĐ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${b.trangThaiCoc == 'Đã cọc'}">
                                            <span class="badge bg-success">Đã cọc</span>
                                        </c:when>
                                        <c:when test="${b.trangThaiCoc == 'Đã hoàn tiền'}">
                                            <span class="badge bg-info text-dark">Đã hoàn tiền</span>
                                        </c:when>
                                        <c:when test="${b.trangThaiCoc == 'Phạt Cọc'}">
                                            <span class="badge bg-danger">Phạt Cọc</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark">Chưa cập nhật</span>
                                        </c:otherwise>
                                    </c:choose>
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