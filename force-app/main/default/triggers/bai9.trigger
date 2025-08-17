
//  After Undelete
// Khi khôi phục Account từ Recycle Bin → tạo Task với:
// Subject = "Follow up restored account",
// Owner = Account.Owner.
trigger bai9 on Account (after undelete) {
  List<Task> tasksToInsert = new List<Task>();
    for (Account acc : Trigger.new) {
        Task newTask = new Task();
        newTask.Subject = 'Follow up restored account';
        newTask.OwnerId = acc.OwnerId;
            newTask.WhatId = acc.Id;
        tasksToInsert.add(newTask);
    }
    insert tasksToInsert;
    for (Account acc : Trigger.new) {
        System.debug('Đã tạo Task cho Account: ' + acc.Id);
    }
}


