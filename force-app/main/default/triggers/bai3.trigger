//  After Insert – Tạo dữ liệu liên quan
// Sau khi tạo Account → tự động tạo 1 Contact mặc định:
// FirstName = "Default",
// LastName = "Contact".
trigger bai3 on Account (after insert) {
    List<Contact> contactsToInsert = new List<Contact>();
    for (Account acc : Trigger.new) {
        contactsToInsert.add(new Contact(
            FirstName = 'Default',
            LastName = 'Contact',
            AccountId = acc.Id
        ));
    }
    insert contactsToInsert;
}