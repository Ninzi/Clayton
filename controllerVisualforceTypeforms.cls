public with sharing class controllerVisualforceTypeforms {
    
    private ApexPages.StandardController stdController;
    private final Account acc;
    public List<Typeform__c> types { get; set; }

    public controllerVisualforceTypeforms(ApexPages.StandardController stdController) {
        
        this.acc = (Account)stdController.getRecord();
        this.stdController = stdController;
        getTypes();
      
        
    }
    
    public List<Typeform__c> getTypes(){
      return types =  [Select name, Account__c,answer__c from Typeform__c where Account__c =: acc.Id];
    }
    
   
    

}