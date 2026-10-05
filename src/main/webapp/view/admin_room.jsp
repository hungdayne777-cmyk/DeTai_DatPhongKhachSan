<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <!-- Tiêu đề và nút thêm mới -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <div>
                <h3 class="text-dark fw-bold mb-1"><i class="fas fa-door-open text-primary me-2"></i> Quản Lý Danh Sách Phòng</h3>
                <p class="text-muted small mb-0">Quản lý thông tin chi tiết, giá cả và tình trạng phòng khách sạn</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/room?action=form-add" class="btn btn-danger px-4 py-2 fw-bold shadow-sm">
                <i class="fas fa-plus me-2"></i> Thêm Phòng Mới
            </a>
        </div>
        <!-- Hiển thị thông báo thành công từ Session trong trang Quản trị -->

        <c:if test="${not empty sessionScope.message}">

            <c:set var="isError" value="${sessionScope.message.contains('Không thể') || sessionScope.message.contains('thất bại')}" />

            <div class="alert ${isError ? 'alert-danger' : 'alert-success'} alert-dismissible fade show shadow-sm mb-4" role="alert">

                <i class="fa ${isError ? 'fa-exclamation-triangle' : 'fa-check-circle'}" style="margin-right: 5px;"></i> 
                ${sessionScope.message}

                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <form action="${pageContext.request.contextPath}/admin/room" method="POST" class="card border-0 shadow-sm p-3 mb-4 bg-white rounded">
            <!-- Thêm action=list để servlet biết đường điều hướng đúng -->
            <input type="hidden" name="action" value="list">

            <div class="row align-items-end g-3">
                <!-- Ô Tìm kiếm tên phòng -->
                <div class="col-md-5">
                    <label class="form-label fw-bold text-secondary small text-uppercase mb-1">
                        <i class="fas fa-search me-1 text-primary"></i> Tìm kiếm tên phòng
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fas fa-search text-muted"></i></span>
                        <input type="text" class="form-control border-start-0 ps-0" name="keyword" value="${param.keyword}" placeholder="Nhập tên phòng cần tìm...">
                    </div>
                </div>

                <!-- Ô Lọc Tình Trạng -->
                <div class="col-md-4">
                    <label class="form-label fw-bold text-secondary small text-uppercase mb-1">
                        <i class="fas fa-filter me-1 text-success"></i> Tình Trạng
                    </label>
                    <select class="form-select" name="status">
                        <option value="">-- Tất cả tình trạng --</option>
                        <option value="Trống" ${param.status == 'Trống' ? 'selected' : ''}>Trống</option>
                        <option value="Đang thuê" ${param.status == 'Đang thuê' ? 'selected' : ''}>Đang thuê</option>
                    </select>
                </div>

                <!-- Cụm Nút bấm thao tác -->
                <div class="col-md-3 d-flex gap-2">
                    <button type="submit" class="btn btn-dark fw-bold py-2">
                        <i class="fas fa-search me-1"></i> Lọc
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/room?action=list" class="btn btn-outline-secondary py-2 px-3" title="Làm mới bộ lọc">
                        <i class="fas fa-sync-alt"></i>
                    </a>
                </div>
            </div>
        </form>
        <!-- Bảng hiển thị dữ liệu -->
        <div class="table-responsive">
            <table class="table table-hover align-middle custom-admin-table">
                <thead class="table-dark text-uppercase">
                    <tr>
                        <th class="py-3 ps-3">Mã Phòng</th>
                        <th class="py-3">Tên Phòng</th>
                        <th class="py-3">Mã Loại</th>
                        <th class="py-3">Giá (VNĐ)</th>
                        <th class="py-3">Tình Trạng</th>
                        <th class="py-3 text-center">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dùng JSTL hiển thị dữ liệu từ Servlet -->
                    <c:forEach items="${roomList}" var="r">
                        <tr>
                            <td class="ps-3"><span class="fw-bold text-dark">${r.maPhong}</span></td>
                            <td><span class="fw-bold text-secondary-emphasis">${r.tenPhong}</span></td>
                            <td><span class="badge bg-light text-dark border px-2 py-1 fw-semibold">${r.maLoai}</span></td>
                            <td>
                                <span class="text-danger fw-bold fs-6">
                                    <fmt:formatNumber value="${r.gia}" pattern="#,##0" /> VNĐ
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.tinhTrang == 'Trống'}">
                                        <span style="background-color: #28a745; color: #ffffff !important; padding: 6px 12px; border-radius: 4px; font-weight: bold; display: inline-block;">Trống</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="background-color: #dc3545; color: #ffffff !important; padding: 6px 12px; border-radius: 4px; font-weight: bold; display: inline-block;">${r.tinhTrang}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <!-- Nút Sửa -->
                                <a href="${pageContext.request.contextPath}/admin/room?action=edit&maPhong=${r.maPhong}" 
                                   class="btn btn-sm btn-outline-warning px-3 fw-bold me-1">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <!-- Nút Xóa (Đã sửa đúng đường dẫn action=delete trỏ về AdminPhongServlet) -->
                                <a href="${pageContext.request.contextPath}/admin/room?action=delete&maPhong=${r.maPhong}" 
                                   class="btn btn-sm btn-outline-danger px-3 fw-bold" 
                                   onclick="return confirm('Bạn có chắc muốn xóa phòng ${r.maPhong} này không?');">
                                    <i class="fas fa-trash-alt"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center custom-pagination">
                    <!-- Nút Previous -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/room?action=list&page=${currentPage - 1}&keyword=${keyword != null ? keyword : ''}&status=${status != null ? status : ''}">
                            <i class="fas fa-angle-left"></i> Trước
                        </a>
                    </li>

                    <!-- Các nút số trang -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/room?action=list&page=${i}&keyword=${keyword != null ? keyword : ''}&status=${status != null ? status : ''}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- Nút Next -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/room?action=list&page=${currentPage + 1}&keyword=${keyword != null ? keyword : ''}&status=${status != null ? status : ''}">
                            Sau <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    
</div>
</div>

<!-- CSS tinh chỉnh riêng cho bảng rõ nét hơn -->
<style>
    .custom-pagination .page-item .page-link {
        color: #212529; /* Màu chữ đen cơ bản */
        border-color: #dee2e6;
        font-weight: 600;
        transition: all 0.2s ease-in-out;
    }

    /* Hiệu ứng khi rê chuột (Hover) vào các nút số trang */
    .custom-pagination .page-item .page-link:hover {
        color: #dc3545; /* Chữ chuyển sang màu đỏ */
        background-color: #fff5f5; /* Nền đỏ nhạt hiện đại */
        border-color: #dc3545;
    }

    /* Trang đang được chọn (Active) -> Nền đỏ, chữ trắng */
    .custom-pagination .page-item.active .page-link {
        background-color: #dc3545 !important; /* Màu đỏ chủ đạo */
        border-color: #dc3545 !important;
        color: #ffffff !important; /* Chữ trắng nổi bật */
        box-shadow: 0 2px 4px rgba(220, 53, 69, 0.3);
    }

    /* Trạng thái bị khóa (Disabled) như nút Trước/Sau ở đầu hoặc cuối */
    .custom-pagination .page-item.disabled .page-link {
        color: #adb5bd;
        background-color: #f8f9fa;
        border-color: #dee2e6;
    }
    .custom-admin-table th {
        font-size: 0.85rem;
        letter-spacing: 0.5px;
        background-color: #212529 !important;
        color: #fff !important;
    }
    .custom-admin-table td {
        font-size: 0.95rem;
        padding-top: 1rem;
        padding-bottom: 1rem;
        vertical-align: middle;
    }
    .custom-admin-table tbody tr:hover {
        background-color: #f8f9fa;
    }
</style>