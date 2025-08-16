//2. Before Insert/Update – Validation
// Nếu AnnualRevenue < 0 → throw error "Annual Revenue cannot be negative".
trigger bai2 on Account (before insert, before update) {
    for (Account acc : Trigger.new) {
        if (acc.AnnualRevenue < 0) {
            acc.addError('Annual Revenue phải lớn hơn 0 ');
        }
    }
}
// test 1
//Account acc = new Account (Name ='Phong Lâm2',AnnualRevenue=1);
//insert acc;
//
//test2
//// Tạo Account hợp lệ
//Account acc = new Account(Name = 'Hoả Sơn', AnnualRevenue = 1000);
//insert acc;

// Update AnnualRevenue thành giá trị không hợp lệ để trigger chạy
//acc.AnnualRevenue = -500;
//update acc;