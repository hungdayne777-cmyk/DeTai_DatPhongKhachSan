<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <!-- Sửa lại phần tiêu đề hiển thị động theo trạng thái Thêm / Sửa -->
            <h3 class="text-dark fw-bold mb-0">
                <i class="fas ${loaiPhong != null ? 'fa-edit text-warning' : 'fa-plus-circle text-primary'} me-2"></i> 
                ${loaiPhong != null ? "Cập Nhật Loại Phòng" : "Thêm Loại Phòng Mới"}
            </h3>
            <a href="${pageContext.request.contextPath}/admin/adminloaiphong?action=list" class="btn btn-secondary btn-sm px-3 fw-bold">
                <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>

        <form action="${pageContext.request.contextPath}/admin/adminloaiphong" method="POST">
            <!-- Tự động chuyển action thành update nếu đang ở chế độ sửa, ngược lại là add -->
            <input type="hidden" name="action" value="${loaiPhong != null ? 'update' : 'add'}">

            <div class="mb-3">
                <label class="form-label fw-bold">Mã Loại Phòng:</label>
                <!-- Nếu đang Sửa thì lấy mã cũ (${loaiPhong.maLoai}), nếu đang Thêm thì lấy mã tự sinh (${nextMaLoai}) -->
                <input type="text" class="form-control bg-light" name="maLoai" 
                       value="${loaiPhong != null ? loaiPhong.maLoai : nextMaLoai}" 
                       readonly>
                <div class="form-text text-muted">Mã loại phòng được hệ thống tự động sinh và không thể thay đổi.</div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Tên Loại Phòng:</label>
                <input type="text" class="form-control" name="tenLoai" value="${loaiPhong.tenLoai}" required placeholder="Ví dụ: Phòng Gia Đình">
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Mô Tả:</label>
                <textarea class="form-control" name="moTa" rows="3" placeholder="Nhập mô tả tiện ích hoặc đặc điểm loại phòng...">${loaiPhong.moTa}</textarea>
            </div>

            <div class="text-end pt-3 border-top">
                <button type="submit" class="btn btn-primary px-4 py-2 fw-bold shadow-sm">
                    <i class="fas fa-save me-2"></i> ${loaiPhong != null ? 'Lưu Thay Đổi' : 'Thêm Mới'}
                </button>
            </div>
        </form>
    </div>
</div>