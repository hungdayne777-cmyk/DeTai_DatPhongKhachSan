<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <div>
                <h3 class="text-dark fw-bold mb-1"><i class="fas fa-user-plus text-dark me-2"></i> Thêm Tài Khoản Mới</h3>
                <p class="text-muted small mb-0">Nhập thông tin để tạo tài khoản hệ thống mới</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-outline-secondary px-3">
                <i class="fas fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>

        <!-- Form gửi dữ liệu phương thức POST về Servlet -->
        <form action="${pageContext.request.contextPath}/admin/add-account" method="POST">
            <div class="mb-3">
                <label class="form-label fw-bold small text-uppercase text-secondary">Tên đăng nhập (Username):</label>
                <input type="text" name="username" class="form-control" required placeholder="Nhập tên đăng nhập...">
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold small text-uppercase text-secondary">Mật khẩu (Password):</label>
                <input type="password" name="password" class="form-control" required placeholder="Nhập mật khẩu...">
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold small text-uppercase text-secondary">Quyền hạn (Role):</label>
                <select name="role" class="form-select">
                    <option value="0">Khách Hàng</option>
                    <option value="1">Admin</option>
                </select>
            </div>

            <div class="mt-4 pt-2 border-top">
                <button type="submit" class="btn btn-danger px-4 fw-bold">
                    <i class="fas fa-save me-2"></i> Lưu tài khoản
                </button>
                <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-secondary px-3 ms-2">Hủy</a>
            </div>
        </form>
    </div>
</div>