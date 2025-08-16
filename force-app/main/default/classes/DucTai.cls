public class DucTai {
  // thuộc tính
  public String name;
  public Integer age;
  // constructor
  public DucTai(String name, Integer age) {
    this.name = name;
    this.age = age;
  }
  // phương thức
  public void introduce() {
    System.debug('Xin chào, tôi tên là ' + name + ', ' + age + ' tuổi.');
  }

}