public class controllerVisualforceAccount {

	List<Account> accounts;

	public List<Account> getAccounts() {
		accounts = [SELECT Name,phone FROM Account where phone =: null];
		return accounts;
	}

}