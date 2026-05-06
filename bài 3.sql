/*
1. Xác định dữ liệu đầu vào / đầu ra
Input
p_total_cost (DECIMAL): Tổng chi phí
p_patient_type (VARCHAR): Diện bệnh nhân (BHYT, VIP, THUONG)
Output
p_final_amount (DECIMAL): Số tiền phải thu
p_message (VARCHAR): Thông báo trạng thái
Loại tham số
IN: nhận dữ liệu đầu vào
OUT: trả kết quả

Kết luận: sử dụng IN và OUT để vừa nhận dữ liệu vừa trả kết quả

2. Giải pháp
Logic xử lý
Nếu tổng chi phí < 0
- trả về 0 và thông báo "Lỗi: Chi phí không hợp lệ"
Nếu hợp lệ:
BHYT: thanh toán 20%
VIP: giảm 10%
THUONG: thanh toán 100%

Sau khi tính xong trả thông báo: "Đã tính toán xong"

3. Các bước thực hiện
B1 Xóa procedure cũ
B2 Tạo procedure mới
B3 Kiểm tra dữ liệu đầu vào
B4 Xử lý theo từng loại bệnh nhân
B5 Trả kết quả ra ngoài

4. Kiểm thử
Trường hợp BHYT
Trường hợp VIP
Trường hợp THUONG
Trường hợp lỗi (chi phí âm)
*/

DELIMITER //

CREATE PROCEDURE CalculateDischargeCost(
    IN p_total_cost DECIMAL(10,2),
    IN p_patient_type VARCHAR(10),
    OUT p_final_amount DECIMAL(10,2),
    OUT p_message VARCHAR(255)
)
BEGIN
    -- Kiểm tra dữ liệu âm
    IF p_total_cost < 0 THEN
        SET p_final_amount = 0;
        SET p_message = 'Lỗi: Chi phí không hợp lệ';
    ELSE
        -- Tính toán theo diện bệnh nhân
        IF p_patient_type = 'BHYT' THEN
            SET p_final_amount = p_total_cost * 0.2;
        ELSEIF p_patient_type = 'VIP' THEN
            SET p_final_amount = p_total_cost * 0.9;
        ELSEIF p_patient_type = 'THUONG' THEN
            SET p_final_amount = p_total_cost;
        ELSE
            SET p_final_amount = p_total_cost;
        END IF;

        SET p_message = 'Đã tính toán xong';
    END IF;
END //

DELIMITER ;