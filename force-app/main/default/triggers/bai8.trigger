//  Recursion Control
// Nếu Account.Rating = "Hot" → set AnnualRevenue = 1,000,000.
// Nhưng trigger phải chống chạy lặp vô hạn (recursion).
trigger bai8 on Account (before insert , before update) {
  for (Account acc : Trigger.new ) {
      if (acc.Rating == 'Hot') {
          acc.AnnualRevenue = 1000000;
          System.debug('Đã thiết lập AnnualRevenue = 1,000,000 cho Account: ' + acc.Id);
      }
  }
  // Kiểm tra recursion
  if (Trigger.isBefore && Trigger.isInsert) {
      for (Account acc : Trigger.new) {
          if (acc.Rating == 'Hot' && acc.AnnualRevenue == 1000000) {
              acc.addError('Không thể thiết lập AnnualRevenue = 1,000,000 vì đã có trigger chạy trước đó.');
              System.debug('Không thể thiết lập AnnualRevenue = 1,000,000 vì đã có trigger chạy trước đó cho Account: ' + acc.Id);
          }
      }
  }


}