// 7. Bulk Insert – Đếm số Account cùng Industry
// Khi insert nhiều Account cùng lúc → kiểm tra: Nếu trong DB đã có > 5 Account cùng Industry → chặn insert.
trigger bai7 on Account (before insert) {
  for (Account acc : Trigger.new) {
      Integer count = [SELECT COUNT() FROM Account WHERE Industry = :acc.Industry];
      if (count > 5) {
          acc.addError('Không thể thêm Account mới vì đã có hơn 5 Account cùng Industry.');
          system.debug('Không thể thêm Account mới vì đã có hơn 5 Account cùng Industry: ' + acc.Industry);
      }
  }

}

// hàm test
// Account acc = new Account(Name='Tôn Kiên',Industry='Technology');
// insert acc;