<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    // Xử lý định dạng ngày giờ để hiển thị chính xác vào ô input type="datetime-local" khi ở chế độ sửa
    DateTimeFormatter htmlFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
    if (request.getAttribute("datPhong") != null) {
        Model.DatPhong dp = (Model.DatPhong) request.getAttribute("datPhong");
        if (dp.getNgayNhan() != null) {
            request.setAttribute("ngayNhanFormatted", dp.getNgayNhan().format(htmlFormatter));
        }
        if (dp.getNgayTra() != null) {
            request.setAttribute("ngayTraFormatted", dp.getNgayTra().format(htmlFormatter));
        }
    }
%>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body p-4">
                <!-- Tiêu đề nằm bên trái, nút Quay lại nằm bên phải -->
                <div class="d-flex align-items-center justify-content-between mb-4 pb-3 border-bottom">
                    <h3 class="text-dark fw-bold mb-0">
                        <c:choose>
                            <c:when test="${not empty datPhong}">
                                <i class="fas fa-edit text-warning me-2"></i> Cập Nhật Đơn Đặt Phòng
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus-circle text-danger me-2"></i> Thêm Đơn Đặt Phòng Mới
                            </c:otherwise>
                        </c:choose>
                    </h3>
                    <a href="${pageContext.request.contextPath}/admin/dat-phong?action=list" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <!-- Form action tự đổi thành add hoặc update -->
                <form action="${pageContext.request.contextPath}/admin/dat-phong?action=${not empty datPhong ? 'update' : 'add'}" method="POST">
                    <c:if test="${not empty datPhong}">
                        <input type="hidden" name="tongTien" value="${datPhong.tongTien}">
                        <input type="hidden" name="tienCoc" value="${datPhong.tienCoc}">
                    </c:if>
                    <!-- Mã Đặt Phòng -->
                    <div class="mb-3">
                        <label for="maDP" class="form-label fw-bold">Mã Đặt Phòng</label>
                        <input type="text" class="form-control bg-light" id="maDP" name="maDP" 
                               value="${not empty datPhong ? datPhong.maDP : nextMaDP}" readonly>
                    </div>

                    <!-- Chọn Khách Hàng -->
                    <div class="mb-3">
                        <label for="maKH" class="form-label fw-bold">Khách Hàng</label>
                        <select class="form-select" id="maKH" name="maKH" required>
                            <option value="" disabled ${empty datPhong ? 'selected' : ''}>-- Chọn khách hàng --</option>
                            <c:forEach var="kh" items="${khachHangList}">
                                <option value="${kh.maKH}" ${datPhong.maKH == kh.maKH ? 'selected' : ''}>
                                    ${kh.hoTen} (Mã: ${kh.maKH})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- PHÂN TÁCH: Thêm mới dùng Checkbox (Nhiều phòng), Cập nhật dùng Select (1 phòng) -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">Phòng Cần Đặt <span class="text-danger">*</span></label>

                        <c:choose>
                            <%-- Khi ở chế độ THÊM MỚI: Hiển thị danh sách checkbox chọn nhiều phòng --%>
                            <c:when test="${empty datPhong}">
                                <div class="row border p-3 rounded bg-light" style="max-height: 220px; overflow-y: auto;">
                                    <c:forEach var="p" items="${phongList}">
                                        <c:set var="roomStatus" value="${roomStatusMap[p.maPhong]}" />
                                        <div class="col-md-4 mb-2">
                                            <div class="form-check">
                                                <!-- Khóa checkbox nếu là "Đã xác nhận" hoặc "Đã thuê" -->
                                                <input class="form-check-input room-checkbox" type="checkbox" name="selectedRooms" value="${p.maPhong}" id="room_${p.maPhong}"
                                                       data-price="${p.gia}" 
                                                       data-status="${roomStatus}"
                                                       <c:if test="${roomStatus == 'Đã xác nhận' || roomStatus == 'Đã thuê'}">disabled</c:if>>

                                                       <label class="form-check-label <c:if test="${roomStatus == 'Đã xác nhận' || roomStatus == 'Đã thuê'}">text-muted</c:if>" for="room_${p.maPhong}">
                                                    <strong>${p.maPhong}</strong> - ${p.tenPhong}

                                                    <!-- Hiển thị nhãn trạng thái -->
                                                    <c:if test="${roomStatus == 'Đã xác nhận'}">
                                                        <span class="badge bg-success text-white ms-1" style="font-size: 10px;">(Đã xác nhận)</span>
                                                    </c:if>
                                                    <c:if test="${roomStatus == 'Đã thuê'}">
                                                        <span class="badge bg-danger text-white ms-1" style="font-size: 10px;">(Đã thuê)</span>
                                                    </c:if>
                                                    <c:if test="${roomStatus == 'Chờ xác nhận'}">
                                                        <span class="badge bg-warning text-dark ms-1" style="font-size: 10px;">⚠️ Chờ xác nhận</span>
                                                    </c:if>
                                                </label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <small class="text-muted">* Những phòng có đơn "Đã xác nhận" hoặc "Đã thuê" sẽ bị khóa. Phòng "Chờ xác nhận" có thể chọn nhưng sẽ hiển thị cảnh báo.</small>
                            </c:when>

                            <%-- Khi ở chế độ CẬP NHẬT/SỬA: Hiển thị thẻ select để chọn 1 phòng duy nhất --%>
                            <c:otherwise>
                                <select class="form-select" id="maPhong" name="maPhong" required>
                                    <option value="" disabled>-- Chọn phòng --</option>
                                    <c:forEach var="p" items="${phongList}">
                                        <option value="${p.maPhong}" ${datPhong.maPhong == p.maPhong ? 'selected' : ''}>
                                            ${p.maPhong} - ${p.tenPhong}
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Ngày Nhận Phòng -->
                    <div class="mb-3">
                        <label for="ngayNhan" class="form-label fw-bold">Ngày Giờ Nhận Phòng</label>
                        <input type="datetime-local" class="form-control" id="ngayNhan" name="ngayNhan" 
                               value="${ngayNhanFormatted}" required>
                    </div>

                    <!-- Ngày Trả Phòng -->
                    <div class="mb-3">
                        <label for="ngayTra" class="form-label fw-bold">Ngày Giờ Trả Phòng</label>
                        <input type="datetime-local" class="form-control" id="ngayTra" name="ngayTra" 
                               value="${ngayTraFormatted}" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="tongTien" class="form-label fw-bold">Tổng Tiền (VNĐ)</label>
                            <input type="number" class="form-control bg-light" id="tongTien" name="tongTien" 
                                   value="${not empty datPhong ? datPhong.tongTien : '0'}" readonly>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="tienCoc" class="form-label fw-bold">Tiền Cọc (30% Tổng tiền)</label>
                            <input type="number" class="form-control bg-light" id="tienCoc" name="tienCoc" 
                                   value="${not empty datPhong ? datPhong.tienCoc : '0'}" readonly>
                        </div>
                    </div>

                    <!-- Trạng Thái Đơn Hàng -->
                    <div class="mb-3">
                        <label for="trangThai" class="form-label fw-bold">Trạng Thái Đơn</label>
                        <select class="form-select" id="trangThai" name="trangThai" required>
                            <c:choose>
                                <%-- Trường hợp 1: Đang là "Đã thuê" -> Chỉ được giữ nguyên hoặc chuyển sang "Hoàn thành" --%>
                                <c:when test="${datPhong.trangThai == 'Đã thuê'}">
                                    <option value="Đã thuê" selected>Đã thuê</option>
                                    <option value="Hoàn thành">Hoàn thành</option>
                                </c:when>

                                <%-- Trường hợp 2: Đang là "Chờ xác nhận" hoặc "Đã xác nhận" -> Có thể chuyển tiếp hoặc bấm Hủy --%>
                                <c:when test="${datPhong.trangThai == 'Chờ xác nhận' || datPhong.trangThai == 'Đã xác nhận'}">
                                    <option value="Chờ xác nhận" ${datPhong.trangThai == 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác nhận</option>
                                    <option value="Đã xác nhận" ${datPhong.trangThai == 'Đã xác nhận' ? 'selected' : ''}>Đã xác nhận</option>
                                    <option value="Đã thuê">Đã thuê</option>
                                    <option value="Đã hủy">Đã hủy</option>
                                </c:when>

                                <%-- Trường hợp 3: Khi thêm mới đơn hàng (Chưa có object datPhong) --%>
                                <c:when test="${empty datPhong}">
                                    <option value="Chờ xác nhận" selected>Chờ xác nhận</option>
                                    <option value="Đã xác nhận">Đã xác nhận</option>
                                    <option value="Đã thuê">Đã thuê</option>
                                </c:when>

                                <%-- Trường hợp 4: Nếu đơn đã kết thúc (Hoàn thành hoặc Đã hủy) -> Khóa cứng trạng thái --%>
                                <c:otherwise>
                                    <option value="${datPhong.trangThai}" selected>${datPhong.trangThai}</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                        <div class="form-text text-muted">
                            * Ràng buộc: Đơn "Đã thuê" chỉ có thể chuyển sang "Hoàn thành". Đơn chờ/đã xác nhận có thể chuyển tiếp hoặc hủy.
                        </div>
                    </div>

                    <!-- TRẠNG THÁI CỌC (Bổ sung 3 trạng thái mới) -->
                    <div class="mb-4">
                        <label for="trangThaiCoc" class="form-label fw-bold">Trạng Thái Cọc</label>
                        <select class="form-select" id="trangThaiCoc" name="trangThaiCoc" required>
                            <option value="Đã cọc" ${datPhong.trangThaiCoc == 'Đã cọc' or empty datPhong ? 'selected' : ''}>Đã cọc</option>
                            <option value="Đã hoàn tiền" ${datPhong.trangThaiCoc == 'Đã hoàn tiền' ? 'selected' : ''}>Đã hoàn tiền (Khách hủy sớm)</option>
                            <option value="Phạt Cọc" ${datPhong.trangThaiCoc == 'Phạt Cọc' ? 'selected' : ''}>Phạt Cọc (Khách hủy trễ / No-show)</option>
                        </select>
                        <div class="form-text text-muted">
                            * Quản lý tài chính: Đã cọc (bình thường), Đã hoàn cọc (trả lại tiền cho khách hủy sớm), Phạt (giữ lại tiền cọc do hủy trễ).
                        </div>
                    </div>

                    <!-- Nút Thao Tác -->
                    <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/admin/dat-phong?action=list" class="btn btn-secondary px-4">
                            <i class="fas fa-times me-1"></i> Hủy bỏ
                        </a>
                        <button type="submit" class="btn ${not empty datPhong ? 'btn-warning text-white' : 'btn-danger'} px-5 fw-bold">
                            <i class="fas fa-save me-1"></i> ${not empty datPhong ? 'Cập Nhật' : 'Lưu Đặt Phòng'}
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const checkboxes = document.querySelectorAll('.room-checkbox');
        checkboxes.forEach(cb => {
            cb.addEventListener('change', function () {
                if (this.checked && this.getAttribute('data-status') === 'Chờ xác nhận') {
                    alert('⚠️ CẢNH BÁO: Phòng ' + this.value + ' hiện đang có đơn đặt ở trạng thái "Chờ xác nhận". Vui lòng kiểm tra lại trước khi tạo thêm đơn!');
                }
            });
        });
    });
</script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const roomCheckboxes = document.querySelectorAll('input[name="selectedRooms"]');
        const ngayNhanInput = document.getElementById("ngayNhan");
        const ngayTraInput = document.getElementById("ngayTra");
        const tongTienInput = document.getElementById("tongTien");
        const tienCocInput = document.getElementById("tienCoc");

        function updateTien() {
            let tongGiaPhongMoiNgay = 0;
     
            roomCheckboxes.forEach(cb => {
                if (cb.checked) {
                    let price = parseFloat(cb.getAttribute("data-price")) || 0;
                    tongGiaPhongMoiNgay += price;
                }
            });

            // Tính số ngày thuê
            let soNgay = 1;
            if (ngayNhanInput.value && ngayTraInput.value) {
                let d1 = new Date(ngayNhanInput.value);
                let d2 = new Date(ngayTraInput.value);
                let diffTime = d2 - d1;
                let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                if (diffDays > 0) {
                    soNgay = diffDays;
                }
            }

            let tongTien = tongGiaPhongMoiNgay * soNgay;
            let tienCoc = tongTien * 0.3;

            if (tongTienInput)
                tongTienInput.value = tongTien;
            if (tienCocInput)
                tienCocInput.value = Math.round(tienCoc); 
        }

        roomCheckboxes.forEach(cb => cb.addEventListener("change", updateTien));
        if (ngayNhanInput)
            ngayNhanInput.addEventListener("change", updateTien);
        if (ngayTraInput)
            ngayTraInput.addEventListener("change", updateTien);
    });
</script>