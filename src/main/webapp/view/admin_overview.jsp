<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* ===== TỔNG THỂ ===== */
    .dashboard {
        --red: #ff304f;
        --red-dark: #b5122b;
        --glass: rgba(255, 255, 255, 0.055);
        --glass-border: rgba(255, 255, 255, 0.12);

        color: #f5f5f7;
        padding: 28px;
        min-height: 100%;
        background:
            radial-gradient(ellipse at 5% 0%, rgba(181, 18, 43, .20), transparent 40%),
            radial-gradient(ellipse at 95% 80%, rgba(255, 48, 79, .09), transparent 40%),
            #0b0b0f;
        border-radius: 16px;
    }

    .dashboard * {
        box-sizing: border-box;
    }

    .dashboard .page-heading {
        font-size: 30px;
        font-weight: 800;
        letter-spacing: -.7px;
        margin: 0 0 8px;
        color: #fff;
    }

    .dashboard .page-heading span {
        color: var(--red);
    }

    .dashboard .breadcrumb {
        background: transparent;
        padding: 0;
        margin-bottom: 30px;
    }

    .dashboard .breadcrumb-item,
    .dashboard .breadcrumb-item.active {
        color: #9696a3;
        font-size: 13px;
    }

    .dashboard .breadcrumb-item + .breadcrumb-item::before {
        color: #555560;
    }

    /* ===== THẺ THỐNG KÊ ===== */
    .dashboard .stat-card {
        display: block;
        position: relative;
        overflow: hidden;
        height: 100%;
        min-height: 155px;
        padding: 22px;
        color: #fff;
        text-decoration: none;
        background: linear-gradient(
            135deg,
            rgba(255, 255, 255, .085),
            rgba(255, 255, 255, .025)
        );
        border: 1px solid var(--glass-border);
        border-radius: 18px;
        backdrop-filter: blur(18px);
        -webkit-backdrop-filter: blur(18px);
        box-shadow: 0 12px 35px rgba(0, 0, 0, .22);
        transition: transform .3s ease, border-color .3s ease,
                    box-shadow .3s ease;
    }

    .dashboard .stat-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, var(--red), transparent);
        opacity: .9;
    }

    .dashboard .stat-card::after {
        content: "";
        position: absolute;
        width: 125px;
        height: 125px;
        right: -45px;
        bottom: -65px;
        border-radius: 50%;
        background: rgba(255, 48, 79, .10);
        filter: blur(4px);
        transition: transform .3s ease;
    }

    .dashboard .stat-card:hover {
        transform: translateY(-7px);
        border-color: rgba(255, 48, 79, .55);
        box-shadow: 0 18px 40px rgba(255, 20, 55, .10);
        color: #fff;
    }

    .dashboard .stat-card:hover::after {
        transform: scale(1.5);
    }

    .dashboard .stat-label {
        color: #b5b5c0;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 1.2px;
        text-transform: uppercase;
        margin-bottom: 14px;
    }

    .dashboard .stat-number {
        font-size: 34px;
        line-height: 1.2;
        font-weight: 800;
        color: #fff;
        margin-bottom: 12px;
    }

    .dashboard .stat-note {
        color: #8d8d99;
        font-size: 12px;
    }

    .dashboard .stat-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 54px;
        height: 54px;
        flex-shrink: 0;
        border-radius: 16px;
        color: #ff526b;
        background: rgba(255, 48, 79, .13);
        border: 1px solid rgba(255, 48, 79, .22);
        font-size: 23px;
        transition: transform .3s ease;
    }

    .dashboard .stat-card:hover .stat-icon {
        transform: rotate(-8deg) scale(1.08);
    }

    /* ===== KHUNG BIỂU ĐỒ ===== */
    .dashboard .chart-card {
        height: 100%;
        min-height: 390px;
        padding: 24px;
        border-radius: 20px;
        background: linear-gradient(
            145deg,
            rgba(255, 255, 255, .075),
            rgba(255, 255, 255, .025)
        );
        border: 1px solid var(--glass-border);
        backdrop-filter: blur(18px);
        -webkit-backdrop-filter: blur(18px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, .22);
        transition: border-color .3s ease, transform .3s ease;
    }

    .dashboard .chart-card:hover {
        border-color: rgba(255, 48, 79, .32);
        transform: translateY(-3px);
    }

    .dashboard .chart-heading {
        display: flex;
        align-items: center;
        gap: 13px;
        margin-bottom: 18px;
    }

    .dashboard .chart-icon {
        width: 43px;
        height: 43px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        border-radius: 13px;
        color: #ff526b;
        background: rgba(255, 48, 79, .13);
        font-size: 18px;
    }

    .dashboard .chart-title {
        font-size: 16px;
        font-weight: 750;
        color: #fff;
        margin: 0;
    }

    .dashboard .chart-subtitle {
        font-size: 12px;
        color: #898995;
        margin-top: 5px;
    }

    .dashboard .chart-divider {
        border: 0;
        height: 1px;
        background: linear-gradient(
            90deg,
            rgba(255, 48, 79, .5),
            rgba(255, 255, 255, .06),
            transparent
        );
        margin: 0 0 22px;
    }

    .dashboard .chart-wrapper {
        position: relative;
        height: 285px;
        width: 100%;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 768px) {
        .dashboard {
            padding: 16px;
        }

        .dashboard .page-heading {
            font-size: 24px;
        }

        .dashboard .stat-card {
            padding: 18px;
            min-height: 140px;
        }

        .dashboard .stat-number {
            font-size: 28px;
        }

        .dashboard .chart-card {
            padding: 18px;
            min-height: 360px;
        }

        .dashboard .chart-wrapper {
            height: 260px;
        }
    }

    @media (prefers-reduced-motion: reduce) {
        .dashboard *,
        .dashboard *::before,
        .dashboard *::after {
            transition: none !important;
        }
    }
</style>

<div class="dashboard">
    <div class="container-fluid p-0">

        <!-- TIÊU ĐỀ -->
        <div class="mb-4">
            <h1 class="page-heading">
                Tổng Quan <span>Hệ Thống</span>
            </h1>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">Trang quản trị</li>
                <li class="breadcrumb-item active">Bảng điều khiển</li>
            </ol>
        </div>

        <!-- THỐNG KÊ NHANH -->
        <div class="row g-4 mb-4">

            <!-- Tổng số phòng -->
            <div class="col-xl-3 col-md-6">
                <a href="${pageContext.request.contextPath}/admin/room"
                   class="stat-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <div class="stat-label">Tổng số phòng</div>
                            <div class="stat-number">${totalRooms}</div>
                            <div class="stat-note">Quản lý phòng khách sạn</div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-door-open"></i>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Loại phòng -->
            <div class="col-xl-3 col-md-6">
                <a href="${pageContext.request.contextPath}/admin/adminloaiphong"
                   class="stat-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <div class="stat-label">Loại phòng</div>
                            <div class="stat-number">${totalLoaiPhong}</div>
                            <div class="stat-note">Danh mục loại phòng</div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-list"></i>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Khách hàng -->
            <div class="col-xl-3 col-md-6">
                <a href="${pageContext.request.contextPath}/admin/adminkhachhang"
                   class="stat-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <div class="stat-label">Khách hàng</div>
                            <div class="stat-number">${totalKhachHang}</div>
                            <div class="stat-note">Thông tin khách hàng</div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Đặt phòng -->
            <div class="col-xl-3 col-md-6">
                <a href="${pageContext.request.contextPath}/admin/admindatphong"
                   class="stat-card">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <div class="stat-label">Đơn đặt phòng</div>
                            <div class="stat-number">${totalDatPhong}</div>
                            <div class="stat-note">Quản lý đơn đặt phòng</div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                    </div>
                </a>
            </div>

        </div>

        <!-- BIỂU ĐỒ -->
        <div class="row g-4">

            <!-- Trạng thái đặt phòng -->
            <div class="col-xl-6 col-lg-6">
                <div class="chart-card">
                    <div class="chart-heading">
                        <div class="chart-icon">
                            <i class="fas fa-chart-pie"></i>
                        </div>
                        <div>
                            <h5 class="chart-title">
                                Trạng Thái Đặt Phòng
                            </h5>
                            <div class="chart-subtitle">
                                Tổng quan tình trạng các đơn đặt phòng
                            </div>
                        </div>
                    </div>

                    <hr class="chart-divider">

                    <div class="chart-wrapper">
                        <canvas id="bookingStatusChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Doanh thu theo tháng -->
            <div class="col-xl-6 col-lg-6">
                <div class="chart-card">
                    <div class="chart-heading">
                        <div class="chart-icon">
                            <i class="fas fa-chart-column"></i>
                        </div>
                        <div>
                            <h5 class="chart-title">
                                Doanh Thu Theo Tháng
                            </h5>
                            <div class="chart-subtitle">
                                Thống kê doanh thu trong năm
                            </div>
                        </div>
                    </div>

                    <hr class="chart-divider">

                    <div class="chart-wrapper">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- CHART.JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {

        // Màu chữ dùng chung cho các biểu đồ
        Chart.defaults.color = "#a8a8b5";
        Chart.defaults.font.family = "'Segoe UI', sans-serif";

        // 1. BIỂU ĐỒ TRẠNG THÁI ĐẶT PHÒNG
        const statusCanvas = document.getElementById("bookingStatusChart");

        if (statusCanvas) {
            new Chart(statusCanvas.getContext("2d"), {
                type: "doughnut",
                data: {
                    labels: [
                        "Đã xác nhận",
                        "Chờ xác nhận",
                        "Đã thuê",
                        "Đã hủy",
                        "Hoàn thành"
                    ],
                    datasets: [{
                        data: [
                            ${empty countDaXacNhan ? 0 : countDaXacNhan},
                            ${empty countChoXacNhan ? 0 : countChoXacNhan},
                            ${empty countDaThue ? 0 : countDaThue},
                            ${empty countDaHuy ? 0 : countDaHuy},
                            ${empty countHoanThanh ? 0 : countHoanThanh}
                        ],
                        backgroundColor: [
                            "#ff304f",
                            "#ffb020",
                            "#ff7043",
                            "#8d172d",
                            "#a9b2c3"
                        ],
                        borderColor: "#17171e",
                        borderWidth: 4,
                        hoverOffset: 10,
                        spacing: 3
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: "66%",
                    plugins: {
                        legend: {
                            position: "bottom",
                            labels: {
                                color: "#c6c6d0",
                                padding: 18,
                                usePointStyle: true,
                                pointStyle: "circle",
                                boxWidth: 8,
                                font: {
                                    size: 11
                                }
                            }
                        },
                        tooltip: {
                            backgroundColor: "rgba(18, 18, 24, 0.96)",
                            titleColor: "#ff526b",
                            bodyColor: "#fff",
                            borderColor: "rgba(255,48,79,.35)",
                            borderWidth: 1,
                            padding: 12,
                            displayColors: true
                        }
                    }
                }
            });
        }

        // 2. BIỂU ĐỒ DOANH THU THEO THÁNG
        const revenueCanvas = document.getElementById("revenueChart");

        if (revenueCanvas) {
            new Chart(revenueCanvas.getContext("2d"), {
                type: "bar",
                data: {
                    labels: [
                        "T1", "T2", "T3", "T4",
                        "T5", "T6", "T7", "T8",
                        "T9", "T10", "T11", "T12"
                    ],
                    datasets: [{
                        label: "Doanh thu (VNĐ)",
                        data: [
                            <c:forEach var="rev" items="${monthlyRevenues}"
                                       varStatus="status">
                                ${empty rev ? 0 : rev}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ],
                        backgroundColor: [
                            "rgba(255,48,79,.85)",
                            "rgba(255,48,79,.65)",
                            "rgba(255,48,79,.75)",
                            "rgba(255,48,79,.65)",
                            "rgba(255,48,79,.85)",
                            "rgba(255,48,79,.65)",
                            "rgba(255,48,79,.75)",
                            "rgba(255,48,79,.65)",
                            "rgba(255,48,79,.85)",
                            "rgba(255,48,79,.65)",
                            "rgba(255,48,79,.75)",
                            "rgba(255,48,79,.85)"
                        ],
                        borderColor: "#ff304f",
                        borderWidth: 1,
                        borderRadius: 6,
                        borderSkipped: false,
                        maxBarThickness: 28,
                        hoverBackgroundColor: "#ff7588"
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        intersect: false,
                        mode: "index"
                    },
                    scales: {
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: "#9999a8"
                            },
                            border: {
                                display: false
                            }
                        },
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: "rgba(255,255,255,.06)",
                                drawTicks: false
                            },
                            ticks: {
                                color: "#9999a8",
                                padding: 10,
                                callback: function(value) {
                                    return new Intl.NumberFormat("vi-VN", {
                                        notation: "compact",
                                        maximumFractionDigits: 1
                                    }).format(value);
                                }
                            },
                            border: {
                                display: false
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: "rgba(18,18,24,.96)",
                            titleColor: "#ff526b",
                            bodyColor: "#fff",
                            borderColor: "rgba(255,48,79,.35)",
                            borderWidth: 1,
                            padding: 12,
                            callbacks: {
                                label: function(context) {
                                    return " Doanh thu: " +
                                        new Intl.NumberFormat("vi-VN", {
                                            style: "currency",
                                            currency: "VND",
                                            maximumFractionDigits: 0
                                        }).format(context.parsed.y || 0);
                                }
                            }
                        }
                    }
                }
            });
        }
    });
</script>