// After Update – Cập nhật dữ liệu liên quan (SOQL + DML)
// Khi Account.Name thay đổi → update tất cả Contact liên quan: Contact.Description = "Updated because Account name changed".
trigger bai5 on Account (after update) {
    Set<Id> accountIds = new Set<Id>();
    for (Account acc : Trigger.new) {
        if (acc.Name != Trigger.oldMap.get(acc.Id).Name) {
            accountIds.add(acc.Id);
        }
    }
    if (!accountIds.isEmpty()) {
        List<Contact> contactsToUpdate = [SELECT Id, Description FROM Contact WHERE AccountId IN :accountIds];
        for (Contact con : contactsToUpdate) {
            con.Description = 'Updated because Account name changed';
        }
        system.debug('Đã cập nhật ' + contactsToUpdate.size() + ' Contact liên quan.' + ' - ' + contactsToUpdate);

        update contactsToUpdate;
    }
}


// Test trigger bai5: Khi Account.Name thay đổi thì tất cả Contact liên quan sẽ được update Description

// 1. Tạo Account và Contact liên quan
// Account acc = new Account(Name = 'Test Bai5');
// insert acc;

// Contact con1 = new Contact(FirstName = 'A', LastName = 'Test', AccountId = acc.Id);
// Contact con2 = new Contact(FirstName = 'B', LastName = 'Test', AccountId = acc.Id);
// insert new List<Contact>{con1, con2};

// // 2. Đổi tên Account để trigger chạy
// acc.Name = 'Test Bai5 Updated';
// update acc;

// // 3. Query lại các Contact để kiểm tra Description đã được update chưa
// List<Contact> contacts = [SELECT Id, Description FROM Contact WHERE AccountId = :acc.Id];
// for (Contact c : contacts) {
//     System.debug('Contact ' + c.Id + ' Description: ' + c.Description);
// }

