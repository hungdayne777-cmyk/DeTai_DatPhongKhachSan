<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <h3 class="text-dark fw-bold mb-0">
                <i class="fas fa-user-edit text-primary me-2"></i> 
                ${empty khachHang ? 'Thêm Khách Hàng Mới' : 'Cập Nhật Thông Tin Khách Hàng'}
            </h3>
            <a href="${pageContext.request.contextPath}/admin/khach-hang?action=list" class="btn btn-secondary px-3 fw-bold">
                <i class="fas fa-arrow-left me-1"></i> Quay Lại
            </a>
        </div>

        <form action="${pageContext.request.contextPath}/admin/khach-hang?action=${empty khachHang ? 'add' : 'update'}" method="POST">

            <div class="mb-3">
                <label for="maKH" class="form-label fw-bold">Mã Khách Hàng</label>
                <input type="text" class="form-control bg-light" id="maKH" name="maKH" 
                       value="${empty khachHang ? nextMaKH : khachHang.maKH}" 
                       readonly required>
                <div class="form-text text-muted">Mã khách hàng được hệ thống tự động sinh và không thể thay đổi.</div>
            </div>

            <div class="mb-3">
                <label for="hoTen" class="form-label fw-bold">Họ và Tên</label>
                <input type="text" class="form-control" id="hoTen" name="hoTen" 
                       value="${khachHang.hoTen}" placeholder="Nhập họ tên khách hàng..." required>
            </div>

            <div class="mb-3">
                <label for="sdt" class="form-label fw-bold">Số Điện Thoại</label>
                <input type="text" class="form-control" id="sdt" name="sdt" 
                       value="${khachHang.sdt}" placeholder="Nhập số điện thoại..." required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label fw-bold">Email</label>
                <input type="email" class="form-control" id="email" name="email" 
                       value="${khachHang.email}" placeholder="Nhập địa chỉ email..." required>
            </div>

            <div class="mb-3">
                <label for="diaChi" class="form-label fw-bold">Địa Chỉ</label>
                <textarea class="form-control" id="diaChi" name="diaChi" rows="3" placeholder="Nhập địa chỉ...">${khachHang.diaChi}</textarea>
            </div>

            <div class="text-end mt-4">
                <button type="submit" class="btn btn-primary px-4 fw-bold">
                    <i class="fas fa-save me-1"></i> ${empty khachHang ? 'Lưu Khách Hàng' : 'Cập Nhật'}
                </button>
            </div>
        </form>
    </div>
</div>