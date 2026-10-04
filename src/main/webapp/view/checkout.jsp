<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
   <head>
      <!-- basic -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Xác Nhận Đặt Cọc Phòng</title>
      
      <!-- CSS templates -->
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

      <style>
     
         body.main-layout.inner_page {
            background: url('${pageContext.request.contextPath}/images/hotel-bg.jpg') no-repeat center center fixed !important;
            background-size: cover !important;
            position: relative;
            min-height: 100vh;
            overflow-x: hidden;
         }

    
         body.main-layout.inner_page::before {
            content: "";
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: -1;
         }

         .back_re { display: none !important; }

        
         .checkout-container {
            min-height: 90vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 0;
         }

    
         .glass-checkout-card {
            position: relative;
            width: 100%;
            max-width: 550px;
            padding: 35px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            color: #fff;
         }

         .glass-checkout-card h3 {
            font-weight: 700;
            font-size: 24px;
            margin-bottom: 10px;
            color: #fff;
            text-align: center;
         }

         .glass-checkout-card p.subtitle {
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 25px;
         }

       
         .info-box {
            background: rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
         }

         .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 15px;
         }

         .info-row:last-child {
            margin-bottom: 0;
         }

         .info-row span:text-muted {
            color: rgba(255, 255, 255, 0.6);
         }

         .info-row strong {
            color: #ffb74d; 
         }

        
         .qr-section {
            text-align: center;
            background: #fff;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            color: #333;
         }

         .qr-section img {
            max-width: 220px;
            height: auto;
            border-radius: 8px;
         }

         .qr-section .transfer-syntax {
            margin-top: 12px;
            font-size: 14px;
            color: #d32f2f;
            font-weight: 600;
         }

     
         .btn-finish {
            background: linear-gradient(135deg, #7c3aed, #3b82f6);
            border: none;
            color: #fff;
            width: 100%;
            padding: 14px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            display: block;
            text-decoration: none;
         }

         .btn-finish:hover {
            opacity: 0.9;
            box-shadow: 0 0 15px rgba(59, 130, 246, 0.5);
            color: #fff;
            text-decoration: none;
         }
      </style>
   </head>
   <body class="main-layout inner_page">

     <div class="container">
   <div class="checkout-container">
      <div class="glass-checkout-card">
         
         <h3>Xác Nhận Đặt Cọc Giữ Phòng</h3>
         <p class="subtitle">Vui lòng quét mã QR bên dưới để thanh toán tiền cọc</p>

         <div class="info-box">
            <div class="info-row">
               <span>Mã phòng:</span>
               <strong>${roomName != null ? roomName : "Phòng 101"}</strong>
            </div>
            <div class="info-row">
               <span>Tổng tiền phòng:</span>
               <span>${totalPrice != null ? totalPrice : "5,000,000"} VNĐ</span>
            </div>
            <div class="info-row" style="font-size: 17px; border-top: 1px dashed rgba(255,255,255,0.2); padding-top: 8px; margin-top: 8px;">
               <span>Số tiền cọc cần trả (30%):</span>
               <strong style="color: #4ade80;">${depositAmount != null ? depositAmount : "1,500,000"} VNĐ</strong>
            </div>
         </div>

         <div class="qr-section">
            <img src="https://img.vietqr.io/image/VCB-1046103431-compact2.png?amount=1500000&addInfo=DATPHONG%20P101&accountName=NGUYEN%20THAI%20HUNG" alt="Mã QR VietQR">
            
            <div class="transfer-syntax">
               Nội dung chuyển khoản: <span style="background: #eee; padding: 2px 6px; border-radius: 4px; color: #d32f2f;">DATPHONG P101</span>
            </div>
         </div>

         <p style="font-size: 13px; color: rgba(255,255,255,0.6); text-align: center; margin-bottom: 20px;">
            <i>Lưu ý: Hệ thống sẽ tự động cập nhật trạng thái sau khi nhân viên kiểm tra và xác nhận giao dịch của bạn.</i>
         </p>

         <a href="${pageContext.request.contextPath}/confirmPayment" style="display: block; width: 100%; box-sizing: border-box; text-align: center; background-color: #10b981; color: white; padding: 12px; border-radius: 8px; text-decoration: none; font-weight: bold; margin-bottom: 12px;">Xác nhận đã chuyển khoản</a>

         <a href="${pageContext.request.contextPath}/index.jsp" class="btn-finish">Hoàn tất & Về trang chủ</a>

      </div>
   </div>
</div>

   </body>
</html>