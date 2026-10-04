<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<div class="container-fluid">
    <!-- Hiển thị thông báo (nếu có từ Session) -->
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            ${sessionScope.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% session.removeAttribute("message");%>
    </c:if>

    <!-- Tiêu đề và nút thêm mới -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4><i class="fas fa-calendar-alt text-primary"></i> Quản Lý Đặt Phòng</h4>
        <a href="dat-phong?action=form-add" class="btn btn-danger">
            <i class="fas fa-plus"></i> Thêm Đặt Phòng Mới
        </a>
    </div>

    <form action="dat-phong" method="post" class="row g-3 align-items-center mb-4">
        <input type="hidden" name="action" value="list">

        <div class="col-md-5">
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-search"></i></span>
                <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="Nhập Tên Khách Hàng, hoặc mã phòng...">
            </div>
        </div>

        <div class="col-md-3">
            <select name="status" class="form-select">
                <option value="">-- Tất cả trạng thái --</option>
                <option value="Chờ xác nhận" ${status == 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác nhận</option>
                <option value="Đã xác nhận" ${status == 'Đã xác nhận' ? 'selected' : ''}>Đã xác nhận</option>
                <option value="Đã thuê" ${status == 'Đã thuê' ? 'selected' : ''}>Đã Thuê</option>
                <option value="Hoàn thành" ${status == 'Hoàn thành' ? 'selected' : ''}>Hoàn Thành</option>
                <option value="Đã hủy" ${status == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
            </select>
        </div>

        <div class="col-md-4">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-dark px-4">
                    <i class="fas fa-filter me-1"></i> Lọc
                </button>
                <a href="dat-phong?action=list" class="btn btn-outline-secondary px-3" title="Làm mới bộ lọc">
                    <i class="fas fa-sync-alt"></i>
                </a>
            </div>
        </div>
    </form>

    <!-- Bảng hiển thị dữ liệu -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle bg-white">
            <thead class="table-dark text-center">
                <tr>
                    <th>MÃ ĐP</th>
                    <th>MÃ PHÒNG</th>
                    <th>KHÁCH HÀNG</th>
                    <th>SỐ LƯỢNG</th>
                    <th>NGÀY ĐẶT</th>
                    <th>NGÀY NHẬN</th>
                    <th>NGÀY TRẢ</th>
                    <th>TIỀN CỌC</th>
                    <th>TRẠNG THÁI CỌC</th>
                    <th>TỔNG TIỀN</th>
                    <th>TRẠNG THÁI PHÒNG</th>
                    <th>HÀNH ĐỘNG</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty datPhongList}">
                        <c:forEach var="dp" items="${datPhongList}">
                            <tr>
                                <td class="fw-bold text-center">${dp.maDP}</td>
                                <td class="text-center">${dp.maPhong}</td>
                                <td>${dp.tenKH}</td>
                                <td class="text-center">${dp.soLuong}</td>
                                <td class="text-center">${dp.ngayDat}</td>
                                <td class="text-center">${dp.ngayNhan}</td>
                                <td class="text-center">${dp.ngayTra}</td>
                                <td class="text-end text-success fw-bold">
                                    <fmt:formatNumber value="${dp.tienCoc}" type="number" maxFractionDigits="0" /> đ
                                </td>
                                <!-- Cột Trạng thái cọc -->
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${dp.trangThaiCoc == 'Đã cọc'}">
                                            <span class="badge bg-success text-white px-2 py-1">Đã cọc</span>
                                        </c:when>
                                       
                                        <c:when test="${dp.trangThaiCoc == 'Đã hoàn tiền'}">
                                            <span class="badge bg-info text-white px-2 py-1">Đã hoàn tiền</span>
                                        </c:when>
                                        <c:when test="${dp.trangThaiCoc == 'Phạt Cọc'}">
                                            <span class="badge bg-danger text-white px-2 py-1">Phạt Cọc</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark px-2 py-1">Chưa cập nhật</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <!-- Cột Tổng tiền (Đã loại bỏ bị lặp) -->
                                <td class="text-end fw-bold">
                                    <fmt:formatNumber value="${dp.tongTien}" type="number" maxFractionDigits="0" /> đ
                                </td>
                                <!-- Cột Trạng thái phòng -->
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${dp.trangThai == 'Chờ xác nhận'}">
                                            <span class="badge bg-warning text-white px-2 py-1">${dp.trangThai}</span>
                                        </c:when>
                                        <c:when test="${dp.trangThai == 'Đã xác nhận'}">
                                            <span class="badge bg-success text-white px-2 py-1">${dp.trangThai}</span>
                                        </c:when>
                                        <c:when test="${dp.trangThai == 'Đã thuê'}">
                                            <span class="badge text-white px-2 py-1" style="background-color: #fd7e14;">${dp.trangThai}</span>
                                        </c:when>
                                        <c:when test="${dp.trangThai == 'Đã hủy'}">
                                            <span class="badge bg-danger text-white px-2 py-1">${dp.trangThai}</span>
                                        </c:when>
                                        <c:when test="${dp.trangThai == 'Hoàn thành'}">
                                            <span class="badge bg-primary text-white px-2 py-1">${dp.trangThai}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary text-white px-2 py-1">${dp.trangThai}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="dat-phong?action=edit&maDP=${dp.maDP}" class="btn btn-sm btn-warning" title="Sửa">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="dat-phong?action=delete&maDP=${dp.maDP}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa đặt phòng này?');" title="Xóa">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="12" class="text-center text-muted py-4">
                                Không có dữ liệu đặt phòng nào trong hệ thống.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>