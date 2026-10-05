<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <h3 class="text-dark fw-bold mb-0">
                <i class="fas fa-users text-primary me-2"></i> Quản Lý Khách Hàng
            </h3>
            <a href="${pageContext.request.contextPath}/admin/khach-hang?action=form-add" class="btn btn-danger px-3 fw-bold">
                <i class="fas fa-plus me-1"></i> Thêm Khách Hàng Mới
            </a>
        </div>

        <!-- Thông báo Session -->
        <c:if test="${not empty sessionScope.message}">
            <!-- Kiểm tra nếu nội dung thông báo chứa từ khóa lỗi -->
            <c:set var="isError" value="${sessionScope.message.contains('Không thể') || sessionScope.message.contains('thất bại')}" />

            <div class="alert ${isError ? 'alert-danger' : 'alert-success'} alert-dismissible fade show shadow-sm mb-4" role="alert">
                <!-- Đổi icon tự động: Tam giác cảnh báo (đỏ) hoặc Dấu tick thành công (xanh) -->
                <i class="fas ${isError ? 'fa-exclamation-triangle' : 'fa-check-circle'} me-2"></i> 
                ${sessionScope.message}

                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>      <form action="${pageContext.request.contextPath}/admin/khach-hang" method="POST" class="card border-0 shadow-sm p-3 mb-4 bg-white rounded">
            <input type="hidden" name="action" value="list">

            <div class="row align-items-end g-3">
                <!-- Ô Tìm kiếm theo Tên hoặc SĐT -->
                <div class="col-md-9">
                    <label class="form-label fw-bold text-secondary small text-uppercase mb-1">
                        <i class="fas fa-search me-1 text-primary"></i> Tìm kiếm khách hàng (Tên / Số điện thoại)
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fas fa-search text-muted"></i></span>
                        <input type="text" class="form-control border-start-0 ps-0" name="keyword" value="${param.keyword}" placeholder="Nhập tên hoặc số điện thoại khách hàng...">
                    </div>
                </div>

                <!-- Cụm Nút bấm -->
                <div class="col-md-3 d-flex gap-2">
                    <button type="submit" class="btn btn-dark fw-bold py-2 px-4">
                        <i class="fas fa-search me-1"></i> Lọc
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/khach-hang?action=list" class="btn btn-outline-secondary py-2 px-3" title="Làm mới bộ lọc">
                        <i class="fas fa-sync-alt"></i>
                    </a>
                </div>
            </div>
        </form>
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>MÃ KHÁCH HÀNG</th>
                        <th>HỌ VÀ TÊN</th>
                        <th>SỐ ĐIỆN THOẠI</th>
                        <th>EMAIL</th>
                        <th>ĐỊA CHỈ</th>
                        <th class="text-center">HÀNH ĐỘNG</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${khachHangList}" var="kh">
                        <tr>
                            <td class="fw-bold text-primary">${kh.maKH}</td>
                            <td>${kh.hoTen}</td>
                            <td>${kh.sdt}</td>
                            <td>${kh.email}</td>
                            <td>${kh.diaChi}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/khach-hang?action=edit&maKH=${kh.maKH}" class="btn btn-warning btn-sm px-2 text-white fw-bold">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/khach-hang?action=delete&maKH=${kh.maKH}" 
                                   class="btn btn-danger btn-sm px-2 fw-bold"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa khách hàng này không?');">
                                    <i class="fas fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty khachHangList}">
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">Chưa có thông tin khách hàng nào trong hệ thống.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
                        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center custom-pagination">
                    <!-- Nút Previous -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/khach-hang?action=list&page=${currentPage - 1}&keyword=${keyword != null ? keyword : ''}">
                            <i class="fas fa-angle-left"></i> Trước
                        </a>
                    </li>

                    <!-- Các nút số trang -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/khach-hang?action=list&page=${i}&keyword=${keyword != null ? keyword : ''}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- Nút Next -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/khach-hang?action=list&page=${currentPage + 1}&keyword=${keyword != null ? keyword : ''}">
                            Sau <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</div>
                        <style>
    .custom-pagination .page-item .page-link {
        color: #212529;
        border-color: #dee2e6;
        font-weight: 600;
        transition: all 0.2s ease-in-out;
    }
    .custom-pagination .page-item .page-link:hover {
        color: #dc3545;
        background-color: #fff5f5;
        border-color: #dc3545;
    }
    .custom-pagination .page-item.active .page-link {
        background-color: #dc3545 !important;
        border-color: #dc3545 !important;
        color: #ffffff !important;
        box-shadow: 0 2px 4px rgba(220, 53, 69, 0.3);
    }
    .custom-pagination .page-item.disabled .page-link {
        color: #adb5bd;
        background-color: #f8f9fa;
        border-color: #dee2e6;
    }
</style>