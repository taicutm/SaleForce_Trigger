//  Before Delete – Ngăn xóa
// Không cho phép xóa Account nếu có Opportunities đang ở stage "Prospecting".
trigger bai6 on Account (before delete) {
    Set<Id> accountIds = new Set<Id>();
    for (Account acc : Trigger.old) {
        accountIds.add(acc.Id);
    }
    if (!accountIds.isEmpty()) {
        List<Opportunity> opportunities = [SELECT Id, StageName FROM Opportunity WHERE AccountId IN :accountIds];
        for (Opportunity opp : opportunities) {
            if (opp.StageName == 'Prospecting') {
                opp.addError('Không thể xóa Account này vì có Opportunity đang ở stage "Prospecting".');
                system.debug('Không thể xóa Account này vì có Opportunity đang ở stage "Prospecting".');
            }
        }

    }
}