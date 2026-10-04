<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <!-- Tiêu đề và nút chuyển sang trang thêm mới -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <div>
                <h3 class="text-dark fw-bold mb-1"><i class="fas fa-users text-primary me-2"></i> Quản Lý Tài Khoản Hệ Thống</h3>
                <p class="text-muted small mb-0">Quản lý thông tin tài khoản đăng nhập và phân quyền người dùng</p>
            </div>
            <!-- Chuyển thành thẻ a dẫn tới action GET /admin/add-account -->
            <a href="${pageContext.request.contextPath}/admin/add-account" class="btn btn-dark px-4 py-2 fw-bold shadow-sm text-decoration-none">
                <i class="fas fa-user-plus me-2"></i> Thêm Tài Khoản
            </a>
        </div>

        <!-- Bảng danh sách tài khoản -->
        <div class="table-responsive">
            <table class="table table-hover align-middle custom-admin-table">
                <thead class="table-dark text-uppercase">
                    <tr>
                        <th class="py-3 ps-3">Tên Đăng Nhập (Username)</th>
                        <th class="py-3">Mật Khẩu (Password)</th>
                        <th class="py-3">Quyền (Role)</th>
                        <th class="py-3 text-center">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="acc" items="${listAcc}">
                        <tr>
                            <td class="ps-3"><span class="fw-bold text-dark">${acc.username}</span></td>
                            <td><span class="text-muted">${acc.password}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${acc.role == 1}">
                                        <span class="badge bg-danger text-white px-3 py-2 fw-semibold">Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success text-white px-3 py-2 fw-semibold">Khách Hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <!-- Đã thêm tiền tố /admin/ vào đường dẫn xóa -->
                                <a href="${pageContext.request.contextPath}/admin/delete-account?username=${acc.username}" 
                                   class="btn btn-sm btn-outline-danger px-3 fw-bold" 
                                   onclick="return confirm('Bạn có chắc muốn xóa tài khoản ${acc.username} này không?');">
                                    <i class="fas fa-trash-alt me-1"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>