<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .room-form-page {
        color: #f1f1f1;
    }

    .room-form-page .room-form-card {
        background-color: #1c1c1c;
        border: 1px solid #333 !important;
        border-radius: 12px;
        overflow: hidden;
    }

    .room-form-page .room-form-header {
        border-bottom: 1px solid #383838 !important;
    }

    .room-form-page .room-form-title {
        color: #f5f5f5;
        font-size: 1.4rem;
    }

    .room-form-page .form-label {
        color: #e5e5e5;
        margin-bottom: 8px;
    }

    .room-form-page .form-control,
    .room-form-page .form-select {
        background-color: #292929;
        color: #f5f5f5;
        border: 1px solid #444;
        border-radius: 7px;
        padding: 10px 12px;
    }

    .room-form-page .form-control:focus,
    .room-form-page .form-select:focus {
        background-color: #292929;
        color: #fff;
        border-color: #dc3545;
        box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.2);
    }

    .room-form-page .form-control::placeholder {
        color: #888;
    }

    .room-form-page .form-control[readonly] {
        background-color: #222;
        color: #aaa;
        cursor: not-allowed;
    }

    .room-form-page .form-select option {
        background-color: #292929;
        color: #fff;
    }

    .room-form-page input[type="file"] {
        padding: 7px;
    }

    .room-form-page input[type="file"]::file-selector-button {
        background-color: #3a3a3a;
        color: #f5f5f5;
        border: 1px solid #555;
        border-radius: 5px;
        padding: 5px 10px;
        margin-right: 12px;
        cursor: pointer;
    }

    .room-form-page input[type="file"]::file-selector-button:hover {
        background-color: #4a4a4a;
    }

    .room-form-page .form-text {
        color: #999 !important;
    }

    .room-form-page .room-form-footer {
        border-top: 1px solid #383838 !important;
    }

    .room-form-page .btn-save {
        background-color: #dc3545;
        border: 1px solid #dc3545;
        color: #fff;
        border-radius: 7px;
        transition: all 0.2s ease;
    }

    .room-form-page .btn-save:hover {
        background-color: #bb2d3b;
        border-color: #bb2d3b;
        color: #fff;
        transform: translateY(-1px);
    }

    .room-form-page .btn-back {
        background-color: #333;
        color: #eee;
        border: 1px solid #4a4a4a;
        border-radius: 7px;
    }

    .room-form-page .btn-back:hover {
        background-color: #444;
        color: #fff;
    }

    .room-form-page .file-error {
        color: #ff6b78;
        font-size: 0.85rem;
    }

    .room-form-page .current-image {
        color: #aaa;
        font-size: 0.85rem;
    }

    .room-form-page .current-image strong {
        color: #f5f5f5;
        overflow-wrap: anywhere;
    }

    @media (max-width: 576px) {
        .room-form-page .room-form-header {
            align-items: flex-start !important;
            gap: 12px;
        }

        .room-form-page .room-form-title {
            font-size: 1.1rem;
        }
    }
</style>

<div class="room-form-page">
    <div class="card room-form-card shadow-sm mb-4">
        <div class="card-body p-4">

            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 room-form-header">
                <h3 class="room-form-title fw-bold mb-0">
                    <i class="fas ${phong != null ? 'fa-edit text-warning' : 'fa-plus-circle text-danger'} me-2"></i>
                    ${phong != null ? "Cập Nhật Thông Tin Phòng" : "Thêm Phòng Mới"}
                </h3>

                <a href="${pageContext.request.contextPath}/admin/room?action=list"
                   class="btn btn-back btn-sm px-3 fw-bold">
                    <i class="fas fa-arrow-left me-1"></i>
                    Quay lại danh sách
                </a>
            </div>

            <form action="${pageContext.request.contextPath}/admin/room"
                  method="POST"
                  enctype="multipart/form-data">

                <input type="hidden" name="action"
                       value="${phong != null ? 'update' : 'add'}">

                <!-- Mã phòng -->
                <div class="mb-3">
                    <label for="maPhong" class="form-label fw-bold">
                        Mã Phòng:
                    </label>

                    <input type="text"
                           class="form-control"
                           id="maPhong"
                           name="maPhong"
                           value="${phong != null ? phong.maPhong : nextMaPhong}"
                           readonly>

                    <div class="form-text mt-2">
                        Mã phòng được hệ thống tự động sinh và không thể thay đổi.
                    </div>
                </div>

                <!-- Tên phòng -->
                <div class="mb-3">
                    <label for="tenPhong" class="form-label fw-bold">
                        Tên Phòng:
                    </label>

                    <input type="text"
                           class="form-control"
                           id="tenPhong"
                           name="tenPhong"
                           value="${phong.tenPhong}"
                           maxlength="100"
                           required
                           placeholder="Ví dụ: Phòng VIP 101">
                </div>

                <!-- Loại phòng -->
                <div class="mb-3">
                    <label for="maLoai" class="form-label fw-bold">
                        Loại Phòng:
                    </label>

                    <select class="form-select"
                            id="maLoai"
                            name="maLoai"
                            required>

                        <option value="">-- Chọn loại phòng --</option>

                        <c:forEach items="${listLoaiPhong}" var="lp">
                            <option value="${lp.maLoai}"
                                ${phong.maLoai == lp.maLoai ? 'selected' : ''}>
                                ${lp.maLoai} - ${lp.tenLoai}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Giá phòng -->
                <div class="mb-3">
                    <label for="gia" class="form-label fw-bold">
                        Giá Phòng (VNĐ):
                    </label>

                    <input type="number"
                           class="form-control"
                           id="gia"
                           name="gia"
                           value="${phong.gia}"
                           min="0"
                           step="1000"
                           required
                           placeholder="Ví dụ: 300000">
                </div>

                <!-- Tình trạng -->
                <div class="mb-3">
                    <label for="tinhTrang" class="form-label fw-bold">
                        Tình Trạng:
                    </label>

                    <select class="form-select"
                            id="tinhTrang"
                            name="tinhTrang"
                            required>

                        <option value="Trống"
                            ${phong.tinhTrang == 'Trống' ? 'selected' : ''}>
                            Trống
                        </option>

                        <option value="Đang thuê"
                            ${phong.tinhTrang == 'Đang thuê' ? 'selected' : ''}>
                            Đang thuê
                        </option>
                    </select>
                </div>

                <!-- Hình ảnh phòng -->
                <div class="mb-3">
                    <label for="imageFile" class="form-label fw-bold">
                        <i class="fas fa-image me-1"></i>
                        Hình Ảnh Phòng:
                    </label>

                    <input type="file"
                           class="form-control"
                           name="imageFile"
                           id="imageFile"
                           accept="image/*"
                           onchange="checkFileSize(this)">

                    <small id="fileError"
                           class="file-error fw-bold mt-2 d-block"></small>

                    <c:if test="${phong != null && not empty phong.hinhAnh}">
                        <small class="current-image mt-2 d-block">
                            <i class="fas fa-image me-1"></i>
                            Ảnh hiện tại:
                            <strong>${phong.hinhAnh}</strong>
                        </small>

                        <input type="hidden"
                               name="oldImage"
                               value="${phong.hinhAnh}">
                    </c:if>

                    <div class="form-text mt-2">
                        Chỉ chọn tệp hình ảnh có dung lượng tối đa 5 MB.
                    </div>
                </div>

                <!-- Nút lưu -->
                <div class="text-end pt-3 mt-4 room-form-footer">
                    <button type="submit"
                            class="btn btn-save px-4 py-2 fw-bold shadow-sm">
                        <i class="fas fa-save me-2"></i>
                        ${phong != null ? 'Lưu Thay Đổi' : 'Thêm Mới'}
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
    function checkFileSize(input) {
        const file = input.files[0];
        const errorSpan = document.getElementById('fileError');
        const maxSize = 5 * 1024 * 1024;

        errorSpan.textContent = "";

        if (!file) {
            return;
        }

        // Kiểm tra dung lượng ảnh
        if (file.size > maxSize) {
            errorSpan.textContent =
                "Ảnh quá lớn (" +
                (file.size / (1024 * 1024)).toFixed(2) +
                " MB). Vui lòng chọn ảnh dưới hoặc bằng 5 MB!";

            input.value = "";
            return;
        }

        // Kiểm tra định dạng ảnh
        if (!file.type.startsWith("image/")) {
            errorSpan.textContent =
                "Vui lòng chọn tệp hình ảnh hợp lệ.";

            input.value = "";
        }
    }
</script>