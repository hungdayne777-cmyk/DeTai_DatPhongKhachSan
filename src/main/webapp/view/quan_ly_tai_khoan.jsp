
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .account-page {
        color: #f1f1f1;
    }

    .account-page .account-card {
        background: #1c1c1c;
        border: 1px solid #343434;
        border-radius: 12px;
        padding: 24px;
    }

    .account-page .account-header {
        border-bottom: 1px solid #3a3a3a;
        padding-bottom: 20px;
        margin-bottom: 24px;
    }

    .account-page .account-title {
        color: #ffffff;
        font-weight: 700;
        margin-bottom: 6px;
    }

    .account-page .account-description {
        color: #a8a8a8;
        font-size: 14px;
        margin-bottom: 0;
    }

    .account-page .account-icon {
        color: #dc3545;
        margin-right: 8px;
    }

    .account-page .btn-add-account {
        background: #dc3545;
        color: #ffffff;
        border: 1px solid #dc3545;
        border-radius: 7px;
        padding: 10px 18px;
        font-weight: 600;
        text-decoration: none;
        transition: 0.2s;
        white-space: nowrap;
    }

    .account-page .btn-add-account:hover {
        background: #bb2d3b;
        border-color: #bb2d3b;
        color: #ffffff;
    }

    .account-page .account-table {
        margin-bottom: 0;
        color: #eeeeee;
        border-color: #3a3a3a;
    }

    .account-page .account-table thead th {
        background: #292929;
        color: #ffffff;
        border-color: #444444;
        font-size: 13px;
        font-weight: 700;
        padding: 16px 12px;
        white-space: nowrap;
    }

    .account-page .account-table tbody td {
        background: #202020;
        color: #e5e5e5;
        border-color: #383838;
        padding: 15px 12px;
        vertical-align: middle;
    }

    .account-page .account-table tbody tr:hover td {
        background: #2b2b2b;
    }

    .account-page .username-text {
        color: #ffffff;
        font-weight: 600;
    }

    .account-page .role-badge {
        display: inline-block;
        padding: 7px 13px;
        border-radius: 5px;
        font-size: 12px;
        font-weight: 600;
    }

    .account-page .role-admin {
        background: #dc3545;
        color: #ffffff;
    }

    .account-page .role-customer {
        background: #198754;
        color: #ffffff;
    }

    .account-page .btn-delete-account {
        color: #ff6b75;
        border: 1px solid #dc3545;
        background: transparent;
        border-radius: 5px;
        padding: 6px 12px;
        font-size: 13px;
        font-weight: 600;
        text-decoration: none;
        transition: 0.2s;
        white-space: nowrap;
    }

    .account-page .btn-delete-account:hover {
        background: #dc3545;
        color: #ffffff;
    }

    .account-page .empty-account {
        color: #aaaaaa !important;
        text-align: center;
        padding: 30px !important;
    }

    @media (max-width: 768px) {
        .account-page .account-card {
            padding: 16px;
        }

        .account-page .account-header {
            align-items: flex-start !important;
            flex-direction: column;
            gap: 16px;
        }

        .account-page .btn-add-account {
            width: 100%;
            text-align: center;
        }
    }
</style>

<div class="account-page">
    <div class="account-card shadow-sm mb-4">

        <!-- Tiêu đề và nút thêm tài khoản -->
        <div class="account-header d-flex justify-content-between align-items-center">
            <div>
                <h3 class="account-title">
                    <i class="fas fa-users account-icon"></i>
                    Quản Lý Tài Khoản Hệ Thống
                </h3>
                <p class="account-description">
                    Quản lý thông tin tài khoản đăng nhập và phân quyền người dùng
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/admin/add-account"
               class="btn-add-account">
                <i class="fas fa-user-plus me-2"></i>
                Thêm Tài Khoản
            </a>
        </div>

        <!-- Bảng danh sách tài khoản -->
        <div class="table-responsive">
            <table class="table table-hover align-middle account-table">
                <thead>
                    <tr>
                        <th class="ps-3">Tên Đăng Nhập (Username)</th>
                        <th>Quyền (Role)</th>
                        <th class="text-center">Thao Tác</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${not empty listAcc}">
                            <c:forEach var="acc" items="${listAcc}">
                                <tr>
                                    <td class="ps-3">
                                        <span class="username-text">
                                            <c:out value="${acc.username}"/>
                                        </span>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${acc.role == 1}">
                                                <span class="role-badge role-admin">
                                                    Admin
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="role-badge role-customer">
                                                    Khách Hàng
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/delete-account?username=${acc.username}"
                                           class="btn-delete-account"
                                           onclick="return confirm('Bạn có chắc muốn xóa tài khoản này không?');">
                                            <i class="fas fa-trash-alt me-1"></i>
                                            Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="3" class="empty-account">
                                    <i class="fas fa-inbox me-2"></i>
                                    Chưa có tài khoản nào.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

    </div>
</div>
