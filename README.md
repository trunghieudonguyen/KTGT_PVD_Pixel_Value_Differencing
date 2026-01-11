# Giấu tin bằng phương pháp PVD trong miền không gian (MATLAB)

## 1. Giới thiệu
Dự án này triển khai kỹ thuật **giấu tin bằng phương pháp Pixel Value Differencing (PVD)** trong **miền không gian (Spatial Domain)** sử dụng MATLAB.  
Thông điệp bí mật được nhúng trực tiếp vào giá trị pixel của ảnh **không thực hiện chuyển đổi hệ màu**, đảm bảo ảnh gốc và ảnh giấu tin nằm trong **cùng miền ảnh**.

Dự án hỗ trợ **thông điệp tiếng Việt có dấu (UTF-8)** và đảm bảo ảnh stego **giữ nguyên màu sắc và định dạng** so với ảnh gốc.

---

## 2. Nguyên lý Pixel Value Differencing (PVD)
Phương pháp PVD dựa trên độ chênh lệch giá trị của một cặp pixel liền kề:

- Độ chênh lệch nhỏ → giấu ít bit (vùng trơn)
- Độ chênh lệch lớn → giấu nhiều bit (vùng biên)

Cách tiếp cận này giúp:
- Tăng dung lượng giấu tin
- Hạn chế biến dạng ảnh
- Khó bị phát hiện bằng mắt thường

---

## 3. Đặc điểm kỹ thuật
- **Phương pháp**: Pixel Value Differencing (PVD)
- **Miền xử lý**: Miền không gian (Spatial Domain)
- **Chuyển hệ màu**: Không
- **Kiểu dữ liệu ảnh**: `uint8`
- **Loại ảnh**: Ảnh RGB
- **Kênh giấu tin**: Kênh B (Blue)
- **Mã hóa thông điệp**: UTF-8

---

## 4. Cấu trúc thư mục
```text
PVD_Matlab_Project/
│
├── create_stego.m        % Tạo ảnh giấu tin
├── extract_message.m    % Trích xuất thông điệp
│
├── src/
│   ├── embed_pvd.m          % Hàm giấu tin PVD
│   └── extract_pvd.m        % Hàm trích xuất PVD
│
└── images/
    ├── lenna.png            % Ảnh gốc
    └── stego.png            % Ảnh đã giấu tin
```

---

## 5. Hướng dẫn sử dụng

### 5.1. Tạo ảnh giấu tin
Chạy script sau trong MATLAB:
```matlab
create_stego.m
```

Sau khi chạy:
- Ảnh stego sẽ được lưu tại `images/stego.png`
- Thông báo `Embedding completed.` sẽ hiển thị nếu thành công

### 5.2. Trích xuất thông điệp
Chạy script:
```matlab
extract_message.m
```

Thông điệp trích xuất sẽ được hiển thị trực tiếp trên cửa sổ lệnh MATLAB.

---

## 6. Yêu cầu môi trường
- MATLAB R2018a hoặc mới hơn
- Ảnh đầu vào định dạng PNG/JPG
- Ảnh RGB 8-bit

---

## 7. Ghi chú
- Dung lượng thông điệp phụ thuộc vào đặc điểm ảnh (vùng trơn/biên)
- Nên sử dụng ảnh có nhiều chi tiết để tăng khả năng giấu tin
- Không chỉnh sửa ảnh stego sau khi giấu tin để tránh mất dữ liệu

---

## 8. Thông tin bài tập
**Bài tập được thực hiện bởi:**  
- Đỗ Tiến Dũng  
- Đỗ Nguyễn Trung Hiếu  
- Võ Trung Hiếu
