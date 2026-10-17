<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .add-account-page {
        color: #f1f1f1;
    }

    .add-account-page .account-card {
        background-color: #1c1c1c;
        border: 1px solid #333 !important;
        border-radius: 12px;
        overflow: hidden;
    }

    .add-account-page .account-header {
        border-bottom: 1px solid #383838 !important;
    }

    .add-account-page .account-title {
        color: #f5f5f5;
        font-size: 1.4rem;
    }

    .add-account-page .account-description {
        color: #aaa;
    }

    .add-account-page .form-label {
        color: #ddd;
        font-size: 0.85rem;
        letter-spacing: 0.3px;
        margin-bottom: 8px;
    }

    .add-account-page .form-control,
    .add-account-page .form-select {
        background-color: #292929;
        color: #f5f5f5;
        border: 1px solid #444;
        border-radius: 7px;
        padding: 10px 12px;
    }

    .add-account-page .form-control:focus,
    .add-account-page .form-select:focus {
        background-color: #292929;
        color: #fff;
        border-color: #dc3545;
        box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.2);
    }

    .add-account-page .form-control::placeholder {
        color: #888;
    }

    .add-account-page .form-select option {
        background-color: #292929;
        color: #fff;
    }

    .add-account-page .account-footer {
        border-top: 1px solid #383838 !important;
    }

    .add-account-page .btn-save {
        background-color: #dc3545;
        color: #fff;
        border: 1px solid #dc3545;
        border-radius: 7px;
        transition: all 0.2s ease;
    }

    .add-account-page .btn-save:hover {
        background-color: #bb2d3b;
        border-color: #bb2d3b;
        color: #fff;
        transform: translateY(-1px);
    }

    .add-account-page .btn-back,
    .add-account-page .btn-cancel {
        background-color: #333;
        color: #eee;
        border: 1px solid #4a4a4a;
        border-radius: 7px;
    }

    .add-account-page .btn-back:hover,
    .add-account-page .btn-cancel:hover {
        background-color: #444;
        color: #fff;
    }

    @media (max-width: 576px) {
        .add-account-page .account-header {
            align-items: flex-start !important;
            gap: 12px;
        }

        .add-account-page .account-title {
            font-size: 1.1rem;
        }
    }
</style>

<div class="add-account-page">
    <div class="card account-card shadow-sm mb-4">
        <div class="card-body p-4">

            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 account-header">
                <div>
                    <h3 class="account-title fw-bold mb-1">
                        <i class="fas fa-user-plus text-danger me-2"></i>
                        Thêm Tài Khoản Mới
                    </h3>

                    <p class="account-description small mb-0">
                        Nhập thông tin để tạo tài khoản hệ thống mới
                    </p>
                </div>

                <a href="${pageContext.request.contextPath}/admin/accounts"
                   class="btn btn-back px-3">
                    <i class="fas fa-arrow-left me-1"></i>
                    Quay lại
                </a>
            </div>

            <!-- Form gửi dữ liệu về Servlet -->
            <form action="${pageContext.request.contextPath}/admin/add-account"
                  method="POST">

                <div class="mb-3">
                    <label for="username" class="form-label fw-bold">
                        TÊN ĐĂNG NHẬP (USERNAME)
                    </label>

                    <input type="text"
                           id="username"
                           name="username"
                           class="form-control"
                           maxlength="50"
                           autocomplete="username"
                           required
                           placeholder="Nhập tên đăng nhập...">
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label fw-bold">
                        MẬT KHẨU (PASSWORD)
                    </label>

                    <input type="password"
                           id="password"
                           name="password"
                           class="form-control"
                           minlength="8"
                           autocomplete="new-password"
                           required
                           placeholder="Nhập mật khẩu...">

                    <small class="account-description d-block mt-2">
                        Nên sử dụng mật khẩu đủ dài, kết hợp chữ và số.
                    </small>
                </div>

                <div class="mb-3">
                    <label for="role" class="form-label fw-bold">
                        QUYỀN HẠN (ROLE)
                    </label>

                    <select id="role" name="role" class="form-select" required>
                        <option value="0">Khách Hàng</option>
                        <option value="1">Admin</option>
                    </select>
                </div>

                <div class="mt-4 pt-3 account-footer">
                    <button type="submit" class="btn btn-save px-4 py-2 fw-bold">
                        <i class="fas fa-save me-2"></i>
                        Lưu tài khoản
                    </button>

                    <a href="${pageContext.request.contextPath}/admin/accounts"
                       class="btn btn-cancel px-3 py-2 ms-2">
                        Hủy
                    </a>
                </div>

            </form>
        </div>
    </div>
</div>