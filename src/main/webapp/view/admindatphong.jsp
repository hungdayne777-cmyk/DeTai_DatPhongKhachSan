<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="booking-page">

    <!-- Thông báo -->
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-info alert-dismissible fade show booking-alert" role="alert">
            <i class="fas fa-info-circle me-2"></i>
            ${sessionScope.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
        </div>
        <% session.removeAttribute("message"); %>
    </c:if>

    <!-- Tiêu đề -->
    <div class="booking-header">
        <div>
            <span class="booking-subtitle">HỆ THỐNG QUẢN LÝ KHÁCH SẠN</span>
            <h2>
                <i class="fas fa-calendar-check"></i>
                Quản lý đặt phòng
            </h2>
            <p>Quản lý thông tin đặt phòng, tiền cọc và trạng thái lưu trú.</p>
        </div>

        <a href="${pageContext.request.contextPath}/admin/dat-phong?action=form-add"
           class="booking-add-btn">
            <i class="fas fa-plus"></i>
            <span>Thêm đặt phòng</span>
        </a>
    </div>

    <!-- Bộ lọc -->
    <div class="booking-glass-card filter-card">
        <div class="section-heading">
            <div class="section-icon">
                <i class="fas fa-filter"></i>
            </div>
            <div>
                <h5>Bộ lọc đặt phòng</h5>
                <p>Tìm kiếm và lọc theo trạng thái đơn đặt phòng.</p>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/admin/dat-phong"
              method="post"
              class="booking-filter-form">

            <input type="hidden" name="action" value="list">

            <div class="filter-field search-field">
                <label for="keyword">Từ khóa tìm kiếm</label>
                <div class="booking-input-group">
                    <i class="fas fa-search"></i>
                    <input type="text"
                           id="keyword"
                           name="keyword"
                           value="${keyword}"
                           placeholder="Tên khách hàng hoặc mã phòng...">
                </div>
            </div>

            <div class="filter-field status-field">
                <label for="status">Trạng thái đặt phòng</label>
                <select name="status" id="status" class="booking-select">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Chờ xác nhận"
                        ${status == 'Chờ xác nhận' ? 'selected' : ''}>
                        Chờ xác nhận
                    </option>
                    <option value="Đã xác nhận"
                        ${status == 'Đã xác nhận' ? 'selected' : ''}>
                        Đã xác nhận
                    </option>
                    <option value="Đã thuê"
                        ${status == 'Đã thuê' ? 'selected' : ''}>
                        Đã thuê
                    </option>
                    <option value="Hoàn thành"
                        ${status == 'Hoàn thành' ? 'selected' : ''}>
                        Hoàn thành
                    </option>
                    <option value="Đã hủy"
                        ${status == 'Đã hủy' ? 'selected' : ''}>
                        Đã hủy
                    </option>
                </select>
            </div>

            <div class="filter-actions">
                <button type="submit" class="booking-filter-btn">
                    <i class="fas fa-search"></i>
                    Lọc dữ liệu
                </button>

                <a href="${pageContext.request.contextPath}/admin/dat-phong?action=list"
                   class="booking-reset-btn"
                   title="Làm mới bộ lọc">
                    <i class="fas fa-sync-alt"></i>
                    Làm mới
                </a>
            </div>
        </form>
    </div>

    <!-- Bảng đặt phòng -->
    <div class="booking-glass-card table-card">

        <div class="table-heading">
            <div>
                <h5>
                    <i class="fas fa-list-ul"></i>
                    Danh sách đặt phòng
                </h5>
                <p>Thông tin chi tiết các đơn đặt phòng trong hệ thống.</p>
            </div>
            <span class="table-label">
                <i class="fas fa-database"></i>
                Dữ liệu đặt phòng
            </span>
        </div>

        <div class="table-responsive booking-table-wrapper">
            <table class="table booking-table align-middle">
                <thead>
                    <tr>
                        <th>MÃ ĐP</th>
                        <th>MÃ PHÒNG</th>
                        <th>KHÁCH HÀNG</th>
                        <th>SỐ LƯỢNG</th>
                        <th>NGÀY ĐẶT</th>
                        <th>NGÀY NHẬN</th>
                        <th>NGÀY TRẢ</th>
                        <th>TIỀN CỌC</th>
                        <th>TRẠNG THÁI CỌC</th>
                        <th>TỔNG TIỀN</th>
                        <th>TRẠNG THÁI PHÒNG</th>
                        <th>HÀNH ĐỘNG</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${not empty datPhongList}">
                            <c:forEach var="dp" items="${datPhongList}">
                                <tr>
                                    <td class="text-center">
                                        <span class="booking-code">
                                            ${dp.maDP}
                                        </span>
                                    </td>

                                    <td class="text-center">
                                        <span class="room-code">
                                            ${dp.maPhong}
                                        </span>
                                    </td>

                                    <td>
                                        <div class="customer-name">
                                            <i class="fas fa-user-circle"></i>
                                            ${dp.tenKH}
                                        </div>
                                    </td>

                                    <td class="text-center">
                                        ${dp.soLuong}
                                    </td>

                                    <!-- Ngày đặt -->
                                    <td class="text-center date-cell">
                                        <fmt:parseDate value="${dp.ngayDat}"
                                                       pattern="yyyy-MM-dd'T'HH:mm"
                                                       var="parsedDat"
                                                       parseLocale="vi_VN"/>
                                        <c:if test="${empty parsedDat}">
                                            <fmt:parseDate value="${dp.ngayDat}"
                                                           pattern="yyyy-MM-dd HH:mm:ss"
                                                           var="parsedDat"
                                                           parseLocale="vi_VN"/>
                                        </c:if>
                                        <fmt:formatDate value="${parsedDat}"
                                                        pattern="dd/MM/yyyy HH:mm"/>
                                    </td>

                                    <!-- Ngày nhận -->
                                    <td class="text-center date-cell">
                                        <fmt:parseDate value="${dp.ngayNhan}"
                                                       pattern="yyyy-MM-dd'T'HH:mm"
                                                       var="parsedNhan"
                                                       parseLocale="vi_VN"/>
                                        <c:if test="${empty parsedNhan}">
                                            <fmt:parseDate value="${dp.ngayNhan}"
                                                           pattern="yyyy-MM-dd HH:mm:ss"
                                                           var="parsedNhan"
                                                           parseLocale="vi_VN"/>
                                        </c:if>
                                        <c:if test="${empty parsedNhan}">
                                            <fmt:parseDate value="${dp.ngayNhan}"
                                                           pattern="yyyy-MM-dd"
                                                           var="parsedNhan"
                                                           parseLocale="vi_VN"/>
                                        </c:if>
                                        <fmt:formatDate value="${parsedNhan}"
                                                        pattern="dd/MM/yyyy"/>
                                    </td>

                                    <!-- Ngày trả -->
                                    <td class="text-center date-cell">
                                        <fmt:parseDate value="${dp.ngayTra}"
                                                       pattern="yyyy-MM-dd'T'HH:mm"
                                                       var="parsedTra"
                                                       parseLocale="vi_VN"/>
                                        <c:if test="${empty parsedTra}">
                                            <fmt:parseDate value="${dp.ngayTra}"
                                                           pattern="yyyy-MM-dd HH:mm:ss"
                                                           var="parsedTra"
                                                           parseLocale="vi_VN"/>
                                        </c:if>
                                        <c:if test="${empty parsedTra}">
                                            <fmt:parseDate value="${dp.ngayTra}"
                                                           pattern="yyyy-MM-dd"
                                                           var="parsedTra"
                                                           parseLocale="vi_VN"/>
                                        </c:if>
                                        <fmt:formatDate value="${parsedTra}"
                                                        pattern="dd/MM/yyyy"/>
                                    </td>

                                    <!-- Tiền cọc -->
                                    <td class="text-end money-cell deposit-cell">
                                        <fmt:formatNumber value="${dp.tienCoc}"
                                                          type="number"
                                                          maxFractionDigits="0"/> đ
                                    </td>

                                    <!-- Trạng thái cọc -->
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${dp.trangThaiCoc == 'Đã cọc'}">
                                                <span class="status-badge status-paid">
                                                    <i class="fas fa-check-circle"></i>
                                                    Đã cọc
                                                </span>
                                            </c:when>

                                            <c:when test="${dp.trangThaiCoc == 'Đã hoàn tiền'}">
                                                <span class="status-badge status-refunded">
                                                    <i class="fas fa-undo"></i>
                                                    Đã hoàn tiền
                                                </span>
                                            </c:when>

                                            <c:when test="${dp.trangThaiCoc == 'Phạt Cọc'}">
                                                <span class="status-badge status-penalty">
                                                    <i class="fas fa-exclamation-circle"></i>
                                                    Phạt cọc
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="status-badge status-unknown">
                                                    Chưa cập nhật
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Tổng tiền -->
                                    <td class="text-end money-cell total-cell">
                                        <fmt:formatNumber value="${dp.tongTien}"
                                                          type="number"
                                                          maxFractionDigits="0"/> đ
                                    </td>

                                    <!-- Trạng thái đặt phòng -->
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${dp.trangThai == 'Chờ xác nhận'}">
                                                <span class="status-badge status-pending">
                                                    ${dp.trangThai}
                                                </span>
                                            </c:when>

                                            <c:when test="${dp.trangThai == 'Đã xác nhận'}">
                                                <span class="status-badge status-confirmed">
                                                    ${dp.trangThai}
                                                </span>
                                            </c:when>

                                            <c:when test="${dp.trangThai == 'Đã thuê'}">
                                                <span class="status-badge status-renting">
                                                    ${dp.trangThai}
                                                </span>
                                            </c:when>

                                            <c:when test="${dp.trangThai == 'Đã hủy'}">
                                                <span class="status-badge status-cancelled">
                                                    ${dp.trangThai}
                                                </span>
                                            </c:when>

                                            <c:when test="${dp.trangThai == 'Hoàn thành'}">
                                                <span class="status-badge status-completed">
                                                    ${dp.trangThai}
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="status-badge status-unknown">
                                                    ${dp.trangThai}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Hành động -->
                                    <td class="text-center">
                                        <div class="booking-actions">

                                            <!-- Xuất hóa đơn -->
                                            <c:choose>
                                                <c:when test="${dp.trangThai == 'Đã thuê' || dp.trangThai == 'Hoàn thành'}">
                                                    <a href="${pageContext.request.contextPath}/admin/export-invoice?maDP=${dp.maDP}"
                                                       class="action-btn action-invoice"
                                                       title="Xuất hóa đơn"
                                                       target="_blank">
                                                        <i class="fas fa-file-invoice"></i>
                                                    </a>
                                                </c:when>

                                                <c:otherwise>
                                                    <button type="button"
                                                            class="action-btn action-disabled"
                                                            disabled
                                                            title="Chỉ có thể xuất hóa đơn khi đơn đã thuê hoặc hoàn thành">
                                                        <i class="fas fa-file-invoice"></i>
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- Sửa -->
                                            <a href="${pageContext.request.contextPath}/admin/dat-phong?action=edit&maDP=${dp.maDP}"
                                               class="action-btn action-edit"
                                               title="Sửa đặt phòng">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <!-- Xóa -->
                                            <c:choose>
                                                <c:when test="${dp.trangThai == 'Đã hủy' || dp.trangThai == 'Hoàn thành'}">
                                                    <a href="${pageContext.request.contextPath}/admin/dat-phong?action=delete&maDP=${dp.maDP}"
                                                       class="action-btn action-delete"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa đặt phòng này?');"
                                                       title="Xóa đặt phòng">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </a>
                                                </c:when>

                                                <c:otherwise>
                                                    <button type="button"
                                                            class="action-btn action-disabled"
                                                            disabled
                                                            title="Chỉ có thể xóa khi đơn đã hủy hoặc hoàn thành">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="12" class="empty-table">
                                    <div class="empty-icon">
                                        <i class="fas fa-calendar-times"></i>
                                    </div>
                                    <h6>Không tìm thấy đơn đặt phòng</h6>
                                    <p>Hãy thử thay đổi từ khóa hoặc trạng thái lọc.</p>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Phân trang -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Phân trang đặt phòng" class="booking-pagination">
                <ul class="pagination justify-content-center custom-pagination">

                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/admin/dat-phong?action=list&page=${currentPage - 1}&keyword=${keyword}&status=${status}"
                           aria-label="Trang trước">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/dat-phong?action=list&page=${i}&keyword=${keyword}&status=${status}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/admin/dat-phong?action=list&page=${currentPage + 1}&keyword=${keyword}&status=${status}"
                           aria-label="Trang tiếp">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>

                </ul>
            </nav>
        </c:if>

    </div>
</div>


<style>
    /* Tổng thể */
    .booking-page {
        padding: 20px;
        width: 100%;
        max-width: 100%;
        min-width: 0;
        color: #eeeeee;
        background: #151515;
        border-radius: 10px;
        font-family: "Plus Jakarta Sans", sans-serif;
        box-sizing: border-box;
    }

    .booking-page * {
        box-sizing: border-box;
    }

    /* Tiêu đề */
    .booking-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        margin-bottom: 20px;
    }

    .booking-subtitle {
        color: #ff5c68;
        font-size: 11px;
        font-weight: bold;
    }

    .booking-header h2 {
        margin: 8px 0;
        color: #ffffff;
        font-size: 25px;
        font-weight: bold;
    }

    .booking-header h2 i {
        color: #e63946;
        margin-right: 8px;
    }

    .booking-header p {
        margin: 0;
        color: #aaaaaa;
        font-size: 13px;
    }

    .booking-add-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 15px;
        border-radius: 6px;
        background: #dc3545;
        color: white;
        text-decoration: none;
        font-size: 13px;
    }

    .booking-add-btn:hover {
        background: #bb2d3b;
        color: white;
    }

    /* Các khung nội dung */
    .booking-glass-card {
        width: 100%;
        min-width: 0;
        margin-bottom: 20px;
        border: 1px solid #333333;
        border-radius: 8px;
        background: #1e1e1e;
        overflow: hidden;
    }

    .filter-card {
        padding: 20px;
    }

    .section-heading,
    .table-heading {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 18px;
    }

    .section-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        flex-shrink: 0;
        border-radius: 6px;
        background: #382024;
        color: #ff5c68;
    }

    .section-heading h5,
    .table-heading h5 {
        margin: 0 0 5px;
        color: #ffffff;
        font-size: 16px;
        font-weight: bold;
    }

    .section-heading p,
    .table-heading p {
        margin: 0;
        color: #aaaaaa;
        font-size: 12px;
    }

    /* Bộ lọc */
    .booking-filter-form {
        display: grid;
        grid-template-columns: minmax(0, 1.5fr) minmax(0, 1fr) auto;
        gap: 15px;
        align-items: end;
    }

    .filter-field {
        min-width: 0;
    }

    .filter-field label {
        display: block;
        margin-bottom: 7px;
        color: #dddddd;
        font-size: 12px;
        font-weight: bold;
    }

    .booking-input-group {
        display: flex;
        align-items: center;
        gap: 10px;
        min-height: 40px;
        padding: 0 12px;
        border: 1px solid #444444;
        border-radius: 6px;
        background: #151515;
    }

    .booking-input-group i {
        color: #ff5c68;
    }

    .booking-input-group input {
        width: 100%;
        min-width: 0;
        padding: 10px 0;
        outline: none;
        border: none;
        background: transparent;
        color: white;
        font-size: 12px;
    }

    .booking-input-group input::placeholder {
        color: #888888;
    }

    .booking-select {
        width: 100%;
        min-height: 40px;
        padding: 8px 12px;
        border: 1px solid #444444;
        border-radius: 6px;
        background: #151515;
        color: white;
        font-size: 12px;
        outline: none;
    }

    .booking-select option {
        background: #151515;
        color: white;
    }

    .filter-actions {
        display: flex;
        gap: 8px;
    }

    .booking-filter-btn,
    .booking-reset-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        min-height: 40px;
        padding: 0 13px;
        border-radius: 6px;
        font-size: 12px;
        text-decoration: none;
        white-space: nowrap;
        cursor: pointer;
    }

    .booking-filter-btn {
        border: 1px solid #dc3545;
        background: #dc3545;
        color: white;
    }

    .booking-filter-btn:hover {
        background: #bb2d3b;
    }

    .booking-reset-btn {
        border: 1px solid #555555;
        background: #292929;
        color: #dddddd;
    }

    .booking-reset-btn:hover {
        background: #383838;
        color: white;
    }

    /* Bảng dữ liệu */
    .table-card {
        padding: 20px 0 10px;
    }

    .table-heading {
        justify-content: space-between;
        flex-wrap: wrap;
        padding: 0 20px;
    }

    .table-heading h5 i {
        margin-right: 7px;
        color: #e63946;
    }

    .table-label {
        padding: 7px 10px;
        border-radius: 5px;
        background: #382024;
        color: #ff7b86;
        font-size: 11px;
    }

    .booking-table-wrapper {
        width: 100%;
        max-width: 100%;
        overflow-x: auto;
        border-top: 1px solid #333333;
    }

    .booking-table {
        width: 100%;
        min-width: 1400px;
        margin: 0;
        color: #eeeeee;
        font-size: 12px;
        white-space: nowrap;
        border-collapse: collapse;
    }

    .booking-table thead th {
        padding: 13px 10px;
        border: none;
        border-bottom: 1px solid #4b292d;
        background: #292020;
        color: #ff7b86;
        text-align: center;
        font-size: 10px;
        font-weight: bold;
    }

    .booking-table tbody td {
        padding: 12px 10px;
        border-bottom: 1px solid #333333;
        background: #1e1e1e;
        color: #dddddd;
        vertical-align: middle;
    }

    .booking-table tbody tr:hover td {
        background: #292020;
    }

    .booking-code {
        padding: 5px 8px;
        border-radius: 4px;
        background: #382024;
        color: #ff7b86;
        font-weight: bold;
    }

    .room-code {
        color: #ffffff;
        font-weight: bold;
    }

    .customer-name {
        display: flex;
        align-items: center;
        gap: 7px;
        color: #eeeeee;
    }

    .customer-name i {
        color: #ff7b86;
        font-size: 16px;
    }

    .date-cell {
        color: #cccccc !important;
        font-size: 11px;
    }

    .money-cell {
        font-weight: bold;
    }

    .deposit-cell {
        color: #75d69c !important;
    }

    .total-cell {
        color: #ff7b86 !important;
    }

    /* Trạng thái */
    .status-badge {
        display: inline-block;
        padding: 6px 8px;
        border: 1px solid transparent;
        border-radius: 5px;
        font-size: 10px;
        font-weight: bold;
        white-space: nowrap;
    }

    .status-paid,
    .status-confirmed {
        background: #193426;
        color: #75d69c;
        border-color: #28543b;
    }

    .status-refunded {
        background: #19333e;
        color: #75d5f5;
        border-color: #285365;
    }

    .status-penalty,
    .status-cancelled {
        background: #3b2024;
        color: #ff7b86;
        border-color: #5b2b32;
    }

    .status-pending {
        background: #3b321b;
        color: #ffd166;
        border-color: #5b4a21;
    }

    .status-renting {
        background: #3b2b1d;
        color: #ffb36b;
        border-color: #624326;
    }

    .status-completed {
        background: #302642;
        color: #c6adff;
        border-color: #493765;
    }

    .status-unknown {
        background: #303030;
        color: #cccccc;
        border-color: #444444;
    }

    /* Nút thao tác */
    .booking-actions {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 5px;
    }

    .action-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 30px;
        height: 30px;
        border: 1px solid transparent;
        border-radius: 5px;
        text-decoration: none;
        font-size: 12px;
        cursor: pointer;
    }

    .action-invoice {
        background: #19333e;
        color: #75d5f5;
        border-color: #285365;
    }

    .action-edit {
        background: #3b321b;
        color: #ffd166;
        border-color: #5b4a21;
    }

    .action-delete {
        background: #3b2024;
        color: #ff7b86;
        border-color: #5b2b32;
    }

    .action-invoice:hover {
        background: #0dcaf0;
        color: #111111;
    }

    .action-edit:hover {
        background: #ffc107;
        color: #111111;
    }

    .action-delete:hover {
        background: #dc3545;
        color: white;
    }

    .action-disabled,
    .action-disabled:disabled {
        background: #292929;
        color: #777777;
        border-color: #383838;
        cursor: not-allowed;
        opacity: 0.6;
    }

    /* Không có dữ liệu */
    .booking-table .empty-table {
        padding: 40px 15px;
        text-align: center;
        white-space: normal;
    }

    .empty-icon {
        margin-bottom: 12px;
        color: #e63946;
        font-size: 32px;
    }

    .empty-table h6 {
        color: white;
        font-weight: bold;
    }

    .empty-table p {
        margin: 0;
        color: #aaaaaa;
        font-size: 12px;
    }

    /* Phân trang */
    .booking-pagination {
        padding: 18px 10px 8px;
    }

    .custom-pagination {
        display: flex;
        flex-wrap: wrap;
        gap: 5px;
        margin-bottom: 0;
    }

    .custom-pagination .page-link {
        display: flex;
        align-items: center;
        justify-content: center;
        min-width: 34px;
        height: 34px;
        padding: 0 9px;
        border: 1px solid #444444;
        border-radius: 5px !important;
        background: #252525;
        color: #dddddd;
        font-size: 12px;
        box-shadow: none;
    }

    .custom-pagination .page-link:hover {
        background: #382024;
        color: #ff7b86;
    }

    .custom-pagination .page-item.active .page-link {
        border-color: #dc3545;
        background: #dc3545;
        color: white;
    }

    .custom-pagination .page-item.disabled .page-link {
        background: #202020;
        color: #666666;
    }

    /* Thông báo */
    .booking-alert {
        border-radius: 6px;
        font-size: 13px;
    }

    /* Responsive */
    @media (max-width: 1200px) {
        .booking-filter-form {
            grid-template-columns: 1fr 1fr;
        }

        .filter-actions {
            grid-column: 1 / -1;
        }
    }

    @media (max-width: 768px) {
        .booking-page {
            padding: 12px;
        }

        .booking-header h2 {
            font-size: 21px;
        }

        .booking-add-btn {
            width: 100%;
            justify-content: center;
        }

        .booking-filter-form {
            grid-template-columns: 1fr;
        }

        .filter-actions {
            grid-column: auto;
            flex-wrap: wrap;
        }

        .booking-filter-btn,
        .booking-reset-btn {
            flex: 1;
        }

        .table-heading {
            padding: 0 12px;
        }
    }
</style>
