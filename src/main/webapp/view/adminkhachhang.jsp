
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* ===== TỔNG THỂ ===== */
    .customer-page {
        --customer-red: #ff304f;
        --customer-red-dark: #b5122b;
        --customer-text: #f5f5f7;
        --customer-muted: #a1a1ae;
        --customer-border: rgba(255, 255, 255, 0.10);

        padding: 26px;
        min-height: 100%;
        color: var(--customer-text);
        background: #0b0b0f;
        border-radius: 12px;
    }

    .customer-page * {
        box-sizing: border-box;
    }

    /* ===== TIÊU ĐỀ ===== */
    .customer-page .customer-heading {
        margin: 0 0 8px;
        color: #ffffff;
        font-size: 26px;
        font-weight: 750;
    }

    .customer-page .customer-heading i {
        color: var(--customer-red);
    }

    .customer-page .customer-description {
        margin: 0;
        color: var(--customer-muted);
        font-size: 13px;
    }

    .customer-page .customer-divider {
        height: 1px;
        margin: 22px 0;
        border: 0;
        background: var(--customer-border);
    }

    /* ===== NÚT THÊM KHÁCH HÀNG ===== */
    .customer-page .btn-add-customer {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 11px 17px;

        color: #ffffff;
        background: var(--customer-red);
        border: 1px solid var(--customer-red);
        border-radius: 8px;

        font-size: 13px;
        font-weight: 700;
        text-decoration: none;
        white-space: nowrap;
    }

    .customer-page .btn-add-customer:hover {
        color: #ffffff;
        background: var(--customer-red-dark);
        border-color: var(--customer-red-dark);
    }

    /* ===== THÔNG BÁO ===== */
    .customer-page .customer-alert {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 16px;
        margin-bottom: 22px;
        border: 1px solid;
        border-radius: 8px;
        font-size: 13px;
    }

    .customer-page .customer-alert.alert-success {
        color: #75e6a5;
        background: #193629;
        border-color: #285a40;
    }

    .customer-page .customer-alert.alert-danger {
        color: #ff8b96;
        background: #3a2024;
        border-color: #653038;
    }

    .customer-page .customer-alert .btn-close {
        margin-left: auto;
        filter: invert(1);
    }

    /* ===== KHUNG TÌM KIẾM ===== */
    .customer-page .customer-filter {
        padding: 20px;
        margin-bottom: 24px;
        background: #1e1e1e;
        border: 1px solid #383838;
        border-radius: 10px;
    }

    .customer-page .form-label {
        display: block;
        margin-bottom: 9px;
        color: #eeeeee;
        font-size: 12px;
        font-weight: 700;
        text-transform: uppercase;
    }

    .customer-page .form-label i {
        margin-right: 5px;
        color: var(--customer-red);
    }

    .customer-page .input-group-text,
    .customer-page .form-control {
        min-height: 45px;
        color: #f5f5f7;
        background: #171717;
        border: 1px solid #414141;
        font-size: 13px;
    }

    .customer-page .input-group-text {
        color: var(--customer-red);
        border-right: 0;
    }

    .customer-page .input-group .form-control {
        border-left: 0;
    }

    .customer-page .form-control::placeholder {
        color: #85858f;
        opacity: 1;
    }

    .customer-page .form-control:focus {
        color: #ffffff;
        background: #171717;
        border-color: var(--customer-red);
        box-shadow: 0 0 0 2px rgba(255, 48, 79, 0.12);
    }

    .customer-page .btn-filter {
        min-height: 45px;
        padding: 10px 20px;
        color: #ffffff;
        background: var(--customer-red);
        border: 1px solid var(--customer-red);
        border-radius: 8px;
        font-size: 13px;
        font-weight: 700;
    }

    .customer-page .btn-filter:hover {
        color: #ffffff;
        background: var(--customer-red-dark);
        border-color: var(--customer-red-dark);
    }

    .customer-page .btn-reset {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 45px;
        min-height: 45px;
        padding: 10px;

        color: #cccccc;
        background: #242424;
        border: 1px solid #414141;
        border-radius: 8px;
        text-decoration: none;
    }

    .customer-page .btn-reset:hover {
        color: #ffffff;
        background: #352326;
        border-color: var(--customer-red);
    }

    /* ===== KHUNG BẢNG ===== */
    .customer-page .customer-table-card {
        overflow: hidden;
        background: #1e1e1e;
        border: 1px solid #383838;
        border-radius: 10px;
    }

    .customer-page .customer-table-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        padding: 20px 22px;
        border-bottom: 1px solid #383838;
    }

    .customer-page .customer-table-title {
        margin: 0;
        color: #ffffff;
        font-size: 16px;
        font-weight: 750;
    }

    .customer-page .customer-table-title i {
        margin-right: 8px;
        color: var(--customer-red);
    }

    .customer-page .customer-table-caption {
        margin-top: 6px;
        color: var(--customer-muted);
        font-size: 12px;
    }

    .customer-page .customer-table-icon {
        color: var(--customer-red);
        font-size: 20px;
    }

    .customer-page .table-responsive {
        width: 100%;
        overflow-x: auto;
    }

    /* ===== BẢNG DỮ LIỆU ===== */
    .customer-page .customer-table {
        width: 100%;
        min-width: 800px;
        margin-bottom: 0;
        color: #eeeeee;
        background: transparent;
        font-size: 13px;

        --bs-table-bg: transparent;
        --bs-table-color: #eeeeee;
        --bs-table-border-color: rgba(255, 255, 255, 0.08);
        --bs-table-hover-bg: #292326;
        --bs-table-hover-color: #ffffff;
    }

    .customer-page .customer-table thead th {
        padding: 15px 14px;
        color: #ff6474 !important;
        background: #2b2022 !important;
        border-color: #443033 !important;
        font-size: 11px;
        font-weight: 800;
        white-space: nowrap;
    }

    .customer-page .customer-table tbody td {
        padding: 15px 14px;
        color: #eeeeee;
        background: transparent;
        border-color: rgba(255, 255, 255, 0.08);
        vertical-align: middle;
    }

    .customer-page .customer-table tbody tr:hover > * {
        color: #ffffff;
        background: #292326;
    }

    .customer-page .customer-code {
        color: #ff6474;
        font-weight: 800;
    }

    .customer-page .customer-name {
        color: #ffffff;
        font-weight: 650;
    }

    .customer-page .customer-email {
        color: #c9c9d2;
    }

    .customer-page .customer-address {
        min-width: 150px;
        max-width: 250px;
        white-space: normal;
    }

    /* ===== NÚT SỬA VÀ XÓA ===== */
    .customer-page .customer-actions {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
    }

    .customer-page .btn-customer-action {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
        padding: 7px 10px;

        border: 1px solid;
        border-radius: 7px;
        font-size: 11px;
        font-weight: 700;
        text-decoration: none;
        white-space: nowrap;
    }

    .customer-page .btn-customer-edit {
        color: #fbbf24;
        background: rgba(251, 191, 36, 0.07);
        border-color: rgba(251, 191, 36, 0.30);
    }

    .customer-page .btn-customer-edit:hover {
        color: #111111;
        background: #fbbf24;
        border-color: #fbbf24;
    }

    .customer-page .btn-customer-delete {
        color: #ff647a;
        background: rgba(255, 48, 79, 0.07);
        border-color: rgba(255, 48, 79, 0.30);
    }

    .customer-page .btn-customer-delete:hover {
        color: #ffffff;
        background: var(--customer-red);
        border-color: var(--customer-red);
    }

    /* ===== KHÔNG CÓ DỮ LIỆU ===== */
    .customer-page .customer-empty {
        padding: 40px 20px !important;
        color: var(--customer-muted) !important;
        text-align: center;
        white-space: normal;
    }

    .customer-page .customer-empty i {
        display: block;
        margin-bottom: 10px;
        color: #666672;
        font-size: 28px;
    }

    .customer-page .customer-empty strong {
        display: block;
        margin-bottom: 5px;
        color: #eeeeee;
        font-size: 14px;
    }

    /* ===== PHÂN TRANG ===== */
    .customer-page .custom-pagination {
        gap: 6px;
        flex-wrap: wrap;
    }

    .customer-page .custom-pagination .page-link {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        min-width: 38px;
        min-height: 38px;
        padding: 8px 12px;

        color: #ccccd5;
        background: #1e1e1e;
        border: 1px solid #3b3b3b;
        border-radius: 7px !important;
        font-size: 12px;
    }

    .customer-page .custom-pagination .page-link:hover {
        color: #ff6474;
        background: #352326;
        border-color: var(--customer-red);
    }

    .customer-page .custom-pagination .page-item.active .page-link {
        color: #ffffff;
        background: var(--customer-red);
        border-color: var(--customer-red);
    }

    .customer-page .custom-pagination .page-item.disabled .page-link {
        color: #666666;
        background: #171717;
        border-color: #333333;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
        .customer-page {
            padding: 16px;
        }

        .customer-page .customer-heading {
            font-size: 21px;
        }

        .customer-page .customer-filter {
            padding: 15px;
        }

        .customer-page .customer-table-header {
            padding: 16px;
        }

        .customer-page .btn-add-customer {
            padding: 10px 12px;
            font-size: 12px;
        }
    }
</style>

<div class="customer-page">
    <div class="container-fluid p-0">

        <!-- TIÊU ĐỀ TRANG -->
        <div class="d-flex justify-content-between align-items-center
                    flex-wrap gap-3 mb-3">

            <div>
                <h3 class="customer-heading">
                    <i class="fas fa-users me-2"></i>
                    Quản Lý <span style="color: #ff304f;">Khách Hàng</span>
                </h3>

                <p class="customer-description">
                    Quản lý thông tin khách hàng trong hệ thống khách sạn.
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/admin/khach-hang?action=form-add"
               class="btn-add-customer">
                <i class="fas fa-plus"></i>
                Thêm khách hàng mới
            </a>
        </div>

        <hr class="customer-divider">

        <!-- THÔNG BÁO -->
        <c:if test="${not empty sessionScope.message}">
            <c:set var="isError"
                   value="${sessionScope.message.contains('Không thể') || sessionScope.message.contains('thất bại')}" />

            <div class="customer-alert alert-dismissible fade show
                        ${isError ? 'alert-danger' : 'alert-success'}"
                 role="alert">

                <i class="fas ${isError ? 'fa-exclamation-circle' : 'fa-check-circle'}"></i>

                <div class="flex-grow-1">
                    ${sessionScope.message}
                </div>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Đóng"></button>
            </div>

            <c:remove var="message" scope="session"/>
        </c:if>

        <!-- TÌM KIẾM KHÁCH HÀNG -->
        <form action="${pageContext.request.contextPath}/admin/khach-hang"
              method="POST"
              class="customer-filter">

            <input type="hidden" name="action" value="list">

            <div class="row align-items-end g-3">

                <div class="col-lg-9 col-md-8">
                    <label class="form-label">
                        <i class="fas fa-search"></i>
                        Tìm kiếm khách hàng (Tên / Số điện thoại)
                    </label>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-search"></i>
                        </span>

                        <input type="text"
                               class="form-control"
                               name="keyword"
                               value="${param.keyword}"
                               placeholder="Nhập tên hoặc số điện thoại khách hàng...">
                    </div>
                </div>

                <div class="col-lg-3 col-md-4">
                    <label class="form-label d-none d-md-block">
                        Thao tác
                    </label>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn-filter flex-grow-1">
                            <i class="fas fa-search me-1"></i>
                            Lọc
                        </button>

                        <a href="${pageContext.request.contextPath}/admin/khach-hang?action=list"
                           class="btn-reset"
                           title="Làm mới bộ lọc">
                            <i class="fas fa-sync-alt"></i>
                        </a>
                    </div>
                </div>

            </div>
        </form>

        <!-- BẢNG KHÁCH HÀNG -->
        <div class="customer-table-card">

            <div class="customer-table-header">
                <div>
                    <h5 class="customer-table-title">
                        <i class="fas fa-list-ul"></i>
                        Danh sách khách hàng
                    </h5>

                    <div class="customer-table-caption">
                        Thông tin chi tiết và thao tác quản lý khách hàng.
                    </div>
                </div>

                <i class="fas fa-table customer-table-icon"></i>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle customer-table">

                    <thead>
                        <tr>
                            <th class="ps-4">Mã khách hàng</th>
                            <th>Họ và tên</th>
                            <th>Số điện thoại</th>
                            <th>Email</th>
                            <th>Địa chỉ</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${not empty khachHangList}">

                                <c:forEach items="${khachHangList}" var="kh">
                                    <tr>
                                        <td class="ps-4">
                                            <span class="customer-code">
                                                ${kh.maKH}
                                            </span>
                                        </td>

                                        <td>
                                            <span class="customer-name">
                                                ${kh.hoTen}
                                            </span>
                                        </td>

                                        <td>${kh.sdt}</td>

                                        <td>
                                            <span class="customer-email">
                                                ${kh.email}
                                            </span>
                                        </td>

                                        <td class="customer-address">
                                            ${kh.diaChi}
                                        </td>

                                        <td>
                                            <div class="customer-actions">

                                                <a href="${pageContext.request.contextPath}/admin/khach-hang?action=edit&amp;maKH=${kh.maKH}"
                                                   class="btn-customer-action btn-customer-edit"
                                                   title="Sửa khách hàng">
                                                    <i class="fas fa-edit"></i>
                                                    Sửa
                                                </a>

                                                <a href="${pageContext.request.contextPath}/admin/khach-hang?action=delete&amp;maKH=${kh.maKH}"
                                                   class="btn-customer-action btn-customer-delete"
                                                   title="Xóa khách hàng"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa khách hàng này không?');">
                                                    <i class="fas fa-trash"></i>
                                                    Xóa
                                                </a>

                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="customer-empty">
                                        <i class="fas fa-users"></i>
                                        <strong>Chưa có thông tin khách hàng</strong>
                                        Không tìm thấy dữ liệu phù hợp. Hãy thử thay đổi từ khóa tìm kiếm.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>

                </table>
            </div>
        </div>

        <!-- PHÂN TRANG -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Phân trang khách hàng" class="mt-4">

                <ul class="pagination justify-content-center custom-pagination">

                    <!-- TRANG TRƯỚC -->
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/admin/khach-hang?action=list&amp;page=${currentPage - 1}&amp;keyword=${keyword != null ? keyword : ''}">
                            <i class="fas fa-angle-left"></i>
                            Trước
                        </a>
                    </li>

                    <!-- SỐ TRANG -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/khach-hang?action=list&amp;page=${i}&amp;keyword=${keyword != null ? keyword : ''}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- TRANG SAU -->
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/admin/khach-hang?action=list&amp;page=${currentPage + 1}&amp;keyword=${keyword != null ? keyword : ''}">
                            Sau
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>

                </ul>
            </nav>
        </c:if>

    </div>
