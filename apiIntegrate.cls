@RestResource(urlMapping='/v1/')
global with sharing class apiIntegrate {

@HttpPost	
global static void createNewTypeforms(String question, String answer) {
    
     Typeform__c type = new Typeform__c();
     type.name = question;
     type.answer__c = answer;
     insert type;
}
    
}