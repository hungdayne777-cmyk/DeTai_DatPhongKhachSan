
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa Đơn Thanh Toán - ${invoice.maDP}</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/bootstrap.min.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px 15px;
            background: #111111;
            color: #eeeeee;
            font-family: 'Roboto', Arial, sans-serif;
            font-size: 14px;
        }

        /* Khung hóa đơn */
        .invoice-box {
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
            padding: 38px;
            background: #1c1c1c;
            border: 1px solid #363636;
            border-top: 4px solid #dc3545;
            border-radius: 12px;
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.35);
        }

        /* Phần đầu hóa đơn */
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            padding-bottom: 25px;
            margin-bottom: 28px;
            border-bottom: 1px solid #444444;
        }

        .hotel-brand {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .hotel-logo {
            width: 58px;
            height: 58px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            background: #dc3545;
            border-radius: 12px;
            color: #ffffff;
            font-size: 25px;
        }

        .hotel-name {
            margin: 0 0 5px;
            color: #ffffff;
            font-size: 22px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .hotel-subtitle {
            margin: 0;
            color: #aaaaaa;
            font-size: 11px;
            letter-spacing: 2px;
        }

        .invoice-title {
            text-align: right;
        }

        .invoice-title h1 {
            margin: 0 0 10px;
            color: #ffffff;
            font-size: 25px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .invoice-code {
            display: inline-block;
            padding: 6px 12px;
            color: #ff6573;
            background: #35171b;
            border: 1px solid #5b242b;
            border-radius: 5px;
            font-weight: 700;
        }

        /* Thông tin khách hàng và thời gian */
        .info-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 28px;
        }

        .info-card {
            padding: 20px;
            background: #242424;
            border: 1px solid #383838;
            border-radius: 8px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 9px;
            padding-bottom: 12px;
            margin: 0 0 14px;
            color: #ff5263;
            border-bottom: 1px solid #3e3e3e;
            font-size: 15px;
            font-weight: 700;
        }

        .info-line {
            margin: 8px 0;
            color: #d2d2d2;
            line-height: 1.7;
            overflow-wrap: anywhere;
        }

        .info-line strong {
            color: #ffffff;
        }

        /* Trạng thái */
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: 700;
        }

        /* Bảng chi tiết */
        .table-section {
            margin-bottom: 25px;
            overflow: hidden;
            border: 1px solid #3b3b3b;
            border-radius: 8px;
        }

        .invoice-table {
            width: 100%;
            margin: 0;
            color: #eeeeee;
            vertical-align: middle;
        }

        .invoice-table thead th {
            padding: 15px 12px;
            color: #ffffff;
            background: #303030;
            border: none;
            border-bottom: 2px solid #dc3545;
            font-size: 12px;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .invoice-table tbody td {
            padding: 18px 12px;
            color: #dddddd;
            background: #202020;
            border-color: #3a3a3a;
        }

        .room-name {
            color: #ffffff;
            font-weight: 700;
            font-size: 15px;
        }

        .room-code {
            display: inline-block;
            margin-top: 5px;
            color: #aaaaaa;
            font-size: 12px;
        }

        .price-text {
            color: #ff5263 !important;
            font-weight: 800;
            white-space: nowrap;
        }

        /* Tổng tiền */
        .payment-wrapper {
            display: flex;
            justify-content: flex-end;
        }

        .payment-card {
            width: 100%;
            max-width: 430px;
            padding: 20px;
            background: #242424;
            border: 1px solid #3c3c3c;
            border-radius: 8px;
        }

        .payment-title {
            margin: 0 0 15px;
            padding-bottom: 12px;
            color: #ffffff;
            border-bottom: 1px solid #444444;
            font-size: 16px;
            font-weight: 700;
        }

        .payment-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 15px;
            padding: 9px 0;
            color: #cccccc;
        }

        .payment-row strong {
            color: #ffffff;
        }

        .payment-value {
            text-align: right;
            white-space: nowrap;
        }

        .deposit-value {
            color: #28c76f;
            font-weight: 700;
        }

        .payment-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            padding-top: 16px;
            margin-top: 10px;
            border-top: 1px solid #555555;
        }

        .payment-total span:first-child {
            color: #ffffff;
            font-weight: 800;
        }

        .payment-total .total-value {
            color: #ff5263;
            font-size: 21px;
            font-weight: 800;
            text-align: right;
            white-space: nowrap;
        }

        /* Chữ ký */
        .signature-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-top: 45px;
            text-align: center;
        }

        .signature-box {
            min-height: 120px;
            padding: 18px 10px;
            border: 1px dashed #4a4a4a;
            border-radius: 8px;
        }

        .signature-box strong {
            display: block;
            margin-bottom: 5px;
            color: #ffffff;
            font-size: 14px;
        }

        .signature-box small {
            color: #aaaaaa;
        }

        .signature-space {
            height: 55px;
        }

        .invoice-note {
            margin-top: 25px;
            padding-top: 15px;
            color: #999999;
            border-top: 1px solid #3c3c3c;
            font-size: 12px;
            text-align: center;
        }

        /* Nút thao tác */
        .invoice-actions {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 25px;
        }

        .btn-print {
            padding: 11px 24px;
            color: #ffffff;
            background: #dc3545;
            border: 1px solid #dc3545;
            border-radius: 6px;
            font-weight: 700;
            transition: all 0.25s ease;
        }

        .btn-print:hover {
            color: #ffffff;
            background: #b92332;
            border-color: #b92332;
        }

        .btn-close-invoice {
            padding: 11px 24px;
            color: #eeeeee;
            background: #333333;
            border: 1px solid #555555;
            border-radius: 6px;
            font-weight: 700;
        }

        .btn-close-invoice:hover {
            color: #ffffff;
            background: #444444;
        }

        /* Responsive */
        @media (max-width: 600px) {
            body {
                padding: 12px 8px;
            }

            .invoice-box {
                padding: 20px 14px;
            }

            .invoice-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .invoice-title {
                width: 100%;
                text-align: left;
            }

            .invoice-title h1 {
                font-size: 21px;
            }

            .info-section {
                grid-template-columns: 1fr;
            }

            .table-section {
                overflow-x: auto;
            }

            .invoice-table {
                min-width: 590px;
            }

            .signature-section {
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }

            .payment-card {
                padding: 15px;
            }

            .payment-total .total-value {
                font-size: 17px;
            }
        }

        /* Chỉ in nội dung hóa đơn, không in nền tối */
        @media print {
            @page {
                size: A4;
                margin: 12mm;
            }

            body {
                padding: 0;
                background: #ffffff !important;
                color: #222222 !important;
                font-family: 'Times New Roman', serif;
                font-size: 12px;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }

            .invoice-box {
                width: 100%;
                max-width: none;
                margin: 0;
                padding: 0;
                color: #222222 !important;
                background: #ffffff !important;
                border: none;
                border-top: 3px solid #dc3545;
                border-radius: 0;
                box-shadow: none;
            }

            .invoice-header {
                margin-bottom: 18px;
                padding-bottom: 15px;
                border-bottom: 1px solid #999999;
            }

            .hotel-name,
            .invoice-title h1,
            .info-line strong,
            .section-title,
            .room-name,
            .payment-title,
            .payment-row strong,
            .payment-total span:first-child,
            .signature-box strong {
                color: #222222 !important;
            }

            .hotel-subtitle,
            .info-line,
            .room-code,
            .signature-box small,
            .invoice-note {
                color: #555555 !important;
            }

            .info-card,
            .payment-card,
            .signature-box {
                background: #ffffff !important;
                border-color: #cccccc !important;
            }

            .invoice-table thead th {
                color: #ffffff !important;
                background: #333333 !important;
            }

            .invoice-table tbody td {
                color: #222222 !important;
                background: #ffffff !important;
                border-color: #cccccc !important;
            }

            .price-text,
            .payment-total .total-value {
                color: #c82333 !important;
            }

            .deposit-value {
                color: #198754 !important;
            }

            .no-print {
                display: none !important;
            }

            .info-section,
            .table-section,
            .payment-wrapper,
            .signature-section {
                break-inside: avoid;
                page-break-inside: avoid;
            }
        }
    </style>
</head>

<body>

<div class="invoice-box">

    <!-- ĐẦU HÓA ĐƠN -->
    <div class="invoice-header">

        <div class="hotel-brand">
            <div class="hotel-logo">
                <i class="fas fa-hotel"></i>
            </div>

            <div>
                <h2 class="hotel-name">Khách Sạn QLKS</h2>
                <p class="hotel-subtitle">HOTEL MANAGEMENT</p>
            </div>
        </div>

        <div class="invoice-title">
            <h1>Hóa Đơn Thanh Toán</h1>
            <span class="invoice-code">
                <i class="fas fa-file-invoice me-1"></i>
                Mã đơn: <c:out value="${invoice.maDP}"/>
            </span>
        </div>

    </div>

    <!-- THÔNG TIN -->
    <div class="info-section">

        <div class="info-card">
            <h3 class="section-title">
                <i class="fas fa-user"></i>
                Thông tin khách hàng
            </h3>

            <p class="info-line">
                <strong>Họ tên:</strong>
                <c:out value="${invoice.tenKH}"/>
            </p>

            <p class="info-line">
                <strong>Mã khách hàng:</strong>
                <c:out value="${invoice.maKH}"/>
            </p>

            <p class="info-line">
                <strong>Mã đơn đặt phòng:</strong>
                <c:out value="${invoice.maDP}"/>
            </p>
        </div>

        <div class="info-card">
            <h3 class="section-title">
                <i class="fas fa-calendar-alt"></i>
                Thời gian và trạng thái
            </h3>

            <p class="info-line">
                <strong>Ngày đặt:</strong>

                <fmt:parseDate value="${invoice.ngayDat}"
                               pattern="yyyy-MM-dd'T'HH:mm"
                               var="parsedDat"/>

                <c:if test="${empty parsedDat}">
                    <fmt:parseDate value="${invoice.ngayDat}"
                                   pattern="yyyy-MM-dd HH:mm:ss"
                                   var="parsedDat"/>
                </c:if>

                <c:choose>
                    <c:when test="${not empty parsedDat}">
                        <fmt:formatDate value="${parsedDat}"
                                        pattern="dd/MM/yyyy HH:mm"/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${invoice.ngayDat}"/>
                    </c:otherwise>
                </c:choose>
            </p>

            <p class="info-line">
                <strong>Trạng thái:</strong>

                <c:choose>
                    <c:when test="${invoice.trangThai == 'Chờ xác nhận'}">
                        <span class="status-badge bg-warning text-dark">
                            <c:out value="${invoice.trangThai}"/>
                        </span>
                    </c:when>

                    <c:when test="${invoice.trangThai == 'Đã xác nhận'}">
                        <span class="status-badge bg-success text-white">
                            <c:out value="${invoice.trangThai}"/>
                        </span>
                    </c:when>

                    <c:when test="${invoice.trangThai == 'Đã thuê'}">
                        <span class="status-badge text-white"
                              style="background-color:#fd7e14;">
                            <c:out value="${invoice.trangThai}"/>
                        </span>
                    </c:when>

                    <c:when test="${invoice.trangThai == 'Đã hủy'}">
                        <span class="status-badge bg-danger text-white">
                            <c:out value="${invoice.trangThai}"/>
                        </span>
                    </c:when>

                    <c:when test="${invoice.trangThai == 'Hoàn thành'}">
                        <span class="status-badge bg-primary text-white">
                            <c:out value="${invoice.trangThai}"/>
                        </span>
                    </c:when>

                    <c:otherwise>
                        <span class="status-badge bg-secondary text-white">
                            <c:out value="${invoice.trangThai}"/>
                        </span>
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

    </div>

    <!-- CHI TIẾT PHÒNG -->
    <h3 class="section-title">
        <i class="fas fa-bed"></i>
        Chi tiết đặt phòng
    </h3>

    <div class="table-section">
        <table class="table invoice-table">
            <thead>
                <tr>
                    <th>Thông tin phòng</th>
                    <th>Ngày nhận</th>
                    <th>Ngày trả</th>
                    <th class="text-end">Thành tiền</th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td>
                        <div class="room-name">
                            <c:out value="${invoice.soPhong}"/>
                        </div>
                        <span class="room-code">
                            Mã phòng:
                            <c:out value="${invoice.maPhong}"/>
                        </span>
                    </td>

                    <td>
                        <fmt:parseDate value="${invoice.ngayNhan}"
                                       pattern="yyyy-MM-dd'T'HH:mm"
                                       var="parsedNhan"/>

                        <c:if test="${empty parsedNhan}">
                            <fmt:parseDate value="${invoice.ngayNhan}"
                                           pattern="yyyy-MM-dd HH:mm:ss"
                                           var="parsedNhan"/>
                        </c:if>

                        <c:if test="${empty parsedNhan}">
                            <fmt:parseDate value="${invoice.ngayNhan}"
                                           pattern="yyyy-MM-dd"
                                           var="parsedNhan"/>
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty parsedNhan}">
                                <fmt:formatDate value="${parsedNhan}"
                                                pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${invoice.ngayNhan}"/>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <fmt:parseDate value="${invoice.ngayTra}"
                                       pattern="yyyy-MM-dd'T'HH:mm"
                                       var="parsedTra"/>

                        <c:if test="${empty parsedTra}">
                            <fmt:parseDate value="${invoice.ngayTra}"
                                           pattern="yyyy-MM-dd HH:mm:ss"
                                           var="parsedTra"/>
                        </c:if>

                        <c:if test="${empty parsedTra}">
                            <fmt:parseDate value="${invoice.ngayTra}"
                                           pattern="yyyy-MM-dd"
                                           var="parsedTra"/>
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty parsedTra}">
                                <fmt:formatDate value="${parsedTra}"
                                                pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${invoice.ngayTra}"/>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td class="text-end price-text">
                        <fmt:formatNumber value="${invoice.tongTien}"
                                          pattern="#,##0"/> VNĐ
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- TỔNG THANH TOÁN -->
    <div class="payment-wrapper">
        <div class="payment-card">

            <h3 class="payment-title">
                <i class="fas fa-wallet me-2"></i>
                Tổng kết thanh toán
            </h3>

            <div class="payment-row">
                <span>Tổng tiền phòng:</span>
                <strong class="payment-value">
                    <fmt:formatNumber value="${invoice.tongTien}"
                                      pattern="#,##0"/> VNĐ
                </strong>
            </div>

            <div class="payment-row">
                <span>
                    Tiền đặt cọc
                    <c:if test="${not empty invoice.trangThaiCoc}">
                        (<c:out value="${invoice.trangThaiCoc}"/>)
                    </c:if>:
                </span>

                <span class="payment-value deposit-value">
                    - <fmt:formatNumber value="${invoice.tienCoc}"
                                        pattern="#,##0"/> VNĐ
                </span>
            </div>

            <div class="payment-total">
                <span>Còn lại thanh toán:</span>

                <span class="total-value">
                    <fmt:formatNumber
                        value="${invoice.tongTien - invoice.tienCoc}"
                        pattern="#,##0"/> VNĐ
                </span>
            </div>

        </div>
    </div>

    <!-- CHỮ KÝ -->
    <div class="signature-section">

        <div class="signature-box">
            <strong>KHÁCH HÀNG</strong>
            <small>(Ký và ghi rõ họ tên)</small>
            <div class="signature-space"></div>
        </div>

        <div class="signature-box">
            <strong>NHÂN VIÊN THU NGÂN</strong>
            <small>(Ký và ghi rõ họ tên)</small>
            <div class="signature-space"></div>
        </div>

    </div>

    <div class="invoice-note">
        Cảm ơn quý khách đã sử dụng dịch vụ của Khách Sạn QLKS.
        <br>
        Vui lòng giữ hóa đơn để đối chiếu khi cần thiết.
    </div>

    <!-- NÚT THAO TÁC -->
    <div class="invoice-actions no-print">

        <button type="button"
                onclick="window.print()"
                class="btn-print">
            <i class="fas fa-print me-2"></i>
            In hóa đơn
        </button>

        <button type="button"
                onclick="window.close()"
                class="btn-close-invoice">
            <i class="fas fa-times me-2"></i>
            Đóng
        </button>

    </div>

</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

</body>
</html>
