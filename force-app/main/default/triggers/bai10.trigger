// 10. Complex Case – Rollup thủ công (aggregate)
// Khi Insert/Update/Delete Contact → tính lại tổng số Contact active của từng Account.
// Lưu kết quả vào field custom Number_of_Contacts__c trên Account.
// Bài này kết hợp: SOQL, DML, Map, Set, Aggregate, Bulk Handling.
trigger bai10 on Contact (after insert,after update , after delete,after undelete) {
   Set<Id> accountIds = new Set<Id>();

    // Lấy AccountId từ record mới
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for(Contact con : Trigger.new) {
            if(con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }

    // Lấy AccountId từ record cũ
    if(Trigger.isUpdate || Trigger.isDelete) {
        for(Contact con : Trigger.old) {
            if(con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }

    if(accountIds.isEmpty()) return;

    // Đếm tất cả Contact
    Map<Id, Integer> accIdToCount = new Map<Id, Integer>();
    for(AggregateResult ar : [
        SELECT AccountId accId, COUNT(Id) cnt
        FROM Contact
        WHERE AccountId IN :accountIds
        GROUP BY AccountId
    ]) {
        accIdToCount.put((Id)ar.get('accId'), (Integer)ar.get('cnt'));
    }

    // Update Account
    List<Account> accountsToUpdate = new List<Account>();
    for(Id accId : accountIds) {
        Integer count = accIdToCount.containsKey(accId) ? accIdToCount.get(accId) : 0;
        accountsToUpdate.add(new Account(
            Id = accId,
            Number_of_Contacts__c = count
        ));
    }

    update accountsToUpdate;

}