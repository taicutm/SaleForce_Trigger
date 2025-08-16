//Before Insert – Gán giá trị mặc định , Khi tạo mới Account, nếu field Industry để trống → tự động gán = "Technology".
trigger bai1 on Account (before insert) {
    for (Account acc: Trigger.new){
      if(acc.Industry == null || acc.Industry == '') {
          acc.Industry = 'Technology';
          System.debug('Industry field is set to default value: ' + acc.Industry);
      }
    }
}