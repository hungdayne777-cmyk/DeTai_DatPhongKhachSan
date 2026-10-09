<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <!-- Tiêu đề thay đổi linh hoạt dựa vào việc thêm hay sửa -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <h3 class="text-dark fw-bold mb-0">
                <i class="fas ${phong != null ? 'fa-edit text-warning' : 'fa-plus-circle text-primary'} me-2"></i> 
                ${phong != null ? "Cập Nhật Thông Tin Phòng" : "Thêm Phòng Mới"}
            </h3>
            <a href="${pageContext.request.contextPath}/admin/room?action=list" class="btn btn-secondary btn-sm px-3 fw-bold">
                <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>

        <!-- Form gửi dữ liệu về Servlet -->
        <form action="${pageContext.request.contextPath}/admin/room" method="POST" enctype="multipart/form-data">
            <!-- Xác định action gửi đi là add hay update -->
            <input type="hidden" name="action" value="${phong != null ? 'update' : 'add'}">

            <!-- Mã Phòng -->
            <div class="mb-3">
                <label class="form-label fw-bold">Mã Phòng:</label>
                <input type="text" class="form-control bg-light" name="maPhong" 
                       value="${phong != null ? phong.maPhong : nextMaPhong}" 
                       readonly>
                <div class="form-text text-muted">Mã phòng được hệ thống tự động sinh và không thể thay đổi.</div>
            </div>

            <!-- Tên Phòng -->
            <div class="mb-3">
                <label class="form-label fw-bold">Tên Phòng:</label>
                <input type="text" class="form-control" name="tenPhong" value="${phong.tenPhong}" required placeholder="Ví dụ: Phòng VIP 101">
            </div>

            <!-- COMBOBOX: Loại Phòng -->
            <div class="mb-3">
                <label class="form-label fw-bold">Loại Phòng:</label>
                <select class="form-control form-select" name="maLoai" required>
                    <option value="">-- Chọn loại phòng --</option>
                    <c:forEach items="${listLoaiPhong}" var="lp">
                        <option value="${lp.maLoai}" ${phong.maLoai == lp.maLoai ? 'selected' : ''}>
                            ${lp.maLoai} - ${lp.tenLoai}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Giá Phòng -->
            <div class="mb-3">
                <label class="form-label fw-bold">Giá Phòng (VNĐ):</label>
                <input type="number" step="1000" class="form-control" name="gia" value="${phong.gia}" required placeholder="Ví dụ: 300000">
            </div>

            <!-- COMBOBOX: Tình Trạng -->
            <div class="mb-3">
                <label class="form-label fw-bold">Tình Trạng:</label>
                <select class="form-control form-select" name="tinhTrang" required>
                    <option value="Trống" ${phong.tinhTrang == 'Trống' ? 'selected' : ''}>Trống</option>
                    <option value="Đang thuê" ${phong.tinhTrang == 'Đang thuê' ? 'selected' : ''}>Đang thuê</option>
                </select>
            </div>
            <!-- Ô chọn hình ảnh phòng & Cảnh báo dung lượng -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Hình Ảnh Phòng:</label>
                    <input type="file" class="form-control" name="imageFile" id="imageFile" accept="image/*" onchange="checkFileSize(this)">
                    
                    <!-- Thẻ hiển thị dòng chữ cảnh báo lỗi dung lượng ảnh -->
                    <small id="fileError" class="text-danger fw-bold mt-1 d-block"></small>
                    
                    <c:if test="${phong != null && not empty phong.hinhAnh}">
                        <small class="text-muted mt-1 d-block">Ảnh hiện tại: <strong>${phong.hinhAnh}</strong></small>
                        <input type="hidden" name="oldImage" value="${phong.hinhAnh}">
                    </c:if>
                </div>

            <!-- Nút submit -->
            <div class="text-end pt-3 border-top">
                <button type="submit" class="btn btn-primary px-4 py-2 fw-bold shadow-sm">
                    <i class="fas fa-save me-2"></i> ${phong != null ? 'Lưu Thay Đổi' : 'Thêm Mới'}
                </button>
            </div>

        </form>
    </div>
</div>
<script>
    function checkFileSize(input) {
        const file = input.files[0];
        const errorSpan = document.getElementById('fileError');

        // Đặt giới hạn dung lượng (Ví dụ: 5MB = 5 * 1024 * 1024 bytes)
        const maxSize = 5 * 1024 * 1024;

        if (file) {
            if (file.size > maxSize) {
                // Hiện cảnh báo và xóa file vừa chọn khỏi input
                errorSpan.textContent = "⚠️ Ảnh quá lớn (" + (file.size / (1024 * 1024)).toFixed(2) + "MB). Vui lòng chọn ảnh dưới 5MB!";
                input.value = ""; // Reset ô chọn file để bắt người dùng chọn lại
            } else {
                // Xóa thông báo lỗi nếu file hợp lệ
                errorSpan.textContent = "";
            }
        }
    }
</script>