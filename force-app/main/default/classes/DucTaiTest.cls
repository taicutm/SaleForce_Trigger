@isTest
public with sharing class DucTaiTest {
    @isTest
    static void testAgeInFuture() {
        DucTai ducTai = new DucTai('Duc Tai', 23);
        ducTai.introduce();
    }
}