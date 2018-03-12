@isTest(SeeAllData=true)
public class ApexTestAllDataTrue {
   public static testMethod void testSomething() {
       String temp = '12.4567';
	   Decimal myDecimal = Decimal.valueOf(temp);
	   system.debug('test');
   }
}
