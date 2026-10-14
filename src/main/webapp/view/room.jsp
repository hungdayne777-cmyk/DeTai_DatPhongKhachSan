<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Danh sách phòng - Đặt Phòng Khách Sạn</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
        <link rel="icon" href="${pageContext.request.contextPath}/images/fevicon.png" type="image/gif" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.mCustomScrollbar.min.css">
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
    </head>
    <body class="main-layout inner_page">

        <div class="loader_bg">
            <div class="loader"><img src="${pageContext.request.contextPath}/images/loading.gif" alt="#"/></div>
        </div>

        <!-- NAVBAR -->
        <jsp:include page="/layout/navbar.jsp" />

        <!-- BANNER -->
        <div class="back_re">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="title">
                            <h2>DANH SÁCH PHÒNG</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- OUR ROOM -->
        <div class="our_room">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="titlepage">
                            <p class="margin_0">Khám phá các phòng Khách Sạn tiện nghi, sạch sẽ và phù hợp với nhu cầu của bạn</p>
                        </div>
                    </div>
                </div>

                <!-- THANH LỌC VÀ SẮP XẾP GIÁ PHÒNG -->
                <div class="row mb-4">
                    <div class="col-md-12 d-flex justify-content-end">
                        <form action="${pageContext.request.contextPath}/rooms" method="get" class="form-inline">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <label class="input-group-text bg-dark text-white fw-bold" for="sortSelect">
                                        <i class="fa fa-sort mr-1"></i> Sắp xếp theo giá:
                                    </label>
                                </div>
                                <select name="sort" id="sortSelect" class="form-control" onchange="this.form.submit()">
                                    <option value="">-- Mặc định --</option>
                                    <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Giá từ thấp đến cao</option>
                                    <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Giá từ cao đến thấp</option>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- DANH SÁCH THẺ PHÒNG -->
                <div class="row">
                    <c:forEach items="${roomList}" var="r">
                        <div class="col-lg-4 col-md-6 mb-4 d-flex">
                            <div class="card h-100 shadow-sm border-0 w-100 d-flex flex-column">
                                <img src="${pageContext.request.contextPath}/images/${r.hinhAnh}" 
                                     class="card-img-top" 
                                     alt="${r.tenPhong}" 
                                     style="height: 200px; object-fit: cover; width: 100%;"/>

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
                                        <span class="${r.tinhTrang eq 'Trống' ? 'text-success font-weight-bold' : 'text-danger font-weight-bold'}">
                                            ${r.tinhTrang}
                                        </span>
                                    </p>

                                    <div class="mt-auto d-flex justify-content-between align-items-center w-100">
                                        <button type="button" class="btn btn-outline-dark btn-sm font-weight-bold" style="width: 48%;" onclick="openRoomModal('${r.maPhong}')">
                                            Chi Tiết
                                        </button>

                                        <c:choose>
                                            <c:when test="${r.tinhTrang eq 'Trống'}">
                                                <a href="${pageContext.request.contextPath}/book?maPhong=${r.maPhong}" 
                                                   class="btn btn-danger btn-sm font-weight-bold" style="width: 48%;">
                                                    Đặt Ngay
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" 
                                                        class="btn btn-secondary btn-sm font-weight-bold" 
                                                        disabled 
                                                        style="width: 48%; opacity: 0.65; cursor: not-allowed;">
                                                    Hết Phòng
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- MODAL CHI TIẾT -->
                        <div id="customModal_${r.maPhong}" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); z-index: 9999; justify-content: center; align-items: center;">
                            <div style="background: #fff; width: 90%; max-width: 700px; border-radius: 8px; overflow: hidden; box-shadow: 0 5px 20px rgba(0,0,0,0.2);">
                                <div style="background: #121212; color: #fff; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center;">
                                    <h5 style="margin: 0; font-weight: bold; font-size: 18px; color: #fff;">Chi Tiết: ${r.tenPhong}</h5>
                                    <button type="button" onclick="closeRoomModal('${r.maPhong}')" style="background: none; border: none; color: #fff; font-size: 26px; cursor: pointer;">&times;</button>
                                </div>
                                <div style="padding: 20px;">
                                    <p class="mb-2"><strong>Mã phòng:</strong> ${r.maPhong}</p>
                                    <p class="mb-2"><strong>Tên phòng:</strong> ${r.tenPhong}</p>
                                    <p class="mb-2"><strong>Giá:</strong> <fmt:formatNumber value="${r.gia}" pattern="#,##0" /> VNĐ</p>
                                    <p class="mb-3"><strong>Tình trạng:</strong> ${r.tinhTrang}</p>
                                    <p class="mb-2"><strong>Mô tả:</strong> ${r.moTa}</p>
                                </div>
                                <div style="background: #f8f9fa; padding: 12px 20px; text-align: right;">
                                    <button type="button" class="btn btn-outline-dark btn-sm" onclick="closeRoomModal('${r.maPhong}')">Đóng</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <script>
            function openRoomModal(maPhong) {
                document.getElementById('customModal_' + maPhong).style.display = 'flex';
            }
            function closeRoomModal(maPhong) {
                document.getElementById('customModal_' + maPhong).style.display = 'none';
            }
            window.onclick = function (event) {
                if (event.target.id && event.target.id.startsWith('customModal_')) {
                    event.target.style.display = 'none';
                }
            }
        </script>

        <!-- FOOTER -->
        <jsp:include page="/layout/footer.jsp" />

        <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    </body>
</html>