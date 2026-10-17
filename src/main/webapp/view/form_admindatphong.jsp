
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>

<%
    DateTimeFormatter htmlFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    if (request.getAttribute("datPhong") != null) {
        Model.DatPhong dp = (Model.DatPhong) request.getAttribute("datPhong");

        if (dp.getNgayNhan() != null) {
            request.setAttribute("ngayNhanFormatted",
                dp.getNgayNhan().format(htmlFormatter));
        }

        if (dp.getNgayTra() != null) {
            request.setAttribute("ngayTraFormatted",
                dp.getNgayTra().format(htmlFormatter));
        }
    }

    request.setAttribute("todayStr", LocalDate.now().toString());
%>

<style>
    /* ===== FORM ĐẶT PHÒNG - GIAO DIỆN TỐI ===== */
    .booking-form-page {
        color: #eeeeee;
    }

    .booking-form-page .booking-card {
        background: #1c1c1c;
        border: 1px solid #343434;
        border-radius: 12px;
        overflow: hidden;
    }

    .booking-form-page .booking-card-body {
        padding: 28px;
    }

    .booking-form-page .booking-header {
        border-bottom: 1px solid #3a3a3a;
        padding-bottom: 20px;
        margin-bottom: 26px;
        gap: 16px;
    }

    .booking-form-page .booking-title {
        color: #ffffff;
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 0;
    }

    .booking-form-page .booking-title .title-icon {
        color: #dc3545;
        margin-right: 8px;
    }

    .booking-form-page .booking-subtitle {
        color: #a8a8a8;
        font-size: 13px;
        margin-top: 7px;
        margin-bottom: 0;
    }

    .booking-form-page .form-label {
        color: #e9e9e9;
        font-weight: 600;
        margin-bottom: 8px;
    }

    .booking-form-page .form-control,
    .booking-form-page .form-select {
        background-color: #262626;
        color: #eeeeee;
        border: 1px solid #454545;
        border-radius: 7px;
        min-height: 43px;
        padding: 9px 12px;
    }

    .booking-form-page .form-control:focus,
    .booking-form-page .form-select:focus {
        background-color: #292929;
        color: #ffffff;
        border-color: #dc3545;
        box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.18);
    }

    .booking-form-page .form-control[readonly],
    .booking-form-page .form-control:disabled,
    .booking-form-page .form-select:disabled {
        background-color: #303030;
        color: #bcbcbc;
        opacity: 1;
    }

    .booking-form-page .form-select option {
        background-color: #262626;
        color: #eeeeee;
    }

    .booking-form-page input[type="date"]::-webkit-calendar-picker-indicator {
        filter: invert(1);
        cursor: pointer;
    }

    .booking-form-page .room-select-box {
        background: #242424;
        border: 1px solid #414141;
        border-radius: 9px;
        padding: 16px;
        max-height: 260px;
        overflow-y: auto;
    }

    .booking-form-page .room-item {
        height: 100%;
        padding: 10px;
        background: #2b2b2b;
        border: 1px solid #3e3e3e;
        border-radius: 7px;
        transition: 0.2s;
    }

    .booking-form-page .room-item:hover {
        border-color: #dc3545;
        background: #303030;
    }

    .booking-form-page .room-item .form-check {
        margin: 0;
        min-height: 24px;
    }

    .booking-form-page .form-check-input {
        background-color: #3a3a3a;
        border-color: #777777;
        cursor: pointer;
    }

    .booking-form-page .form-check-input:checked {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    .booking-form-page .form-check-input:focus {
        border-color: #dc3545;
        box-shadow: 0 0 0 0.15rem rgba(220, 53, 69, 0.2);
    }

    .booking-form-page .form-check-input:disabled {
        opacity: 0.45;
        cursor: not-allowed;
    }

    .booking-form-page .form-check-label {
        color: #eeeeee;
        cursor: pointer;
        line-height: 1.6;
    }

    .booking-form-page .room-note {
        display: block;
        color: #aaaaaa;
        font-size: 12px;
        margin-top: 12px;
        line-height: 1.6;
    }

    .booking-form-page .form-text {
        color: #a7a7a7 !important;
        font-size: 12px;
        line-height: 1.6;
        margin-top: 7px;
    }

    .booking-form-page .text-danger {
        color: #ff6b75 !important;
    }

    .booking-form-page .text-success {
        color: #42d392 !important;
    }

    .booking-form-page .money-section {
        background: #242424;
        border: 1px solid #414141;
        border-radius: 9px;
        padding: 18px;
        margin-bottom: 22px;
    }

    .booking-form-page .money-input {
        font-weight: 700;
        font-size: 16px;
    }

    .booking-form-page .booking-divider {
        border-color: #414141;
        opacity: 1;
    }

    .booking-form-page .btn-back {
        background: transparent;
        color: #dddddd;
        border: 1px solid #666666;
        border-radius: 7px;
        padding: 10px 17px;
        font-weight: 600;
        text-decoration: none;
        transition: 0.2s;
    }

    .booking-form-page .btn-back:hover {
        background: #3a3a3a;
        color: #ffffff;
    }

    .booking-form-page .btn-save {
        background: #dc3545;
        color: #ffffff;
        border: 1px solid #dc3545;
        border-radius: 7px;
        padding: 10px 24px;
        font-weight: 700;
        transition: 0.2s;
    }

    .booking-form-page .btn-save:hover {
        background: #bb2d3b;
        border-color: #bb2d3b;
        color: #ffffff;
    }

    .booking-form-page .btn-update {
        background: #dc3545;
        color: #ffffff;
        border: 1px solid #dc3545;
        border-radius: 7px;
        padding: 10px 24px;
        font-weight: 700;
        transition: 0.2s;
    }

    .booking-form-page .btn-update:hover {
        background: #bb2d3b;
        border-color: #bb2d3b;
        color: #ffffff;
    }

    .booking-form-page .status-badge {
        font-size: 10px;
        font-weight: 600;
        white-space: nowrap;
    }

    .booking-form-page .booking-footer {
        border-top: 1px solid #414141;
        padding-top: 20px;
        margin-top: 8px;
        gap: 12px;
    }

    @media (max-width: 767px) {
        .booking-form-page .booking-card-body {
            padding: 18px;
        }

        .booking-form-page .booking-header {
            align-items: flex-start !important;
            flex-direction: column;
        }

        .booking-form-page .booking-title {
            font-size: 20px;
        }

        .booking-form-page .booking-footer {
            align-items: stretch !important;
            flex-direction: column-reverse;
        }

        .booking-form-page .booking-footer .btn {
            width: 100%;
            text-align: center;
        }

        .booking-form-page .room-select-box {
            max-height: 320px;
        }
    }
  
    .booking-form-page button[type="submit"],
    .booking-form-page .btn {
        position: relative;
        z-index: 10;
        touch-action: manipulation;
        -webkit-tap-highlight-color: transparent;
        cursor: pointer;
    }
</style>

<div class="booking-form-page">
    <div class="row justify-content-center">
        <div class="col-12 col-xl-9 col-xxl-8">

            <div class="booking-card shadow-sm mb-4">
                <div class="booking-card-body">

                    <!-- TIÊU ĐỀ -->
                    <div class="booking-header d-flex justify-content-between align-items-center">
                        <div>
                            <h3 class="booking-title">
                                <c:choose>
                                    <c:when test="${not empty datPhong}">
                                        <i class="fas fa-edit title-icon"></i>
                                        Cập Nhật Đơn Đặt Phòng
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-calendar-plus title-icon"></i>
                                        Thêm Đơn Đặt Phòng Mới
                                    </c:otherwise>
                                </c:choose>
                            </h3>

                            <p class="booking-subtitle">
                                Quản lý thông tin khách hàng, phòng đặt và thanh toán
                            </p>
                        </div>

                        <a href="${pageContext.request.contextPath}/admin/dat-phong?action=list"
                           class="btn-back">
                            <i class="fas fa-arrow-left me-1"></i>
                            Quay lại
                        </a>
                    </div>

                    <!-- FORM -->
                    <form action="${pageContext.request.contextPath}/admin/dat-phong?action=${not empty datPhong ? 'update' : 'add'}"
                          method="POST">

                        <c:choose>
                            <c:when test="${not empty datPhong}">
                                <input type="hidden" name="tongTien" id="hiddenTongTien"
                                       value="${datPhong.tongTien}">
                                <input type="hidden" name="tienCoc" id="hiddenTienCoc"
                                       value="${datPhong.tienCoc}">
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="tongTien" id="hiddenTongTien" value="0">
                                <input type="hidden" name="tienCoc" id="hiddenTienCoc" value="0">
                            </c:otherwise>
                        </c:choose>

                        <!-- MÃ ĐẶT PHÒNG -->
                        <div class="mb-4">
                            <label for="maDP" class="form-label">
                                <i class="fas fa-receipt me-1 text-danger"></i>
                                Mã Đặt Phòng
                            </label>

                            <input type="text"
                                   class="form-control"
                                   id="maDP"
                                   name="maDP"
                                   value="${not empty datPhong ? datPhong.maDP : nextMaDP}"
                                   readonly>
                        </div>

                        <!-- KHÁCH HÀNG -->
                        <div class="mb-4">
                            <label for="maKH" class="form-label">
                                <i class="fas fa-user me-1 text-danger"></i>
                                Khách Hàng <span class="text-danger">*</span>
                            </label>

                            <select class="form-select" id="maKH" name="maKH" required>
                                <option value="" disabled ${empty datPhong ? 'selected' : ''}>
                                    -- Chọn khách hàng --
                                </option>

                                <c:forEach var="kh" items="${khachHangList}">
                                    <option value="${kh.maKH}"
                                        ${not empty datPhong and datPhong.maKH == kh.maKH ? 'selected' : ''}>
                                        ${kh.hoTen} (Mã: ${kh.maKH})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- CHỌN PHÒNG -->
                        <div class="mb-4">
                            <label class="form-label">
                                <i class="fas fa-bed me-1 text-danger"></i>
                                Phòng Cần Đặt <span class="text-danger">*</span>
                            </label>

                            <c:choose>
                                <c:when test="${empty datPhong}">
                                    <div class="room-select-box">
                                        <div class="row g-2">
                                            <c:forEach var="p" items="${phongList}">
                                                <c:set var="roomStatus"
                                                       value="${roomStatusMap[p.maPhong]}" />

                                                <div class="col-12 col-md-6 col-xl-4">
                                                    <div class="room-item">
                                                        <div class="form-check">
                                                            <input class="form-check-input room-checkbox"
                                                                   type="checkbox"
                                                                   name="selectedRooms"
                                                                   value="${p.maPhong}"
                                                                   id="room_${p.maPhong}"
                                                                   data-price="${p.gia}"
                                                                   data-status="${roomStatus}"
                                                                   <c:if test="${roomStatus == 'Đã xác nhận' || roomStatus == 'Đã thuê'}">disabled</c:if>>

                                                            <label class="form-check-label"
                                                                   for="room_${p.maPhong}">
                                                                <strong>${p.maPhong}</strong>
                                                                - ${p.tenPhong}

                                                                <c:if test="${roomStatus == 'Đã xác nhận'}">
                                                                    <span class="badge bg-success status-badge">
                                                                        Đã xác nhận
                                                                    </span>
                                                                </c:if>

                                                                <c:if test="${roomStatus == 'Đã thuê'}">
                                                                    <span class="badge bg-danger status-badge">
                                                                        Đã thuê
                                                                    </span>
                                                                </c:if>

                                                                <c:if test="${roomStatus == 'Chờ xác nhận'}">
                                                                    <span class="badge bg-warning text-dark status-badge">
                                                                        Chờ xác nhận
                                                                    </span>
                                                                </c:if>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <small class="room-note">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Phòng đã xác nhận hoặc đã thuê sẽ bị khóa.
                                        Phòng đang chờ xác nhận vẫn có thể chọn nhưng sẽ hiển thị cảnh báo.
                                    </small>
                                </c:when>

                                <c:otherwise>
                                    <select class="form-select" id="maPhong" name="maPhong" required>
                                        <option value="" disabled>-- Chọn phòng --</option>

                                        <c:forEach var="p" items="${phongList}">
                                            <option value="${p.maPhong}"
                                                ${datPhong.maPhong == p.maPhong ? 'selected' : ''}>
                                                ${p.maPhong} - ${p.tenPhong}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- NGÀY NHẬN / NGÀY TRẢ -->
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="ngayNhan" class="form-label">
                                    <i class="fas fa-calendar-check me-1 text-danger"></i>
                                    Ngày Nhận Phòng <span class="text-danger">*</span>
                                </label>

                                <input type="date"
                                       class="form-control"
                                       id="ngayNhan"
                                       name="ngayNhan"
                                       value="${ngayNhanFormatted}"
                                       min="${todayStr}"
                                       required>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label for="ngayTra" class="form-label">
                                    <i class="fas fa-calendar-times me-1 text-danger"></i>
                                    Ngày Trả Phòng <span class="text-danger">*</span>
                                </label>

                                <input type="date"
                                       class="form-control"
                                       id="ngayTra"
                                       name="ngayTra"
                                       value="${ngayTraFormatted}"
                                       min="${todayStr}"
                                       required>
                            </div>
                        </div>

                        <!-- TỶ LỆ ĐẶT CỌC -->
                        <div class="mb-4">
                            <label for="selectTyLeCoc" class="form-label">
                                <i class="fas fa-percent me-1 text-danger"></i>
                                Tỷ Lệ Đặt Cọc (%)
                            </label>

                            <c:set var="isLocked" value="${not empty datPhong}" />

                            <select class="form-select"
                                    id="selectTyLeCoc"
                                    name="tyLeCoc"
                                    ${isLocked ? 'disabled' : ''}>
                                <option value="10"
                                    ${not empty datPhong and datPhong.tyLeCoc == 10 ? 'selected' : ''}>
                                    10%
                                </option>

                                <option value="20"
                                    ${not empty datPhong and datPhong.tyLeCoc == 20 ? 'selected' : ''}>
                                    20%
                                </option>

                                <option value="30"
                                    ${empty datPhong or datPhong.tyLeCoc == 30 ? 'selected' : ''}>
                                    30% (Mặc định)
                                </option>

                                <option value="50"
                                    ${not empty datPhong and datPhong.tyLeCoc == 50 ? 'selected' : ''}>
                                    50%
                                </option>

                                <option value="100"
                                    ${not empty datPhong and datPhong.tyLeCoc == 100 ? 'selected' : ''}>
                                    100% (Thanh toán trước)
                                </option>
                            </select>

                            <c:if test="${isLocked}">
                                <input type="hidden" name="tyLeCoc" value="${datPhong.tyLeCoc}">
                                <div class="form-text text-danger">
                                    <i class="fas fa-lock me-1"></i>
                                    Đơn đặt phòng hiện tại không cho phép thay đổi tỷ lệ cọc.
                                </div>
                            </c:if>
                        </div>

                        <!-- TỔNG TIỀN VÀ TIỀN CỌC -->
                        <div class="money-section">
                            <div class="row">
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <label for="tongTienDisplay" class="form-label">
                                        <i class="fas fa-money-bill-wave me-1 text-danger"></i>
                                        Tổng Tiền (VNĐ)
                                    </label>

                                    <input type="text"
                                           class="form-control money-input text-danger"
                                           id="tongTienDisplay"
                                           value="<fmt:formatNumber value='${not empty datPhong ? datPhong.tongTien : 0}' type='number' groupingUsed='true'/>"
                                           readonly>
                                </div>

                                <div class="col-md-6">
                                    <label for="tienCocDisplay" class="form-label">
                                        <i class="fas fa-wallet me-1 text-success"></i>
                                        Tiền Cọc Thực Tế (VNĐ)
                                    </label>

                                    <input type="text"
                                           class="form-control money-input text-success"
                                           id="tienCocDisplay"
                                           value="<fmt:formatNumber value='${not empty datPhong ? datPhong.tienCoc : 0}' type='number' groupingUsed='true'/>"
                                           readonly>
                                </div>
                            </div>
                        </div>

                        <!-- TRẠNG THÁI ĐƠN -->
                        <div class="mb-4">
                            <label for="trangThai" class="form-label">
                                <i class="fas fa-tasks me-1 text-danger"></i>
                                Trạng Thái Đơn
                            </label>

                            <select class="form-select" id="trangThai" name="trangThai" required>
                                <c:choose>
                                    <c:when test="${datPhong.trangThai == 'Đã thuê'}">
                                        <option value="Đã thuê" selected>Đã thuê</option>
                                        <option value="Hoàn thành">Hoàn thành</option>
                                    </c:when>

                                    <c:when test="${datPhong.trangThai == 'Chờ xác nhận' || datPhong.trangThai == 'Đã xác nhận'}">
                                        <option value="Chờ xác nhận"
                                            ${datPhong.trangThai == 'Chờ xác nhận' ? 'selected' : ''}>
                                            Chờ xác nhận
                                        </option>

                                        <option value="Đã xác nhận"
                                            ${datPhong.trangThai == 'Đã xác nhận' ? 'selected' : ''}>
                                            Đã xác nhận
                                        </option>

                                        <option value="Đã thuê">Đã thuê</option>
                                        <option value="Đã hủy">Đã hủy</option>
                                    </c:when>

                                    <c:when test="${empty datPhong}">
                                        <option value="Chờ xác nhận" selected>Chờ xác nhận</option>
                                        <option value="Đã xác nhận">Đã xác nhận</option>
                                        <option value="Đã thuê">Đã thuê</option>
                                    </c:when>

                                    <c:otherwise>
                                        <option value="${datPhong.trangThai}" selected>
                                            ${datPhong.trangThai}
                                        </option>
                                    </c:otherwise>
                                </c:choose>
                            </select>

                            <div class="form-text">
                                Đơn đã thuê chỉ có thể chuyển sang hoàn thành.
                                Đơn chờ hoặc đã xác nhận có thể chuyển tiếp hoặc hủy.
                            </div>
                        </div>

                        <!-- TRẠNG THÁI CỌC -->
                        <div class="mb-4">
                            <label for="trangThaiCoc" class="form-label">
                                <i class="fas fa-hand-holding-usd me-1 text-danger"></i>
                                Trạng Thái Cọc
                            </label>

                            <select class="form-select" id="trangThaiCoc"
                                    name="trangThaiCoc" required>
                                <option value="Đã cọc"
                                    ${empty datPhong or datPhong.trangThaiCoc == 'Đã cọc' ? 'selected' : ''}>
                                    Đã cọc
                                </option>

                                <option value="Đã hoàn tiền"
                                    ${not empty datPhong and datPhong.trangThaiCoc == 'Đã hoàn tiền' ? 'selected' : ''}>
                                    Đã hoàn tiền (Khách hủy sớm)
                                </option>

                                <option value="Phạt Cọc"
                                    ${not empty datPhong and datPhong.trangThaiCoc == 'Phạt Cọc' ? 'selected' : ''}>
                                    Phạt cọc (Khách hủy trễ / No-show)
                                </option>
                            </select>

                            <div class="form-text">
                                Đã cọc: giữ tiền cọc bình thường.
                                Đã hoàn tiền: trả lại tiền cọc cho khách.
                                Phạt cọc: giữ lại tiền cọc theo quy định.
                            </div>
                        </div>

                        <!-- NÚT THAO TÁC -->
                        <div class="booking-footer d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/admin/dat-phong?action=list"
                               class="btn btn-back">
                                <i class="fas fa-times me-1"></i>
                                Hủy bỏ
                            </a>

                            <button type="submit"
                                    class="btn ${not empty datPhong ? 'btn-update' : 'btn-save'}">
                                <i class="fas fa-save me-1"></i>
                                ${not empty datPhong ? 'Cập Nhật' : 'Lưu Đặt Phòng'}
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const roomCheckboxes = document.querySelectorAll(
            'input[name="selectedRooms"]'
        );

        const ngayNhanInput = document.getElementById("ngayNhan");
        const ngayTraInput = document.getElementById("ngayTra");
        const selectTyLeCoc = document.getElementById("selectTyLeCoc");

        const hiddenTongTien = document.getElementById("hiddenTongTien");
        const hiddenTienCoc = document.getElementById("hiddenTienCoc");

        const tongTienDisplay = document.getElementById("tongTienDisplay");
        const tienCocDisplay = document.getElementById("tienCocDisplay");

        // Cảnh báo nếu phòng đang có đơn chờ xác nhận.
        roomCheckboxes.forEach(function (cb) {
            cb.addEventListener("change", function () {
                if (this.checked &&
                    this.getAttribute("data-status") === "Chờ xác nhận") {
                    alert(
                        'CẢNH BÁO: Phòng ' + this.value +
                        ' đang có đơn ở trạng thái "Chờ xác nhận". ' +
                        'Vui lòng kiểm tra trước khi tạo thêm đơn!'
                    );
                }

                updateTien();
            });
        });

        function updateTien() {
            let tongGiaPhongMoiNgay = 0;

            roomCheckboxes.forEach(function (cb) {
                if (cb.checked) {
                    let price = parseFloat(cb.getAttribute("data-price")) || 0;
                    tongGiaPhongMoiNgay += price;
                }
            });

            let soNgay = 1;

            if (ngayNhanInput.value && ngayTraInput.value) {
                const d1 = new Date(ngayNhanInput.value + "T00:00:00");
                const d2 = new Date(ngayTraInput.value + "T00:00:00");

                const diffTime = d2.getTime() - d1.getTime();
                const diffDays = Math.round(
                    diffTime / (1000 * 60 * 60 * 24)
                );

                if (diffDays > 0) {
                    soNgay = diffDays;
                }
            }

            const tongTien = tongGiaPhongMoiNgay * soNgay;

            const tyLeCoc = selectTyLeCoc
                ? (parseFloat(selectTyLeCoc.value) || 30) / 100
                : 0.3;

            const tienCoc = Math.round(tongTien * tyLeCoc);

            if (hiddenTongTien) {
                hiddenTongTien.value = tongTien;
            }

            if (hiddenTienCoc) {
                hiddenTienCoc.value = tienCoc;
            }

            if (tongTienDisplay) {
                tongTienDisplay.value = tongTien.toLocaleString("en-US");
            }

            if (tienCocDisplay) {
                tienCocDisplay.value = tienCoc.toLocaleString("en-US");
            }
        }

        if (ngayNhanInput) {
            ngayNhanInput.addEventListener("change", function () {
                ngayTraInput.min = ngayNhanInput.value || "${todayStr}";

                if (ngayTraInput.value &&
                    ngayTraInput.value < ngayNhanInput.value) {
                    ngayTraInput.value = "";
                }

                updateTien();
            });
        }

        if (ngayTraInput) {
            ngayTraInput.addEventListener("change", updateTien);
        }

        if (selectTyLeCoc && !selectTyLeCoc.disabled) {
            selectTyLeCoc.addEventListener("change", updateTien);
        }

        // Chỉ tính lại tiền tự động khi thêm đơn mới.
        // Form sửa giữ nguyên tổng tiền và tiền cọc từ dữ liệu hiện có.
        const isEditForm = ${not empty datPhong};

        if (!isEditForm) {
            updateTien();
        }
    });
</script>
