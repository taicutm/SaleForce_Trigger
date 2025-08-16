// 4. Before Update – Copy giá trị
// Khi update Phone của Account → tự động copy sang Fax.
trigger bai4 on Account (before update) {
    for (Account acc : Trigger.new) {
        acc.Fax = acc.Phone;
    }
}
// test 1 :

// Tìm Account có Name là 'Long Nguyễn'
// Account acc = [SELECT Id, Name, Phone FROM Account WHERE Name = 'Long Nguyễn' LIMIT 1];
// // Cập nhật trường Phone
// acc.Phone = '123456789';
// update acc;