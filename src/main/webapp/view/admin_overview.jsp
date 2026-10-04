<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid px-4">
    <h1 class="mt-4">Tổng Quan Hệ Thống</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Trang quản trị / Bảng điều khiển</li>
    </ol>
    
    <!-- Các ô thống kê nhanh -->
    <div class="row">
        <!-- Tổng số phòng -->
        <div class="col-xl-3 col-md-6 mb-4">
            <a href="${pageContext.request.contextPath}/admin/room" class="text-decoration-none">
                <div class="card bg-primary text-white shadow h-100 py-2" style="cursor: pointer; transition: transform 0.2s;">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-uppercase mb-1">Tổng Số Phòng</div>
                                <div class="h5 mb-0 font-weight-bold">${totalRooms}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-door-open fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Tổng loại phòng -->
        <div class="col-xl-3 col-md-6 mb-4">
            <a href="${pageContext.request.contextPath}/admin/adminloaiphong" class="text-decoration-none">
                <div class="card bg-success text-white shadow h-100 py-2" style="cursor: pointer; transition: transform 0.2s;">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-uppercase mb-1">Loại Phòng</div>
                                <div class="h5 mb-0 font-weight-bold">${totalLoaiPhong}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-list fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Khách hàng -->
        <div class="col-xl-3 col-md-6 mb-4">
            <a href="${pageContext.request.contextPath}/admin/adminkhachhang" class="text-decoration-none">
                <div class="card bg-warning text-white shadow h-100 py-2" style="cursor: pointer; transition: transform 0.2s;">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-uppercase mb-1">Khách Hàng</div>
                                <div class="h5 mb-0 font-weight-bold">${totalKhachHang}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-users fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Đặt phòng -->
        <div class="col-xl-3 col-md-6 mb-4">
            <a href="${pageContext.request.contextPath}/admin/admindatphong" class="text-decoration-none">
                <div class="card bg-danger text-white shadow h-100 py-2" style="cursor: pointer; transition: transform 0.2s;">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-uppercase mb-1">Đơn Đặt Phòng</div>
                                <div class="h5 mb-0 font-weight-bold">${totalDatPhong}</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-calendar-check fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <!-- --- KHU VỰC HIỂN THỊ BIỂU ĐỒ --- -->
    <div class="row">
        <!-- Biểu đồ thống kê trạng thái đặt phòng (Bên trái) -->
        <div class="col-xl-6 col-lg-6 mb-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <h5 class="card-title fw-bold text-dark mb-3">
                        <i class="fas fa-chart-pie text-primary me-2"></i> Thống Kê Trạng Thái Đặt Phòng
                    </h5>
                    <hr>
                    <div style="position: relative; height: 300px; width: 100%;">
                        <canvas id="bookingStatusChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Biểu đồ doanh thu theo tháng (Bên phải) -->
        <div class="col-xl-6 col-lg-6 mb-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <h5 class="card-title fw-bold text-dark mb-3">
                        <i class="fas fa-chart-bar text-success me-2"></i> Biểu Đồ Doanh Thu Theo Tháng
                    </h5>
                    <hr>
                    <div style="position: relative; height: 300px; width: 100%;">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Nhúng thư viện Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 1. Biểu đồ tròn trạng thái đặt phòng
        const ctxStatus = document.getElementById('bookingStatusChart').getContext('2d');
        new Chart(ctxStatus, {
            type: 'doughnut',
            data: {
                labels: ['Đã xác nhận', 'Chờ xác nhận', 'Đã thuê', 'Đã hủy', 'Hoàn thành'], // ✅ Đã thêm nhãn 'Đã thuê'
                datasets: [{
                    data: [
                        ${empty countDaXacNhan ? 0 : countDaXacNhan}, 
                        ${empty countChoXacNhan ? 0 : countChoXacNhan}, 
                        ${empty countDaThue ? 0 : countDaThue},       // ✅ Giá trị trạng thái 'Đã thuê'
                        ${empty countDaHuy ? 0 : countDaHuy},
                        ${empty countHoanThanh ? 0 : countHoanThanh}
                    ],
                    backgroundColor: [
                        '#198754',
                        '#ffc107', 
                        '#fd7e14', 
                        '#dc3545', 
                        '#0d6efd'  
                    ],
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });

        // 2. Biểu đồ cột doanh thu theo tháng
        const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctxRevenue, {
            type: 'bar',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: [
                        <c:forEach var="rev" items="${monthlyRevenues}">
                            ${rev},
                        </c:forEach>
                    ],
                    backgroundColor: '#0d6efd',
                    borderRadius: 5
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true }
                },
                plugins: {
                    legend: { display: false }
                }
            }
        });
    });
</script>