<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <h3 class="text-dark fw-bold mb-0">
                <i class="fas fa-list-alt text-primary me-2"></i> Quản Lý Loại Phòng
            </h3>
            <a href="${pageContext.request.contextPath}/admin/loai-phong?action=form-add" class="btn btn-danger px-3 fw-bold">
                <i class="fas fa-plus me-1"></i> Thêm Loại Phòng Mới
            </a>
        </div>

        <!-- ===== HIỂN THỊ THÔNG BÁO THÀNH CÔNG TỪ SESSION ===== -->
       <c:if test="${not empty sessionScope.message}">
        <!-- Kiểm tra nếu nội dung chứa từ khóa lỗi -->
        <c:set var="isError" value="${sessionScope.message.contains('Không thể') || sessionScope.message.contains('thất bại')}" />
        
        <div class="alert ${isError ? 'alert-danger' : 'alert-success'} alert-dismissible fade show shadow-sm mb-4" role="alert">
            <!-- Đổi icon tự động: Tam giác cảnh báo (đỏ) hoặc Dấu tick thành công (xanh) -->
            <i class="fas ${isError ? 'fa-exclamation-triangle' : 'fa-check-circle'} me-2"></i> 
            ${sessionScope.message}
            
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="message" scope="session"/>
    </c:if>
        <!-- ================================================= -->
        
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>MÃ LOẠI</th>
                        <th>TÊN LOẠI PHÒNG</th>
                        <th>MÔ TẢ</th>
                        <th class="text-center">HÀNH ĐỘNG</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${loaiPhongList}" var="lp">
                        <tr>
                            <td class="fw-bold text-primary">${lp.maLoai}</td>
                            <td>${lp.tenLoai}</td>
                            <td>${lp.moTa}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/loai-phong?action=edit&maLoai=${lp.maLoai}" class="btn btn-warning btn-sm px-2 text-white fw-bold">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/loai-phong?action=delete&maLoai=${lp.maLoai}" 
                                   class="btn btn-danger btn-sm px-2 fw-bold"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa loại phòng này không?');">
                                    <i class="fas fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty loaiPhongList}">
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Chưa có loại phòng nào trong hệ thống.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>