
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<style>
    /* ===== TỔNG THỂ TRANG ===== */
    .room-page {
        --room-red: #ff304f;
        --room-red-dark: #b5122b;
        --room-text: #f5f5f7;
        --room-muted: #a1a1ae;
        --room-border: rgba(255,255,255,.10);
        --room-glass: rgba(255,255,255,.045);

        color: var(--room-text);
        padding: 26px;
        min-height: 100%;
        border-radius: 16px;

        background:
            radial-gradient(
                ellipse at 0% 0%,
                rgba(255,48,79,.12),
                transparent 38%
            ),
            #0b0b0f;
    }

    .room-page * {
        box-sizing: border-box;
    }

    .room-page .room-heading {
        font-size: 28px;
        font-weight: 800;
        letter-spacing: -.6px;
        color: #fff;
        margin: 0 0 8px;
    }

    .room-page .room-heading i {
        color: var(--room-red);
    }

    .room-page .room-heading span {
        color: var(--room-red);
    }

    .room-page .room-description {
        font-size: 13px;
        color: var(--room-muted);
        margin: 0;
        line-height: 1.7;
    }

    .room-page .room-breadcrumb {
        color: #858591;
        font-size: 12px;
        margin-top: 10px;
    }

    .room-page .room-divider {
        border: 0;
        height: 1px;
        background: linear-gradient(
            90deg,
            rgba(255,48,79,.55),
            rgba(255,255,255,.08),
            transparent
        );
        margin: 22px 0;
    }

    /* ===== NÚT THÊM PHÒNG ===== */
    .room-page .btn-add-room {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        gap: 9px;

        padding: 12px 18px;
        border: 1px solid rgba(255,100,120,.55);
        border-radius: 11px;

        color: #fff;
        background: linear-gradient(
            135deg,
            var(--room-red),
            var(--room-red-dark)
        );

        font-size: 13px;
        font-weight: 700;
        text-decoration: none;
        white-space: nowrap;

        box-shadow: 0 6px 20px rgba(255,48,79,.16);
        transition: all .25s ease;
    }

    .room-page .btn-add-room:hover {
        color: #fff;
        transform: translateY(-2px);
        box-shadow: 0 9px 26px rgba(255,48,79,.30);
        filter: brightness(1.08);
    }

    /* ===== CARD KÍNH MỜ ===== */
    .room-page .glass-card {
        background: linear-gradient(
            145deg,
            rgba(255,255,255,.065),
            rgba(255,255,255,.022)
        );

        border: 1px solid var(--room-border);
        border-radius: 17px;

        backdrop-filter: blur(18px);
        -webkit-backdrop-filter: blur(18px);

        box-shadow: 0 12px 35px rgba(0,0,0,.20);
    }

    .room-page .room-filter-card {
        padding: 22px;
        margin-bottom: 24px;
    }

    .room-page .form-label {
        display: block;
        margin-bottom: 9px;

        color: #c8c8d2;
        font-size: 11px;
        font-weight: 750;
        letter-spacing: .8px;
        text-transform: uppercase;
    }

    .room-page .form-label i {
        color: var(--room-red);
        margin-right: 5px;
    }

    /* ===== Ô TÌM KIẾM VÀ LỌC ===== */
    .room-page .input-group-text,
    .room-page .form-control,
    .room-page .form-select {
        min-height: 45px;
        color: #f5f5f7;

        background-color: rgba(10,10,15,.65);
        border: 1px solid rgba(255,255,255,.12);

        font-size: 13px;
    }

    .room-page .input-group-text {
        color: #ff526b;
        border-right: 0;
        border-radius: 10px 0 0 10px;
        padding: 0 14px;
    }

    .room-page .input-group .form-control {
        border-left: 0;
        border-radius: 0 10px 10px 0;
        padding-left: 2px;
    }

    .room-page .form-control,
    .room-page .form-select {
        border-radius: 10px;
        padding: 10px 13px;
    }

    .room-page .input-group .form-control {
        border-radius: 0 10px 10px 0;
    }

    .room-page .form-control::placeholder {
        color: #70707d;
    }

    .room-page .form-control:focus,
    .room-page .form-select:focus {
        color: #fff;
        background-color: rgba(20,20,28,.95);
        border-color: rgba(255,48,79,.65);
        box-shadow: 0 0 0 3px rgba(255,48,79,.10);
    }

    .room-page .form-select option {
        color: #fff;
        background: #15151c;
    }

    .room-page .btn-filter {
        min-height: 45px;
        padding: 10px 20px;

        border: 1px solid rgba(255,48,79,.45);
        border-radius: 10px;

        color: #fff;
        background: rgba(255,48,79,.15);

        font-size: 13px;
        font-weight: 700;
        white-space: nowrap;

        transition: all .25s ease;
    }

    .room-page .btn-filter:hover {
        background: var(--room-red);
        border-color: var(--room-red);
        transform: translateY(-1px);
    }

    .room-page .btn-reset {
        display: inline-flex;
        align-items: center;
        justify-content: center;

        min-width: 45px;
        min-height: 45px;
        padding: 10px;

        border: 1px solid var(--room-border);
        border-radius: 10px;

        color: #c3c3cf;
        background: rgba(255,255,255,.045);

        transition: all .25s ease;
    }

    .room-page .btn-reset:hover {
        color: #fff;
        border-color: var(--room-red);
        background: rgba(255,48,79,.13);
    }

    /* ===== THÔNG BÁO ===== */
    .room-page .room-alert {
        display: flex;
        align-items: center;
        gap: 12px;

        padding: 15px 18px;
        margin-bottom: 22px;

        border-radius: 12px;
        border: 1px solid rgba(255,255,255,.12);

        color: #f5f5f7;
        background: rgba(255,255,255,.04);
        font-size: 13px;
    }

    .room-page .room-alert.alert-success {
        border-color: rgba(74,222,128,.25);
        background: rgba(74,222,128,.07);
    }

    .room-page .room-alert.alert-danger {
        border-color: rgba(255,48,79,.30);
        background: rgba(255,48,79,.08);
    }

    .room-page .room-alert.alert-success > i {
        color: #4ade80;
    }

    .room-page .room-alert.alert-danger > i {
        color: #ff526b;
    }

    .room-page .room-alert .btn-close {
        margin-left: auto;
        flex-shrink: 0;
        filter: invert(1);
        opacity: .65;
        transform: scale(.8);
    }

    /* ===== BẢNG PHÒNG ===== */
    .room-page .room-table-card {
        overflow: hidden;
    }

    .room-page .room-table-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;

        padding: 20px 22px;
        border-bottom: 1px solid var(--room-border);
    }

    .room-page .room-table-title {
        color: #fff;
        font-size: 15px;
        font-weight: 750;
        margin: 0;
    }

    .room-page .room-table-title i {
        color: var(--room-red);
        margin-right: 9px;
    }

    .room-page .room-table-caption {
        margin-top: 5px;
        color: var(--room-muted);
        font-size: 11px;
    }

    .room-page .table-responsive {
        border-radius: 0 0 17px 17px;
    }

    .room-page .custom-admin-table {
        width: 100%;
        margin-bottom: 0;
        color: #e6e6ed;

        --bs-table-bg: transparent;
        --bs-table-color: #e6e6ed;
        --bs-table-hover-bg: rgba(255,48,79,.055);
        --bs-table-hover-color: #fff;
        --bs-table-border-color: rgba(255,255,255,.07);
    }

    .room-page .custom-admin-table thead th {
        padding: 16px 14px;

        color: #bcbcc8 !important;
        background: rgba(255,255,255,.035) !important;

        border-bottom: 1px solid rgba(255,48,79,.22);
        font-size: 10px;
        font-weight: 800;
        letter-spacing: .8px;
        text-transform: uppercase;
        white-space: nowrap;
    }

    .room-page .custom-admin-table td {
        padding: 17px 14px;
        vertical-align: middle;
        border-color: rgba(255,255,255,.065);
        font-size: 12px;
        white-space: nowrap;
    }

    .room-page .custom-admin-table tbody tr {
        transition: background .2s ease;
    }

    .room-page .custom-admin-table tbody tr:hover {
        --bs-table-bg: rgba(255,48,79,.045);
        --bs-table-accent-bg: rgba(255,48,79,.045);
    }

    .room-page .room-code {
        color: #ff6b80;
        font-weight: 800;
        letter-spacing: .3px;
    }

    .room-page .room-name {
        color: #f5f5f7;
        font-weight: 650;
    }

    .room-page .room-type {
        display: inline-block;
        padding: 6px 10px;

        color: #d5d5df;
        background: rgba(255,255,255,.055);
        border: 1px solid rgba(255,255,255,.12);
        border-radius: 7px;

        font-size: 11px;
        font-weight: 650;
    }

    .room-page .room-price {
        color: #ff647a;
        font-size: 13px;
        font-weight: 800;
    }

    .room-page .room-status {
        display: inline-flex;
        align-items: center;
        gap: 7px;

        padding: 7px 11px;
        border: 1px solid transparent;
        border-radius: 8px;

        font-size: 11px;
        font-weight: 700;
    }

    .room-page .room-status::before {
        content: "";
        width: 6px;
        height: 6px;
        flex-shrink: 0;
        border-radius: 50%;
    }

    .room-page .status-empty {
        color: #4ade80;
        background: rgba(74,222,128,.08);
        border-color: rgba(74,222,128,.20);
    }

    .room-page .status-empty::before {
        background: #4ade80;
        box-shadow: 0 0 7px rgba(74,222,128,.45);
    }

    .room-page .status-occupied {
        color: #ff647a;
        background: rgba(255,48,79,.09);
        border-color: rgba(255,48,79,.23);
    }

    .room-page .status-occupied::before {
        background: #ff526b;
        box-shadow: 0 0 7px rgba(255,48,79,.4);
    }

    /* ===== NÚT HÀNH ĐỘNG ===== */
    .room-page .room-actions {
        display: flex;
        justify-content: center;
        gap: 7px;
    }

    .room-page .btn-room-action {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        gap: 6px;

        min-height: 33px;
        padding: 7px 10px;

        border: 1px solid;
        border-radius: 8px;

        font-size: 11px;
        font-weight: 700;
        text-decoration: none;

        transition: all .2s ease;
    }

    .room-page .btn-room-edit {
        color: #fbbf24;
        border-color: rgba(251,191,36,.25);
        background: rgba(251,191,36,.07);
    }

    .room-page .btn-room-edit:hover {
        color: #111;
        border-color: #fbbf24;
        background: #fbbf24;
        transform: translateY(-1px);
    }

    .room-page .btn-room-delete {
        color: #ff647a;
        border-color: rgba(255,48,79,.27);
        background: rgba(255,48,79,.07);
    }

    .room-page .btn-room-delete:hover {
        color: #fff;
        border-color: var(--room-red);
        background: var(--room-red);
        transform: translateY(-1px);
    }

    /* ===== KHÔNG CÓ DỮ LIỆU ===== */
    .room-page .room-empty {
        padding: 48px 20px !important;
        text-align: center;
        color: var(--room-muted);
        white-space: normal !important;
    }

    .room-page .room-empty i {
        display: block;
        margin-bottom: 13px;
        color: #555563;
        font-size: 32px;
    }

    .room-page .room-empty strong {
        display: block;
        margin-bottom: 6px;
        color: #dedee7;
        font-size: 14px;
    }

    .room-page .room-empty span {
        font-size: 12px;
    }

    /* ===== PHÂN TRANG ===== */
    .room-page .custom-pagination {
        gap: 6px;
        flex-wrap: wrap;
    }

    .room-page .custom-pagination .page-link {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;

        min-width: 38px;
        min-height: 38px;
        padding: 8px 12px;

        color: #c7c7d2;
        background: rgba(255,255,255,.035);
        border: 1px solid rgba(255,255,255,.10);
        border-radius: 9px !important;

        font-size: 12px;
        font-weight: 650;

        transition: all .2s ease;
    }

    .room-page .custom-pagination .page-link:hover {
        color: #fff;
        background: rgba(255,48,79,.12);
        border-color: rgba(255,48,79,.45);
    }

    .room-page .custom-pagination .page-item.active .page-link {
        color: #fff;
        background: linear-gradient(
            135deg,
            var(--room-red),
            var(--room-red-dark)
        );
        border-color: var(--room-red);
        box-shadow: 0 4px 14px rgba(255,48,79,.17);
    }

    .room-page .custom-pagination .page-item.disabled .page-link {
        color: #555560;
        background: rgba(255,255,255,.015);
        border-color: rgba(255,255,255,.05);
        pointer-events: none;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
        .room-page {
            padding: 16px;
        }

        .room-page .room-heading {
            font-size: 22px;
        }

        .room-page .room-filter-card {
            padding: 16px;
        }

        .room-page .room-table-header {
            padding: 17px;
        }

        .room-page .btn-add-room {
            padding: 10px 12px;
            font-size: 11px;
        }

        .room-page .custom-admin-table th,
        .room-page .custom-admin-table td {
            padding: 13px 12px;
        }
    }

    @media (prefers-reduced-motion: reduce) {
        .room-page *,
        .room-page *::before,
        .room-page *::after {
            transition: none !important;
        }
    }
</style>

<div class="room-page">
    <div class="container-fluid p-0">

        <!-- TIÊU ĐỀ TRANG -->
        <div class="d-flex justify-content-between align-items-center
                    flex-wrap gap-3 mb-3">

            <div>
                <h3 class="room-heading">
                    <i class="fas fa-door-open me-2"></i>
                    Quản Lý <span>Phòng</span>
                </h3>

                <p class="room-description">
                    Quản lý thông tin chi tiết, giá cả và tình trạng phòng khách sạn
                </p>

                <div class="room-breadcrumb">
                    <i class="fas fa-home me-1"></i>
                    Trang quản trị
                    <span class="mx-2">/</span>
                    Quản lý phòng
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/admin/room?action=form-add"
               class="btn-add-room">
                <i class="fas fa-plus"></i>
                Thêm phòng mới
            </a>
        </div>

        <hr class="room-divider">

        <!-- THÔNG BÁO SESSION -->
        <c:if test="${not empty sessionScope.message}">
            <c:set var="isError"
                   value="${sessionScope.message.contains('Không thể') || sessionScope.message.contains('thất bại')}" />

            <div class="room-alert alert-dismissible fade show
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

        <!-- BỘ LỌC VÀ TÌM KIẾM -->
        <form action="${pageContext.request.contextPath}/admin/room"
              method="POST"
              class="glass-card room-filter-card">

            <input type="hidden" name="action" value="list">

            <div class="row align-items-end g-3">

                <!-- Tìm kiếm -->
                <div class="col-lg-5 col-md-6">
                    <label class="form-label">
                        <i class="fas fa-search"></i>
                        Tìm kiếm tên phòng
                    </label>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-search"></i>
                        </span>

                        <input type="text"
                               class="form-control"
                               name="keyword"
                               value="${param.keyword}"
                               placeholder="Nhập tên phòng cần tìm...">
                    </div>
                </div>

                <!-- Lọc tình trạng -->
                <div class="col-lg-4 col-md-6">
                    <label class="form-label">
                        <i class="fas fa-filter"></i>
                        Tình trạng phòng
                    </label>

                    <select class="form-select" name="status">
                        <option value=""
                                ${empty param.status ? 'selected' : ''}>
                            Tất cả tình trạng
                        </option>

                        <option value="Trống"
                                ${param.status == 'Trống' ? 'selected' : ''}>
                            Trống
                        </option>

                        <option value="Đang thuê"
                                ${param.status == 'Đang thuê' ? 'selected' : ''}>
                            Đang thuê
                        </option>
                    </select>
                </div>

                <!-- Nút lọc và làm mới -->
                <div class="col-lg-3 col-md-12">
                    <label class="form-label d-none d-lg-block">
                        Thao tác
                    </label>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn-filter flex-grow-1">
                            <i class="fas fa-search me-1"></i>
                            Lọc
                        </button>

                        <a href="${pageContext.request.contextPath}/admin/room?action=list"
                           class="btn-reset"
                           title="Làm mới bộ lọc">
                            <i class="fas fa-sync-alt"></i>
                        </a>
                    </div>
                </div>

            </div>
        </form>

        <!-- BẢNG DANH SÁCH PHÒNG -->
        <div class="glass-card room-table-card">

            <div class="room-table-header">
                <div>
                    <h5 class="room-table-title">
                        <i class="fas fa-list-ul"></i>
                        Danh sách phòng
                    </h5>

                    <div class="room-table-caption">
                        Thông tin phòng và thao tác quản lý
                    </div>
                </div>

                <i class="fas fa-table"
                   style="color:#ff526b;font-size:20px;"></i>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle custom-admin-table">

                    <thead>
                        <tr>
                            <th class="ps-4">Mã phòng</th>
                            <th>Tên phòng</th>
                            <th>Mã loại</th>
                            <th>Giá phòng</th>
                            <th>Tình trạng</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${not empty roomList}">

                                <c:forEach items="${roomList}" var="r">
                                    <tr>
                                        <!-- Mã phòng -->
                                        <td class="ps-4">
                                            <span class="room-code">
                                                ${r.maPhong}
                                            </span>
                                        </td>

                                        <!-- Tên phòng -->
                                        <td>
                                            <span class="room-name">
                                                ${r.tenPhong}
                                            </span>
                                        </td>

                                        <!-- Mã loại -->
                                        <td>
                                            <span class="room-type">
                                                ${r.maLoai}
                                            </span>
                                        </td>

                                        <!-- Giá -->
                                        <td>
                                            <span class="room-price">
                                                <fmt:formatNumber
                                                    value="${r.gia}"
                                                    pattern="#,##0"/> VNĐ
                                            </span>
                                        </td>

                                        <!-- Tình trạng -->
                                        <td>
                                            <c:choose>
                                                <c:when test="${r.tinhTrang == 'Trống'}">
                                                    <span class="room-status status-empty">
                                                        Trống
                                                    </span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="room-status status-occupied">
                                                        ${r.tinhTrang}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <!-- Hành động -->
                                        <td>
                                            <div class="room-actions">

                                                <a href="${pageContext.request.contextPath}/admin/room?action=edit&amp;maPhong=${r.maPhong}"
                                                   class="btn-room-action btn-room-edit"
                                                   title="Sửa thông tin phòng">
                                                    <i class="fas fa-pen"></i>
                                                    Sửa
                                                </a>

                                                <a href="${pageContext.request.contextPath}/admin/room?action=delete&amp;maPhong=${r.maPhong}"
                                                   class="btn-room-action btn-room-delete"
                                                   title="Xóa phòng"
                                                   onclick="return confirm('Bạn có chắc muốn xóa phòng ${r.maPhong} này không?');">
                                                    <i class="fas fa-trash-alt"></i>
                                                    Xóa
                                                </a>

                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="room-empty">
                                        <i class="fas fa-door-closed"></i>
                                        <strong>Không tìm thấy phòng</strong>
                                        <span>
                                            Hãy thử thay đổi từ khóa hoặc tình trạng lọc.
                                        </span>
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
            <nav aria-label="Phân trang danh sách phòng" class="mt-4">

                <ul class="pagination justify-content-center custom-pagination">

                    <!-- Trang trước -->
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/admin/room?action=list&amp;page=${currentPage - 1}&amp;keyword=${keyword != null ? keyword : ''}&amp;status=${status != null ? status : ''}">
                            <i class="fas fa-angle-left"></i>
                            Trước
                        </a>
                    </li>

                    <!-- Số trang -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/room?action=list&amp;page=${i}&amp;keyword=${keyword != null ? keyword : ''}&amp;status=${status != null ? status : ''}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- Trang sau -->
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/admin/room?action=list&amp;page=${currentPage + 1}&amp;keyword=${keyword != null ? keyword : ''}&amp;status=${status != null ? status : ''}">
                            Sau
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>

                </ul>
            </nav>
        </c:if>

    </div>
</div>
