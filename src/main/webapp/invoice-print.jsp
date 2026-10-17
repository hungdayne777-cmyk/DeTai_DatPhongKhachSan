<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Hóa Đơn Thanh Toán - ${invoice.maDP}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        body { background: #eee; font-family: 'Times New Roman', Times, serif; }
        .invoice-box {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            border: 1px solid #eee;
            box-shadow: 0 0 10px rgba(0, 0, 0, .15);
            background: #fff;
            border-radius: 8px;
        }
        .invoice-header { border-bottom: 2px solid #333; padding-bottom: 15px; margin-bottom: 20px; }
        @media print {
            body { background: #fff; }
            .invoice-box { box-shadow: none; border: none; margin: 0; padding: 0; width: 100%; max-width: 100%; }
            .no-print { display: none !important; }
        }
    </style>
</head>
<body>

    <div class="invoice-box">
        <div class="invoice-header d-flex justify-content-between align-items-center">
            khách sạn QLKS
            <div>
                <h3 class="fw-bold text-uppercase mb-0">Hóa Đơn Thanh Toán</h3>
                <p class="text-muted mb-0 small">Mã đơn: <strong>${invoice.maDP}</strong></p>
            </div>
            <div class="text-end">
                <p class="mb-0"><strong>Khách Sạn QLKS</strong></p>
                <p class="text-muted small mb-0">TP. Hồ Chí Minh, Việt Nam</p>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-sm-6">
                <h6 class="fw-bold text-dark">Thông tin khách hàng:</h6>
                <p class="mb-1"><strong>Họ tên:</strong> ${invoice.tenKH}</p>
                <p class="mb-1"><strong>Mã KH:</strong> ${invoice.maKH}</p>
            </div>
            <div class="col-sm-6 text-sm-end">
                <h6 class="fw-bold text-dark">Thời gian lập hóa đơn:</h6>
                <p class="mb-1">Ngày đặt: 
                    <fmt:parseDate value="${invoice.ngayDat}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDat" parseLocale="vi_VN" />
                    <c:if test="${empty parsedDat}">
                        <fmt:parseDate value="${invoice.ngayDat}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDat" parseLocale="vi_VN" />
                    </c:if>
                    <fmt:formatDate value="${parsedDat}" pattern="dd/MM/yyyy HH:mm" />
                </p>
                <p class="mb-1">Trạng thái đơn: 
    <c:choose>
        <c:when test="${invoice.trangThai == 'Chờ xác nhận'}">
            <span class="badge bg-warning text-white px-2 py-1">${invoice.trangThai}</span>
        </c:when>
        <c:when test="${invoice.trangThai == 'Đã xác nhận'}">
            <span class="badge bg-success text-white px-2 py-1">${invoice.trangThai}</span>
        </c:when>
        <c:when test="${invoice.trangThai == 'Đã thuê'}">
            <span class="badge text-white px-2 py-1" style="background-color: #fd7e14;">${invoice.trangThai}</span>
        </c:when>
        <c:when test="${invoice.trangThai == 'Đã hủy'}">
            <span class="badge bg-danger text-white px-2 py-1">${invoice.trangThai}</span>
        </c:when>
        <c:when test="${invoice.trangThai == 'Hoàn thành'}">
            <span class="badge bg-primary text-white px-2 py-1">${invoice.trangThai}</span>
        </c:when>
        <c:otherwise>
            <span class="badge bg-secondary text-white px-2 py-1">${invoice.trangThai}</span>
        </c:otherwise>
    </c:choose>
</p>
            </div>
        </div>

        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Phòng</th>
                    <th>Ngày Nhận</th>
                    <th>Ngày Trả</th>
                    <th class="text-end">Đơn Giá / Thành Tiền</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <strong>${invoice.soPhong}</strong><br>
                        <small class="text-muted">Mã phòng: ${invoice.maPhong}</small>
                    </td>
                    <td>
                        <fmt:parseDate value="${invoice.ngayNhan}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedNhan" type="date"/>
                        <c:if test="${empty parsedNhan}">
                            <fmt:parseDate value="${invoice.ngayNhan}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedNhan" type="date"/>
                        </c:if>
                        <c:if test="${empty parsedNhan}">
                            <fmt:parseDate value="${invoice.ngayNhan}" pattern="yyyy-MM-dd" var="parsedNhan" type="date"/>
                        </c:if>
                        <fmt:formatDate value="${parsedNhan}" pattern="dd/MM/yyyy"/>
                    </td>
                    <td>
                        <fmt:parseDate value="${invoice.ngayTra}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedTra" type="date"/>
                        <c:if test="${empty parsedTra}">
                            <fmt:parseDate value="${invoice.ngayTra}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedTra" type="date"/>
                        </c:if>
                        <c:if test="${empty parsedTra}">
                            <fmt:parseDate value="${invoice.ngayTra}" pattern="yyyy-MM-dd" var="parsedTra" type="date"/>
                        </c:if>
                        <fmt:formatDate value="${parsedTra}" pattern="dd/MM/yyyy"/>
                    </td>
                    <td class="text-end fw-bold text-danger">
                        <fmt:formatNumber value="${invoice.tongTien}" pattern="#,##0" /> VNĐ
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="row justify-content-end">
            <div class="col-md-5">
                <table class="table table-sm table-borderless">
                    <tr>
                        <td><strong>Tổng tiền phòng:</strong></td>
                        <td class="text-end"><fmt:formatNumber value="${invoice.tongTien}" pattern="#,##0" /> VNĐ</td>
                    </tr>
                    <tr>
                        <td><strong>Đã đặt cọc (${invoice.trangThaiCoc}):</strong></td>
                        <td class="text-end text-success">- <fmt:formatNumber value="${invoice.tienCoc}" pattern="#,##0" /> VNĐ</td>
                    </tr>
                    <tr class="border-top fw-bold fs-5">
                        <td>Còn lại thanh toán:</td>
                        <td class="text-end text-danger">
                            <fmt:formatNumber value="${invoice.tongTien - invoice.tienCoc}" pattern="#,##0" /> VNĐ
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="row mt-5 text-center">
            <div class="col-6">
                <p class="mb-5"><strong>Khách hàng ký tên</strong><br><small>(Ký, ghi rõ họ tên)</small></p>
            </div>
            <div class="col-6">
                <p class="mb-5"><strong>Nhập / Thu ngân</strong><br><small>(Ký, ghi rõ họ tên)</small></p>
            </div>
        </div>

        <!-- Nút thao tác ẩn đi khi in -->
        <div class="text-center mt-4 no-print">
            <button onclick="window.print()" class="btn btn-primary px-4 fw-bold me-2">
                <i class="fa fa-print"></i> In Hóa Đơn
            </button>
            <button onclick="window.close()" class="btn btn-secondary px-4">
                Đóng
            </button>
        </div>
    </div>

    <script>
    
    </script>
</body>
</html>