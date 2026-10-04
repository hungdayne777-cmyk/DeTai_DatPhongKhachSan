<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    request.setAttribute("formatter", formatter);
%>

<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-4">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
            <h3 class="text-dark fw-bold mb-0">
                <i class="fas fa-envelope text-primary me-2"></i> Quản Lý Liên Hệ
            </h3>
        </div>

        <!-- Notification -->
        <c:if test="${not empty sessionScope.message}">
            <c:set var="isError" value="${sessionScope.message.contains('thất bại') || sessionScope.message.contains('Xóa thất bại')}" />
            <div class="alert ${isError ? 'alert-danger' : 'alert-success'} alert-dismissible fade show shadow-sm mb-4" role="alert">
                <i class="fas ${isError ? 'fa-exclamation-triangle' : 'fa-check-circle'} me-2"></i> 
                ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>

        <!-- Form tìm kiếm -->
        <form action="${pageContext.request.contextPath}/admin/lien-he" method="GET" class="row g-3 align-items-center mb-3">
            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                    <input type="text" class="form-control" name="keyword" value="${param.keyword}" placeholder="Nhập tên hoặc email người gửi...">
                </div>
            </div>
            <div class="col-md-3">
                <button type="submit" class="btn btn-dark"><i class="fas fa-filter"></i> Tìm kiếm</button>
                <a href="${pageContext.request.contextPath}/admin/lien-he" class="btn btn-secondary" title="Làm mới"><i class="fas fa-sync-alt"></i></a>
            </div>
        </form>

        <!-- Table -->
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th class="py-3">MÃ LH</th>
                        <th class="py-3">HỌ TÊN</th>
                        <th class="py-3">EMAIL</th>
                        <th class="py-3">SỐ ĐIỆN THOẠI</th>
                        <th class="py-3">NỘI DUNG</th>
                        <th class="py-3">NGÀY GỬI</th>
                        
                        <th class="py-3 text-center">HÀNH ĐỘNG</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="lh" items="${listLienHe}">
                        <tr>
                            <td class="fw-bold text-primary">${lh.maLH}</td>
                            <td class="fw-semibold">${lh.hoTen}</td>
                            <td>${lh.email}</td>
                            <td>${lh.sdt}</td>
                            <td style="max-width: 250px;" class="text-truncate" title="${lh.noiDung}">
                                ${lh.noiDung}
                            </td>
                            <td>
                                <c:if test="${lh.ngayGui != null}">
                                    ${lh.ngayGui.format(formatter)}
                                </c:if>
                            </td>
                          
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/xoa-lien-he?id=${lh.maLH}" 
                                   class="btn btn-danger btn-sm fw-bold px-2" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa tin nhắn của khách hàng ${lh.hoTen}?');">
                                    <i class="fas fa-trash-alt"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listLienHe}">
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">Không có tin nhắn liên hệ nào trong hệ thống.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>