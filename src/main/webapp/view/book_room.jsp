<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <title>Xác nhận đặt phòng - Đặt Phòng Khách Sạn</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
        <link rel="icon" href="${pageContext.request.contextPath}/images/fevicon.png" type="image/gif" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
    </head>
    <body class="main-layout inner_page">

        <div class="loader_bg">
            <div class="loader"><img src="${pageContext.request.contextPath}/images/loading.gif" alt="#"/></div>
        </div>

        <jsp:include page="/layout/navbar.jsp" />

        <div class="back_re">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="title">
                            <h2>Xác Nhận Đặt Phòng</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container my-5">
            <div class="row">
                <div class="col-md-12">
                    <div class="titlepage mb-4">
                        <p class="margin_0">Vui lòng kiểm tra thông tin phòng và điền đầy đủ thông tin bên dưới để tiến hành đặt cọc.</p>
                    </div>
                </div>
            </div>
            <c:if test="${not empty sessionScope.message}">
                <div class="container mt-3">
                    <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                        <i class="fa fa-check-circle mr-2"></i> ${sessionScope.message}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
                <%
                    // Xóa message khỏi session sau khi đã hiển thị để tránh bị lặp lại khi tải lại trang
                    session.removeAttribute("message");
                %>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${sessionScope.errorMessage}
                </div>
                <% session.removeAttribute("errorMessage");%>
            </c:if>

            <form id="bookingForm" action="${pageContext.request.contextPath}/book" method="POST">
                <div class="row">
                    <div class="col-lg-5 mb-4">
                        <div class="card shadow-sm border-0 h-100">
                            <div style="background: #121212; color: #fff; padding: 12px 20px; font-weight: bold;">
                                <i class="fa fa-info-circle mr-2"></i> Thông Tin Phòng Lựa Chọn
                            </div>
                            <div class="card-body text-center">
                                <img src="${pageContext.request.contextPath}/images/${phongChiTiet.hinhAnh}" class="img-fluid rounded mb-3 shadow-sm" style="height: 220px; object-fit: cover; width: 100%;" alt="${phongChiTiet.tenPhong}">
                                <h4 class="font-weight-bold text-dark mb-2">${phongChiTiet.tenPhong}</h4>
                                <p class="text-muted small mb-3">${phongChiTiet.moTa}</p>
                                <hr>
                                <p class="text-left mb-2"><strong>Mã phòng:</strong> <span class="text-dark">${phongChiTiet.maPhong}</span></p>
                                <p class="text-left mb-2"><strong>Đơn giá:</strong> 
                                    <span class="text-danger font-weight-bold" style="font-size: 18px;" id="donGiaText" data-gia="${phongChiTiet.gia}">
                                        <fmt:formatNumber value="${phongChiTiet.gia}" pattern="#,##0" /> VNĐ / ngày
                                    </span>
                                </p>
                                <p class="text-left mb-0"><strong>Tình trạng:</strong> <span class="text-success font-weight-bold">${phongChiTiet.tinhTrang}</span></p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-7">
                        <div class="card shadow-sm border-0 h-100">
                            <div style="background: #121212; color: #fff; padding: 12px 20px; font-weight: bold;">
                                <i class="fa fa-user mr-2"></i> Thông Tin Khách Hàng & Thời Gian
                            </div>
                            <div class="card-body p-4">
                                <input type="hidden" name="maPhong" value="${phongChiTiet.maPhong}">

                                <div class="form-group mb-3">
                                    <label class="font-weight-bold">Họ và tên người đặt:</label>
                                    <input type="text" class="form-control" id="hoTen" name="hoTen" placeholder="Nhập họ và tên..." required>
                                </div>

                                <div class="form-group mb-3">
                                    <label class="font-weight-bold">Số điện thoại liên hệ:</label>
                                    <input type="text" class="form-control" id="sdt" name="sdt" placeholder="Nhập số điện thoại..." required>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 form-group mb-3">
                                        <label class="font-weight-bold">Ngày nhận phòng (Check-in):</label>
                                        <input type="date" class="form-control" id="ngayNhan" name="ngayNhan" required>
                                    </div>
                                    <div class="col-md-6 form-group mb-3">
                                        <label class="font-weight-bold">Ngày trả phòng (Check-out):</label>
                                        <input type="date" class="form-control" id="ngayTra" name="ngayTra" required>
                                    </div>
                                </div>

                                <div class="form-group mb-4">
                                    <label class="font-weight-bold">Ghi chú thêm (Yêu cầu đặc biệt):</label>
                                    <textarea class="form-control" name="ghiChu" rows="3" placeholder="Nhập ghi chú nếu có..."></textarea>
                                </div>

                                <div class="text-right">
                                    <a href="${pageContext.request.contextPath}/Trang-chu" class="btn btn-outline-dark px-4 font-weight-bold mr-2">Quay Lại</a>
                                    <button type="button" class="btn btn-danger px-5 font-weight-bold" style="background-color: #ff3333; border-color: #121212;" onclick="openDepositModal()">Tiến Hành Đặt Cọc</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="depositModal" tabindex="-1" role="dialog" aria-labelledby="depositModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content border-0 shadow">
                            <div class="modal-header bg-dark text-white">
                                <h5 class="modal-title font-weight-bold" id="depositModalLabel"><i class="fa fa-credit-card mr-2"></i> Xác Nhận Thông Tin & Đặt Cọc</h5>
                                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body p-4">
                                <div class="mb-3">
                                    <p class="mb-1"><strong>Khách hàng:</strong> <span id="lblHoTen" class="text-dark font-weight-bold"></span></p>
                                    <p class="mb-1"><strong>Số điện thoại:</strong> <span id="lblSdt" class="text-dark"></span></p>
                                    <p class="mb-1"><strong>Phòng:</strong> <span class="text-dark">${phongChiTiet.tenPhong}</span></p>
                                    <p class="mb-1"><strong>Thời gian:</strong> <span id="lblThoiGian" class="text-primary font-weight-bold"></span></p>
                                </div>
                                <hr>
                                <div class="bg-light p-3 rounded mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tổng số ngày:</span>
                                        <strong id="lblSoNgay">0 ngày</strong>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tổng tiền phòng:</span>
                                        <strong id="lblTongTien" class="text-dark">0 VNĐ</strong>
                                    </div>
                                    <div class="d-flex justify-content-between text-danger font-weight-bold" style="font-size: 16px;">
                                        <span>Số tiền đặt cọc (30%):</span>
                                        <strong id="lblTienCoc">0 VNĐ</strong>
                                    </div>
                                </div>

                                <div class="form-group mb-3">
                                    <label class="font-weight-bold">Phương thức thanh toán cọc:</label>
                                    <select class="form-control" id="phuongThucThanhToan" name="phuongThucThanhToan" onchange="togglePaymentMethod()">
                                        <option value="ChuyenKhoan">Chuyển khoản ngân hàng (QR Code)</option>
                                        <option value="Momo">Ví điện tử MoMo</option>
                                        <option value="TheQuocTe">Thẻ Visa / MasterCard</option>
                                    </select>
                                </div>

                                <div id="bankTransferInfo" class="border p-3 rounded mb-3 bg-white" style="display: none;">
                                    <h6 class="font-weight-bold text-center text-danger mb-3"><i class="fa fa-qrcode mr-1"></i> Thông Tin Chuyển Khoản Ngân Hàng</h6>
                                    <div class="row align-items-center">
                                        <div class="col-md-5 text-center mb-3 mb-md-0">
                                            <img id="qrCodeImg" src="" alt="Mã QR Chuyển Khoản" class="img-fluid rounded border shadow-sm" style="max-height: 185px; width: 100%; object-fit: contain;">
                                        </div>
                                        <div class="col-md-7 small">
                                            <p class="mb-1"><strong>Ngân hàng:</strong> VIETCOMBANK</p>
                                            <p class="mb-1"><strong>Số tài khoản:</strong> <span class="text-dark font-weight-bold">1046103431</span></p>
                                            <p class="mb-1"><strong>Chủ tài khoản:</strong> <span class="text-dark font-weight-bold">KHACH SAN</span></p>
                                            <p class="mb-1"><strong>Nội dung CK:</strong> <span class="text-danger font-weight-bold" id="lblNoiDungCK">DATPHONG ${phongChiTiet.maPhong}</span></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-body pt-0 px-4 pb-4 text-right">
                                <button type="button" class="btn btn-secondary px-4 mr-2" data-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-danger px-5 font-weight-bold" style="background-color: #ff3333;">Xác Nhận Đặt Cọc</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <jsp:include page="/layout/footer.jsp" />

        <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
        <script>
                                        function openDepositModal() {
                                            var hoTen = document.getElementById("hoTen").value.trim();
                                            var sdt = document.getElementById("sdt").value.trim();
                                            var ngayNhan = document.getElementById("ngayNhan").value;
                                            var ngayTra = document.getElementById("ngayTra").value;

                                            if (!hoTen || !sdt || !ngayNhan || !ngayTra) {
                                                alert("Vui lòng điền đầy đủ họ tên, số điện thoại và ngày nhận/trả phòng!");
                                                return;
                                            }

                                            var dNhan = new Date(ngayNhan);
                                            var dTra = new Date(ngayTra);
                                            if (dTra <= dNhan) {
                                                alert("Ngày trả phòng phải sau ngày nhận phòng ít nhất 1 ngày!");
                                                return;
                                            }

                                            var diffTime = Math.abs(dTra - dNhan);
                                            var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                                            var gia = parseFloat(document.getElementById("donGiaText").getAttribute("data-gia"));
                                            var tongTien = diffDays * gia;
                                            var tienCoc = tongTien * 0.3;

                                            document.getElementById("lblHoTen").innerText = hoTen;
                                            document.getElementById("lblSdt").innerText = sdt;
                                            document.getElementById("lblThoiGian").innerText = ngayNhan + " đến " + ngayTra;
                                            document.getElementById("lblSoNgay").innerText = diffDays + " ngày";
                                            document.getElementById("lblTongTien").innerText = tongTien.toLocaleString('vi-VN') + " VNĐ";
                                            document.getElementById("lblTienCoc").innerText = tienCoc.toLocaleString('vi-VN') + " VNĐ";

                                            var stk = "1046103431";
                                            var bankId = "VCB";
                                            var noiDung = "DATPHONG " + "${phongChiTiet.maPhong}";
                                            var qrUrl = "https://img.vietqr.io/image/" + bankId + "-" + stk + "-compact2.png?amount=" + tienCoc + "&addInfo=" + encodeURIComponent(noiDung);
                                            document.getElementById("qrCodeImg").src = qrUrl;

                                            togglePaymentMethod();

                                            $('#depositModal').modal('show');
                                        }

                                        function togglePaymentMethod() {
                                            var method = document.getElementById("phuongThucThanhToan").value;
                                            var bankDiv = document.getElementById("bankTransferInfo");
                                            if (method === "ChuyenKhoan") {
                                                bankDiv.style.display = "block";
                                            } else {
                                                bankDiv.style.display = "none";
                                            }
                                        }
        </script>
    </body>
</html>