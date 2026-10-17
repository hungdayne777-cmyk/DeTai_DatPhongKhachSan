
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    DateTimeFormatter formatter =
        DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    request.setAttribute("formatter", formatter);
%>

<style>
    /* Tổng thể */
    .lien-he-page {
        padding: 26px;
        color: #f5f5f7;
        background: #0b0b0f;
        border-radius: 12px;
        min-height: 100%;
    }

    .lien-he-page * {
        box-sizing: border-box;
    }

    /* Tiêu đề */
    .lien-he-page .page-heading {
        color: #ffffff;
        font-size: 26px;
        font-weight: 700;
        margin: 0;
    }

    .lien-he-page .page-heading i {
        color: #ff304f;
    }

    .lien-he-page .page-divider {
        border: 0;
        border-top: 1px solid #383838;
        margin: 22px 0;
    }

    /* Thông báo */
    .lien-he-page .alert {
        margin-bottom: 22px;
        border-radius: 7px;
        font-size: 13px;
    }

    .lien-he-page .alert-success {
        color: #75e6a5;
        background: #193629;
        border-color: #285a40;
    }

    .lien-he-page .alert-danger {
        color: #ff8b96;
        background: #3a2024;
        border-color: #653038;
    }

    .lien-he-page .btn-close {
        filter: invert(1);
    }

    /* Khung tìm kiếm */
    .lien-he-page .search-card {
        padding: 20px;
        margin-bottom: 24px;
        background: #1e1e1e;
        border: 1px solid #383838;
        border-radius: 9px;
    }

    .lien-he-page .form-label {
        color: #eeeeee;
        font-size: 12px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .lien-he-page .form-label i {
        color: #ff304f;
        margin-right: 5px;
    }

    .lien-he-page .input-group-text,
    .lien-he-page .form-control {
        min-height: 43px;
        color: #f5f5f7;
        background: #171717;
        border-color: #414141;
        font-size: 13px;
    }

    .lien-he-page .input-group-text {
        color: #ff6474;
        border-right: 0;
    }

    .lien-he-page .input-group .form-control {
        border-left: 0;
    }

    .lien-he-page .form-control::placeholder {
        color: #85858f;
    }

    .lien-he-page .form-control:focus {
        color: #ffffff;
        background: #171717;
        border-color: #ff304f;
        box-shadow: 0 0 0 2px rgba(255,48,79,.12);
    }

    .lien-he-page .btn-search {
        min-height: 43px;
        padding: 9px 18px;
        color: #ffffff;
        background: #ff304f;
        border: 1px solid #ff304f;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 700;
    }

    .lien-he-page .btn-search:hover {
        background: #b5122b;
        border-color: #b5122b;
    }

    .lien-he-page .btn-reset {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 43px;
        min-height: 43px;
        padding: 9px 12px;
        color: #cccccc;
        background: #242424;
        border: 1px solid #414141;
        border-radius: 6px;
        text-decoration: none;
    }

    .lien-he-page .btn-reset:hover {
        color: #ffffff;
        background: #352326;
        border-color: #ff304f;
    }

    /* Bảng */
    .lien-he-page .table-card {
        background: #1e1e1e;
        border: 1px solid #383838;
        border-radius: 9px;
        overflow: hidden;
    }

    .lien-he-page .table-header {
        padding: 18px 22px;
        border-bottom: 1px solid #383838;
    }

    .lien-he-page .table-title {
        margin: 0;
        color: #ffffff;
        font-size: 16px;
        font-weight: 700;
    }

    .lien-he-page .table-title i {
        color: #ff304f;
        margin-right: 8px;
    }

    .lien-he-page .table-responsive {
        width: 100%;
        overflow-x: auto;
    }

    .lien-he-page .lien-he-table {
        width: 100%;
        min-width: 950px;
        margin-bottom: 0;
        color: #eeeeee;
        font-size: 13px;

        --bs-table-bg: transparent;
        --bs-table-color: #eeeeee;
        --bs-table-border-color: #343434;
        --bs-table-hover-bg: #292326;
        --bs-table-hover-color: #ffffff;
    }

    .lien-he-page .lien-he-table thead th {
        padding: 15px 12px;
        color: #ff6474 !important;
        background: #2b2022 !important;
        border-color: #443033 !important;
        font-size: 11px;
        font-weight: 700;
        white-space: nowrap;
    }

    .lien-he-page .lien-he-table tbody td {
        padding: 14px 12px;
        color: #eeeeee;
        background: transparent;
        border-color: #343434;
        vertical-align: middle;
    }

    .lien-he-page .lien-he-table tbody tr:hover > * {
        background: #292326;
        color: #ffffff;
    }

    .lien-he-page .contact-code {
        color: #ff6474;
        font-weight: 700;
    }

    .lien-he-page .contact-name {
        color: #ffffff;
        font-weight: 600;
    }

    .lien-he-page .contact-content {
        min-width: 180px;
        max-width: 250px;
        white-space: normal;
        overflow-wrap: anywhere;
        line-height: 1.5;
    }

    .lien-he-page .contact-date {
        white-space: nowrap;
    }

    /* Nút xóa */
    .lien-he-page .btn-delete {
        padding: 7px 10px;
        color: #ff647a;
        background: #321d21;
        border: 1px solid #653038;
        border-radius: 6px;
        font-size: 11px;
        font-weight: 700;
        text-decoration: none;
        white-space: nowrap;
    }

    .lien-he-page .btn-delete:hover {
        color: #ffffff;
        background: #dc3545;
        border-color: #dc3545;
    }

    /* Không có dữ liệu */
    .lien-he-page .empty-row {
        padding: 35px 15px !important;
        color: #a1a1ae !important;
        text-align: center;
    }

    /* Màn hình nhỏ */
    @media (max-width: 768px) {
        .lien-he-page {
            padding: 16px;
        }

        .lien-he-page .page-heading {
            font-size: 21px;
        }

        .lien-he-page .search-card {
            padding: 15px;
        }

        .lien-he-page .table-header {
            padding: 15px;
        }
    }
</style>

<div class="lien-he-page">
    <div class="container-fluid p-0">

        <!-- Tiêu đề -->
        <div class="d-flex justify-content-between align-items-center
                    flex-wrap gap-3 mb-3">

            <h3 class="page-heading">
                <i class="fas fa-envelope me-2"></i>
                Quản Lý Liên Hệ
            </h3>
        </div>

        <hr class="page-divider">

        <!-- Thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <c:set var="isError"
                   value="${sessionScope.message.contains('thất bại') || sessionScope.message.contains('Xóa thất bại')}" />

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

        <!-- Tìm kiếm -->
        <form action="${pageContext.request.contextPath}/admin/lien-he"
              method="GET"
              class="search-card">

            <div class="row align-items-end g-3">

                <div class="col-lg-8 col-md-8">
                    <label class="form-label">
                        <i class="fas fa-search"></i>
                        Tìm kiếm liên hệ
                    </label>

                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-search"></i>
                        </span>

                        <input type="text"
                               class="form-control"
                               name="keyword"
                               value="${param.keyword}"
                               placeholder="Nhập tên hoặc email người gửi...">
                    </div>
                </div>

                <div class="col-lg-4 col-md-4">
                    <label class="form-label d-none d-md-block">
                        Thao tác
                    </label>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn-search">
                            <i class="fas fa-filter me-1"></i>
                            Tìm kiếm
                        </button>

                        <a href="${pageContext.request.contextPath}/admin/lien-he"
                           class="btn-reset"
                           title="Làm mới">
                            <i class="fas fa-sync-alt"></i>
                        </a>
                    </div>
                </div>

            </div>
        </form>

        <!-- Danh sách liên hệ -->
        <div class="table-card">

            <div class="table-header">
                <h5 class="table-title">
                    <i class="fas fa-list-ul"></i>
                    Danh sách liên hệ
                </h5>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle lien-he-table">

                    <thead>
                        <tr>
                            <th>MÃ LH</th>
                            <th>HỌ TÊN</th>
                            <th>EMAIL</th>
                            <th>SỐ ĐIỆN THOẠI</th>
                            <th>NỘI DUNG</th>
                            <th>NGÀY GỬI</th>
                            <th class="text-center">HÀNH ĐỘNG</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${not empty listLienHe}">

                                <c:forEach var="lh" items="${listLienHe}">
                                    <tr>
                                        <td>
                                            <span class="contact-code">
                                                ${lh.maLH}
                                            </span>
                                        </td>

                                        <td>
                                            <span class="contact-name">
                                                ${lh.hoTen}
                                            </span>
                                        </td>

                                        <td>${lh.email}</td>

                                        <td>${lh.sdt}</td>

                                        <td>
                                            <div class="contact-content"
                                                 title="${lh.noiDung}">
                                                ${lh.noiDung}
                                            </div>
                                        </td>

                                        <td class="contact-date">
                                            <c:if test="${lh.ngayGui != null}">
                                                ${lh.ngayGui.format(formatter)}
                                            </c:if>
                                        </td>

                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/admin/xoa-lien-he?id=${lh.maLH}"
                                               class="btn-delete"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa tin nhắn của khách hàng ${lh.hoTen}?');">
                                                <i class="fas fa-trash-alt me-1"></i>
                                                Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="empty-row">
                                        <i class="fas fa-envelope-open me-2"></i>
                                        Không có tin nhắn liên hệ nào trong hệ thống.
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
