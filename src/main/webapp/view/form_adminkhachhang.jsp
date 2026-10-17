
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .customer-form-page {
        color: #eeeeee;
    }

    .customer-form-page .customer-card {
        background: #1c1c1c;
        border: 1px solid #343434;
        border-radius: 12px;
        overflow: hidden;
    }

    .customer-form-page .customer-card-body {
        padding: 28px;
    }

    .customer-form-page .customer-header {
        border-bottom: 1px solid #3a3a3a;
        padding-bottom: 20px;
        margin-bottom: 26px;
        gap: 16px;
    }

    .customer-form-page .customer-title {
        color: #ffffff;
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 6px;
    }

    .customer-form-page .customer-title i {
        color: #dc3545;
        margin-right: 8px;
    }

    .customer-form-page .customer-description {
        color: #a8a8a8;
        font-size: 13px;
        margin-bottom: 0;
    }

    .customer-form-page .form-label {
        color: #eeeeee;
        font-weight: 600;
        margin-bottom: 8px;
    }

    .customer-form-page .form-control {
        background: #262626;
        color: #eeeeee;
        border: 1px solid #454545;
        border-radius: 7px;
        padding: 10px 12px;
    }

    .customer-form-page .form-control:focus {
        background: #292929;
        color: #ffffff;
        border-color: #dc3545;
        box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.18);
    }

    .customer-form-page .form-control[readonly] {
        background: #303030;
        color: #bcbcbc;
        opacity: 1;
        cursor: not-allowed;
    }

    .customer-form-page .form-control::placeholder {
        color: #858585;
    }

    .customer-form-page textarea.form-control {
        min-height: 100px;
        resize: vertical;
    }

    .customer-form-page .form-text {
        color: #a8a8a8 !important;
        font-size: 12px;
        margin-top: 7px;
    }

    .customer-form-page .customer-footer {
        border-top: 1px solid #414141;
        padding-top: 20px;
        margin-top: 28px;
        gap: 12px;
    }

    .customer-form-page .btn-customer-back {
        background: transparent;
        color: #dddddd;
        border: 1px solid #666666;
        border-radius: 7px;
        padding: 10px 18px;
        font-weight: 600;
        text-decoration: none;
        transition: 0.2s;
    }

    .customer-form-page .btn-customer-back:hover {
        background: #3a3a3a;
        color: #ffffff;
    }

    .customer-form-page .btn-customer-save {
        background: #dc3545;
        color: #ffffff;
        border: 1px solid #dc3545;
        border-radius: 7px;
        padding: 10px 22px;
        font-weight: 700;
        transition: 0.2s;
    }

    .customer-form-page .btn-customer-save:hover {
        background: #bb2d3b;
        border-color: #bb2d3b;
        color: #ffffff;
    }

    @media (max-width: 767px) {
        .customer-form-page .customer-card-body {
            padding: 18px;
        }

        .customer-form-page .customer-header {
            align-items: flex-start !important;
            flex-direction: column;
        }

        .customer-form-page .customer-title {
            font-size: 20px;
        }

        .customer-form-page .customer-footer {
            align-items: stretch !important;
            flex-direction: column-reverse;
        }

        .customer-form-page .customer-footer .btn {
            width: 100%;
            text-align: center;
        }
    }
</style>

<div class="customer-form-page">
    <div class="row justify-content-center">
        <div class="col-12 col-xl-9 col-xxl-8">

            <div class="customer-card shadow-sm mb-4">
                <div class="customer-card-body">

                    <!-- TIÊU ĐỀ -->
                    <div class="customer-header d-flex justify-content-between align-items-center">
                        <div>
                            <h3 class="customer-title">
                                <i class="fas ${empty khachHang ? 'fa-user-plus' : 'fa-user-edit'}"></i>
                                ${empty khachHang ? 'Thêm Khách Hàng Mới' : 'Cập Nhật Thông Tin Khách Hàng'}
                            </h3>

                            <p class="customer-description">
                                Quản lý thông tin cá nhân và liên hệ của khách hàng
                            </p>
                        </div>

                        <a href="${pageContext.request.contextPath}/admin/khach-hang?action=list"
                           class="btn-customer-back">
                            <i class="fas fa-arrow-left me-1"></i>
                            Quay Lại
                        </a>
                    </div>

                    <!-- FORM KHÁCH HÀNG -->
                    <form action="${pageContext.request.contextPath}/admin/khach-hang?action=${empty khachHang ? 'add' : 'update'}"
                          method="POST">

                        <!-- MÃ KHÁCH HÀNG -->
                        <div class="mb-4">
                            <label for="maKH" class="form-label">
                                <i class="fas fa-id-card me-1 text-danger"></i>
                                Mã Khách Hàng
                            </label>

                            <input type="text"
                                   class="form-control"
                                   id="maKH"
                                   name="maKH"
                                   value="${empty khachHang ? nextMaKH : khachHang.maKH}"
                                   readonly
                                   required>

                            <div class="form-text">
                                <i class="fas fa-info-circle me-1"></i>
                                Mã khách hàng được hệ thống tự động sinh và không thể thay đổi.
                            </div>
                        </div>

                        <!-- HỌ VÀ TÊN -->
                        <div class="mb-4">
                            <label for="hoTen" class="form-label">
                                <i class="fas fa-user me-1 text-danger"></i>
                                Họ và Tên <span class="text-danger">*</span>
                            </label>

                            <input type="text"
                                   class="form-control"
                                   id="hoTen"
                                   name="hoTen"
                                   value="${khachHang.hoTen}"
                                   placeholder="Nhập họ tên khách hàng..."
                                   maxlength="100"
                                   required>
                        </div>

                        <!-- SỐ ĐIỆN THOẠI -->
                        <div class="mb-4">
                            <label for="sdt" class="form-label">
                                <i class="fas fa-phone me-1 text-danger"></i>
                                Số Điện Thoại <span class="text-danger">*</span>
                            </label>

                            <input type="tel"
                                   class="form-control"
                                   id="sdt"
                                   name="sdt"
                                   value="${khachHang.sdt}"
                                   placeholder="Nhập số điện thoại..."
                                   maxlength="20"
                                   required>
                        </div>

                        <!-- EMAIL -->
                        <div class="mb-4">
                            <label for="email" class="form-label">
                                <i class="fas fa-envelope me-1 text-danger"></i>
                                Email <span class="text-danger">*</span>
                            </label>

                            <input type="email"
                                   class="form-control"
                                   id="email"
                                   name="email"
                                   value="${khachHang.email}"
                                   placeholder="Nhập địa chỉ email..."
                                   maxlength="150"
                                   required>
                        </div>

                        <!-- ĐỊA CHỈ -->
                        <div class="mb-4">
                            <label for="diaChi" class="form-label">
                                <i class="fas fa-map-marker-alt me-1 text-danger"></i>
                                Địa Chỉ
                            </label>

                            <textarea class="form-control"
                                      id="diaChi"
                                      name="diaChi"
                                      rows="3"
                                      placeholder="Nhập địa chỉ khách hàng...">${khachHang.diaChi}</textarea>
                        </div>

                        <!-- NÚT THAO TÁC -->
                        <div class="customer-footer d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/admin/khach-hang?action=list"
                               class="btn-customer-back">
                                <i class="fas fa-times me-1"></i>
                                Hủy bỏ
                            </a>

                            <button type="submit" class="btn-customer-save">
                                <i class="fas fa-save me-1"></i>
                                ${empty khachHang ? 'Lưu Khách Hàng' : 'Cập Nhật'}
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
