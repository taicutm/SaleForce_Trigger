# 🚀 10 Bài tập Trigger với Object Account

Tài liệu này tổng hợp các bài tập luyện tập **Apex Trigger trong Salesforce** với Object **Account**, từ cơ bản đến nâng cao.
Mục tiêu: nắm vững cú pháp Trigger, xử lý **Before/After**, kiểm soát **bulk**, recursion, và các tình huống thực tế.

---

## 📘 Level 1 – Dễ (Cơ bản)

### 1. Before Insert – Gán giá trị mặc định
- Khi tạo mới Account, nếu field **Industry** để trống → tự động gán = `"Technology"`.

### 2. Before Insert/Update – Validation
- Nếu **AnnualRevenue < 0** → throw error `"Annual Revenue cannot be negative"`.

### 3. After Insert – Tạo dữ liệu liên quan
- Sau khi tạo Account → tự động tạo 1 Contact mặc định:
  - `FirstName = "Default"`,
  - `LastName = "Contact"`.

---

## 📗 Level 2 – Trung bình (Có điều kiện, bulk)

### 4. Before Update – Copy giá trị
- Khi update **Phone** của Account → tự động copy sang **Fax**.

### 5. After Update – Cập nhật dữ liệu liên quan (SOQL + DML)
- Khi **Account.Name** thay đổi → update tất cả Contact liên quan:
  `Contact.Description = "Updated because Account name changed"`.

### 6. Before Delete – Ngăn xóa
- Không cho phép xóa Account nếu có **Opportunities** đang ở stage `"Prospecting"`.

---

## 📕 Level 3 – Khó (Bulk, recursion, undelete)

### 7. Bulk Insert – Đếm số Account cùng Industry
- Khi insert nhiều Account cùng lúc → kiểm tra:
  Nếu trong DB đã có **> 5 Account cùng Industry** → chặn insert.

### 8. Recursion Control
- Nếu `Account.Rating = "Hot"` → set `AnnualRevenue = 1,000,000`.
- Nhưng trigger phải **chống chạy lặp vô hạn** (recursion).

### 9. After Undelete
- Khi khôi phục Account từ Recycle Bin → tạo **Task** với:
  - `Subject = "Follow up restored account"`,
  - `Owner = Account.Owner`.

### 10. Complex Case – Rollup thủ công (aggregate)
- Khi Insert/Update/Delete Contact → tính lại tổng số Contact **active** của từng Account.
- Lưu kết quả vào field custom `Number_of_Contacts__c` trên Account.
- Bài này kết hợp: **SOQL, DML, Map, Set, Aggregate, Bulk Handling**.

---

## 🎯 Lộ trình luyện tập
1. Bắt đầu từ **Level 1** để nắm rõ Before/After.
2. Sang **Level 2** để rèn kỹ năng bulk + liên kết dữ liệu.
3. Cuối cùng luyện **Level 3** để quen recursion, undelete, và rollup aggregate.

---

✍️ Ghi chú:
- Nên viết **Test Class** cho từng bài.
- Dùng `System.debug()` để theo dõi luồng chạy.
- Chú ý xử lý **bulk-safe** (không query hay DML trong vòng lặp).

