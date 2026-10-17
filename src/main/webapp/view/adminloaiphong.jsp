
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* Tổng thể */
    .loai-phong-page {
        padding: 26px;
        color: #f5f5f7;
        background: #0b0b0f;
        border-radius: 12px;
        min-height: 100%;
    }

    .loai-phong-page * {
        box-sizing: border-box;
    }

    /* Tiêu đề */
    .loai-phong-page .page-heading {
        color: #ffffff;
        font-size: 26px;
        font-weight: 700;
        margin: 0;
    }

    .loai-phong-page .page-heading i {
        color: #ff304f;
    }

    .loai-phong-page .page-divider {
        border: 0;
        border-top: 1px solid #383838;
        margin: 22px 0;
    }

    /* Nút thêm */
    .loai-phong-page .btn-add {
        padding: 11px 17px;
        color: #ffffff;
        background: #ff304f;
        border: 1px solid #ff304f;
        border-radius: 7px;
        font-size: 13px;
        font-weight: 700;
        text-decoration: none;
        white-space: nowrap;
    }

    .loai-phong-page .btn-add:hover {
        color: #ffffff;
        background: #b5122b;
        border-color: #b5122b;
    }

    /* Thông báo */
    .loai-phong-page .alert {
        border-radius: 7px;
        font-size: 13px;
        margin-bottom: 22px;
    }

    .loai-phong-page .alert-success {
        color: #75e6a5;
        background: #193629;
        border-color: #285a40;
    }

    .loai-phong-page .alert-danger {
        color: #ff8b96;
        background: #3a2024;
        border-color: #653038;
    }

    .loai-phong-page .btn-close {
        filter: invert(1);
    }

    /* Khung bảng */
    .loai-phong-page .table-card {
        background: #1e1e1e;
        border: 1px solid #383838;
        border-radius: 9px;
        overflow: hidden;
    }

    .loai-phong-page .table-header {
        padding: 18px 22px;
        border-bottom: 1px solid #383838;
    }

    .loai-phong-page .table-title {
        margin: 0;
        color: #ffffff;
        font-size: 16px;
        font-weight: 700;
    }

    .loai-phong-page .table-title i {
        color: #ff304f;
        margin-right: 8px;
    }

    .loai-phong-page .table-responsive {
        width: 100%;
        overflow-x: auto;
    }

    /* Bảng dữ liệu */
    .loai-phong-page .loai-phong-table {
        width: 100%;
        min-width: 600px;
        margin-bottom: 0;
        color: #eeeeee;
        font-size: 13px;

        --bs-table-bg: transparent;
        --bs-table-color: #eeeeee;
        --bs-table-border-color: #343434;
        --bs-table-hover-bg: #292326;
        --bs-table-hover-color: #ffffff;
    }

    .loai-phong-page .loai-phong-table thead th {
        padding: 15px 14px;
        color: #ff6474 !important;
        background: #2b2022 !important;
        border-color: #443033 !important;
        font-size: 12px;
        font-weight: 700;
        white-space: nowrap;
    }

    .loai-phong-page .loai-phong-table tbody td {
        padding: 14px;
        color: #eeeeee;
        background: transparent;
        border-color: #343434;
        vertical-align: middle;
    }

    .loai-phong-page .loai-code {
        color: #ff6474;
        font-weight: 700;
    }

    .loai-phong-page .loai-name {
        color: #ffffff;
        font-weight: 600;
    }

    .loai-phong-page .loai-description {
        min-width: 180px;
        max-width: 450px;
        white-space: normal;
        line-height: 1.5;
    }

    /* Nút Sửa và Xóa */
    .loai-phong-page .action-buttons {
        display: flex;
        justify-content: center;
        gap: 7px;
        white-space: nowrap;
    }

    .loai-phong-page .btn-action {
        padding: 7px 10px;
        border: 1px solid;
        border-radius: 6px;
        font-size: 11px;
        font-weight: 700;
        text-decoration: none;
    }

    .loai-phong-page .btn-edit {
        color: #fbbf24;
        background: #302a1c;
        border-color: #65502a;
    }

    .loai-phong-page .btn-edit:hover {
        color: #111111;
        background: #fbbf24;
        border-color: #fbbf24;
    }

    .loai-phong-page .btn-delete {
        color: #ff647a;
        background: #321d21;
        border-color: #653038;
    }

    .loai-phong-page .btn-delete:hover {
        color: #ffffff;
        background: #dc3545;
        border-color: #dc3545;
    }

    /* Khi không có dữ liệu */
    .loai-phong-page .empty-row {
        padding: 35px 15px !important;
        color: #a1a1ae !important;
        text-align: center;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .loai-phong-page {
            padding: 16px;
        }

        .loai-phong-page .page-heading {
            font-size: 21px;
        }

        .loai-phong-page .btn-add {
            padding: 9px 12px;
            font-size: 12px;
        }

        .loai-phong-page .table-header {
            padding: 15px;
        }
    }
</style>

<div class="loai-phong-page">
    <div class="container-fluid p-0">

        <!-- Tiêu đề trang -->
        <div class="d-flex justify-content-between align-items-center
                    flex-wrap gap-3 mb-3">

            <h3 class="page-heading">
                <i class="fas fa-list-alt me-2"></i>
                Quản Lý Loại Phòng
            </h3>

            <a href="${pageContext.request.contextPath}/admin/loai-phong?action=form-add"
               class="btn-add">
                <i class="fas fa-plus me-1"></i>
                Thêm Loại Phòng Mới
            </a>
        </div>

        <hr class="page-divider">

        <!-- Thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <c:set var="isError"
                   value="${sessionScope.message.contains('Không thể') || sessionScope.message.contains('thất bại')}" />

            <div class="alert ${isError ? 'alert-danger' : 'alert-success'}
                        alert-dismissible fade show"
                 role="alert">

                <i class="fas ${isError ? 'fa-exclamation-triangle' : 'fa-check-circle'} me-2"></i>
                ${sessionScope.message}

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Đóng"></button>
            </div>

            <c:remove var="message" scope="session"/>
        </c:if>

        <!-- Danh sách loại phòng -->
        <div class="table-card">

            <div class="table-header">
                <h5 class="table-title">
                    <i class="fas fa-table"></i>
                    Danh sách loại phòng
                </h5>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle loai-phong-table">

                    <thead>
                        <tr>
                            <th>MÃ LOẠI</th>
                            <th>TÊN LOẠI PHÒNG</th>
                            <th>MÔ TẢ</th>
                            <th class="text-center">HÀNH ĐỘNG</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${not empty loaiPhongList}">

                                <c:forEach items="${loaiPhongList}" var="lp">
                                    <tr>
                                        <td>
                                            <span class="loai-code">
                                                ${lp.maLoai}
                                            </span>
                                        </td>

                                        <td>
                                            <span class="loai-name">
                                                ${lp.tenLoai}
                                            </span>
                                        </td>

                                        <td>
                                            <div class="loai-description">
                                                ${lp.moTa}
                                            </div>
                                        </td>

                                        <td>
                                            <div class="action-buttons">

                                                <a href="${pageContext.request.contextPath}/admin/loai-phong?action=edit&amp;maLoai=${lp.maLoai}"
                                                   class="btn-action btn-edit">
                                                    <i class="fas fa-edit"></i>
                                                    Sửa
                                                </a>

                                                <a href="${pageContext.request.contextPath}/admin/loai-phong?action=delete&amp;maLoai=${lp.maLoai}"
                                                   class="btn-action btn-delete"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa loại phòng này không?');">
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
                                    <td colspan="4" class="empty-row">
                                        <i class="fas fa-folder-open me-2"></i>
                                        Chưa có loại phòng nào trong hệ thống.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>

                </table>
            </div>
        </div>

    </div>
</div>
