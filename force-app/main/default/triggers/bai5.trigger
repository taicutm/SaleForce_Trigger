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