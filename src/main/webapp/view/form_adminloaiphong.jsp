<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .room-type-form-page {
        color: #f1f1f1;
    }

    .room-type-form-page .room-type-card {
        background-color: #1c1c1c;
        border: 1px solid #333 !important;
        border-radius: 12px;
        overflow: hidden;
    }

    .room-type-form-page .room-type-header {
        border-bottom: 1px solid #383838 !important;
    }

    .room-type-form-page .room-type-title {
        color: #f5f5f5;
        font-size: 1.45rem;
    }

    .room-type-form-page .form-label {
        color: #e5e5e5;
        margin-bottom: 8px;
    }

    .room-type-form-page .form-control {
        background-color: #292929;
        color: #f5f5f5;
        border: 1px solid #444;
        border-radius: 7px;
        padding: 10px 12px;
    }

    .room-type-form-page .form-control:focus {
        background-color: #292929;
        color: #fff;
        border-color: #dc3545;
        box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.2);
    }

    .room-type-form-page .form-control::placeholder {
        color: #888;
    }

    .room-type-form-page .form-control[readonly] {
        background-color: #222;
        color: #aaa;
        cursor: not-allowed;
    }

    .room-type-form-page .form-text {
        color: #999 !important;
        font-size: 0.85rem;
        margin-top: 7px;
    }

    .room-type-form-page .room-type-footer {
        border-top: 1px solid #383838 !important;
    }

    .room-type-form-page .btn-save {
        background-color: #dc3545;
        border: 1px solid #dc3545;
        color: #fff;
        border-radius: 7px;
        transition: all 0.2s ease;
    }

    .room-type-form-page .btn-save:hover {
        background-color: #bb2d3b;
        border-color: #bb2d3b;
        color: #fff;
        transform: translateY(-1px);
    }

    .room-type-form-page .btn-back {
        background-color: #333;
        color: #eee;
        border: 1px solid #4a4a4a;
        border-radius: 7px;
    }

    .room-type-form-page .btn-back:hover {
        background-color: #444;
        color: #fff;
    }

    @media (max-width: 576px) {
        .room-type-form-page .room-type-title {
            font-size: 1.1rem;
        }

        .room-type-form-page .room-type-header {
            gap: 12px;
            align-items: flex-start !important;
        }
    }
</style>

<div class="room-type-form-page">
    <div class="card room-type-card shadow-sm mb-4">
        <div class="card-body p-4">

            <div class="d-flex justify-content-between align-items-center mb-4 pb-3 room-type-header">
                <h3 class="room-type-title fw-bold mb-0">
                    <i class="fas ${loaiPhong != null ? 'fa-edit text-warning' : 'fa-plus-circle text-danger'} me-2"></i>
                    ${loaiPhong != null ? "Cập Nhật Loại Phòng" : "Thêm Loại Phòng Mới"}
                </h3>

                <a href="${pageContext.request.contextPath}/admin/adminloaiphong?action=list"
                   class="btn btn-back btn-sm px-3 fw-bold">
                    <i class="fas fa-arrow-left me-1"></i>
                    Quay lại danh sách
                </a>
            </div>

            <form action="${pageContext.request.contextPath}/admin/adminloaiphong"
                  method="POST">

                <input type="hidden" name="action"
                       value="${loaiPhong != null ? 'update' : 'add'}">

                <div class="mb-3">
                    <label for="maLoai" class="form-label fw-bold">
                        Mã Loại Phòng:
                    </label>

                    <input type="text"
                           class="form-control"
                           id="maLoai"
                           name="maLoai"
                           value="${loaiPhong != null ? loaiPhong.maLoai : nextMaLoai}"
                           readonly>

                    <div class="form-text">
                        Mã loại phòng được hệ thống tự động sinh và không thể thay đổi.
                    </div>
                </div>

                <div class="mb-3">
                    <label for="tenLoai" class="form-label fw-bold">
                        Tên Loại Phòng:
                    </label>

                    <input type="text"
                           class="form-control"
                           id="tenLoai"
                           name="tenLoai"
                           value="${loaiPhong.tenLoai}"
                           maxlength="100"
                           required
                           placeholder="Ví dụ: Phòng Gia Đình">
                </div>

                <div class="mb-3">
                    <label for="moTa" class="form-label fw-bold">
                        Mô Tả:
                    </label>

                    <textarea class="form-control"
                              id="moTa"
                              name="moTa"
                              rows="3"
                              placeholder="Nhập mô tả tiện ích hoặc đặc điểm loại phòng...">${loaiPhong.moTa}</textarea>
                </div>

                <div class="text-end pt-3 mt-4 room-type-footer">
                    <button type="submit"
                            class="btn btn-save px-4 py-2 fw-bold shadow-sm">
                        <i class="fas fa-save me-2"></i>
                        ${loaiPhong != null ? 'Lưu Thay Đổi' : 'Thêm Mới'}
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>