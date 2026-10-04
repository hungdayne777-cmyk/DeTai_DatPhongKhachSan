<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="our_room">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="titlepage">
                    <h2>Danh Sách Phòng</h2>
                    <p class="margin_0">Khám phá các phòng Khách Sạn tiện nghi, sạch sẽ và phù hợp với nhu cầu của bạn</p>
                </div>
            </div>
        </div>
        <div class="row">
           
          <c:forEach items="${roomList}" var="r">
                        <div class="col-lg-4 col-md-6 mb-4 d-flex">
                            <!-- Thẻ Card phòng -->
                            <div class="card h-100 shadow-sm border-0 w-100 d-flex flex-column">
                                <!-- Ảnh phòng -->
                                <img src="${pageContext.request.contextPath}/images/${r.hinhAnh}" 
                                     class="card-img-top" 
                                     alt="${r.tenPhong}" 
                                     style="height: 200px; object-fit: cover; width: 100%;"/>

                                <!-- Nội dung phòng -->
                                <div class="card-body d-flex flex-column text-center p-3">
                                    <h5 class="card-title font-weight-bold text-dark mb-2">${r.tenPhong}</h5>

                               
                                    <p class="card-text text-muted small text-truncate mb-3">
                                        ${r.moTa}
                                    </p>

                                    <p class="card-text mb-2"><strong>Giá:</strong> 
                                        <span class="text-danger font-weight-bold">
                                            <fmt:formatNumber value="${r.gia}" pattern="#,##0" /> VNĐ
                                        </span>
                                    </p>

                                    <p class="card-text mb-4"><strong>Tình trạng:</strong> 
                                        <span class="${r.tinhTrang eq 'Trống' ? 'text-success font-weight-bold' : 'text-secondary font-weight-bold'}">
                                            ${r.tinhTrang}
                                        </span>
                                    </p>

                                    <!-- Cụm nút Chi Tiết và Đặt Ngay -->
                                    <div class="mt-auto d-flex justify-content-between align-items-center w-100">
                                        <!-- Nút Chi Tiết gọi hàm JavaScript mở Popup -->
                                        <button type="button" class="btn btn-outline-dark btn-sm font-weight-bold" style="width: 48%;" onclick="openRoomModal('${r.maPhong}')">
                                            Chi Tiết
                                        </button>

                                        <!-- Nút Đặt Ngay -->
                                        <a href="${pageContext.request.contextPath}/book?maPhong=${r.maPhong}" 
                                           class="btn btn-danger btn-sm font-weight-bold" style="width: 48%;">
                                            Đặt Ngay
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- ================= MODAL HIỂN THỊ CHI TIẾT PHÒNG (Tone Trắng - Đen) ================= -->
                        <div id="customModal_${r.maPhong}" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); z-index: 9999; justify-content: center; align-items: center;">
                            <div style="background: #fff; width: 90%; max-width: 700px; border-radius: 8px; overflow: hidden; box-shadow: 0 5px 20px rgba(0,0,0,0.2);">

                               <div style="background: #121212; color: #fff; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center;">
    <h5 style="margin: 0; font-weight: bold; font-size: 18px; color: #fff;"><i class="fa fa-door-open mr-2"></i> Chi Tiết: ${r.tenPhong}</h5>
    <button type="button" onclick="closeRoomModal('${r.maPhong}')" style="background: none; border: none; color: #fff; font-size: 26px; cursor: pointer; line-height: 1;">&times;</button>
</div>
                                <!-- Modal Body -->
                                <div style="padding: 20px; max-height: 70vh; overflow-y: auto;">
                                    <div class="row align-items-center">
                                        <div class="col-md-6 mb-3 mb-md-0">
                                            <img src="${pageContext.request.contextPath}/images/${r.hinhAnh}" class="img-fluid rounded shadow-sm w-100" style="height: 220px; object-fit: cover;" alt="${r.tenPhong}">
                                        </div>
                                        <div class="col-md-6 text-left">
                                            <!-- Đổi màu chữ nhấn từ xanh dương sang đen/xám đậm -->
                                            <p class="mb-2"><strong>Mã phòng:</strong> <span class="text-dark font-weight-bold">${r.maPhong}</span></p>
                                            <p class="mb-2"><strong>Tên phòng:</strong> ${r.tenPhong}</p>
                                            <p class="mb-2"><strong>Giá thuê:</strong> 
                                                <span class="text-dark font-weight-bold" style="font-size: 16px;">
                                                    <fmt:formatNumber value="${r.gia}" pattern="#,##0" /> VNĐ
                                                </span>
                                            </p>
                                            <p class="mb-3"><strong>Tình trạng:</strong> 
                                                <span class="${r.tinhTrang eq 'Trống' ? 'text-dark font-weight-bold' : 'text-muted font-weight-bold'}">
                                                    ${r.tinhTrang}
                                                </span>
                                            </p>
                                        </div>
                                    </div>

                                    <hr class="my-3">

                                    <div class="text-left">
                                        <h6 class="font-weight-bold text-secondary text-uppercase small mb-2">
                                            <i class="fa fa-align-left mr-1"></i> Mô tả chi tiết / Tiện ích phòng:
                                        </h6>
                                        <div class="p-3 bg-light rounded text-dark" style="white-space: pre-line; border-left: 3px solid #121212;">
                                            <c:choose>
                                                <c:when test="${not empty r.moTa}">
                                                    ${r.moTa}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted font-italic">Chưa có mô tả chi tiết cho phòng này.</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal Footer (Đổi nút bấm sang tone đen trắng tối giản) -->
                                <div style="background: #f8f9fa; padding: 12px 20px; text-align: right; border-top: 1px solid #dee2e6;">
                                    <button type="button" class="btn btn-outline-dark px-4 font-weight-bold btn-sm mr-2" onclick="closeRoomModal('${r.maPhong}')">Đóng</button>
                                    <a href="${pageContext.request.contextPath}/book?maPhong=${r.maPhong}" class="btn btn-danger px-4 font-weight-bold btn-sm" style="background-color: #ff3333; border-color: #121212;">
                                        Đặt Ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- =========================================================================================== -->

                    </c:forEach>

                    <!-- Đoạn Script điều khiển đóng/mở popup -->
                    <script>
                        function openRoomModal(maPhong) {
                            document.getElementById('customModal_' + maPhong).style.display = 'flex';
                        }

                        function closeRoomModal(maPhong) {
                            document.getElementById('customModal_' + maPhong).style.display = 'none';
                        }

                        // Bấm ra ngoài vùng nền tối bên ngoài thì tự động đóng modal
                        window.onclick = function (event) {
                            if (event.target.id && event.target.id.startsWith('customModal_')) {
                                event.target.style.display = 'none';
                            }
                        }
                    </script>
        </div>
    </div>
</div>