global with sharing class apiIntegration {

    @future (callout=true) 
	global static void getAndParse() { 
        
		List<String> accountIdList = new List<String>();
		List<String> typeFormId = new List<string>();
		List<sObject> typeformsList = new List<sObject>();
        List<Typeform__c> newTypeformsList = new List<Typeform__c>();
		ApexDeserializeJSON.ApexDeserializeJSONs allJsonForms = new ApexDeserializeJSON.ApexDeserializeJSONs();
		
		//Start Callout 1
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://api.typeform.com/v1/forms?key=eb7651b1de737d82dd1b96d1024eec32d808dc6c&completed=true');
		request.setMethod('GET');
		HttpResponse response = http.send(request);
		
		List<JSON2ApexALLTypeforms.JSON2ApexALLTypeform> jsonFormsID = JSON2ApexALLTypeforms.parse(response.getBody());
		for(JSON2ApexALLTypeforms.JSON2ApexALLTypeform form : jsonFormsID){
			typeFormId.add(form.id);
		}
		for(string formId : typeFormId){
			
			//Start Callout 2
			Http http2 = new Http();
			HttpRequest request2 = new HttpRequest();
			request2.setEndpoint('https://api.typeform.com/v1/form/'+formId+'?key=eb7651b1de737d82dd1b96d1024eec32d808dc6c&completed=true');
			request2.setMethod('GET');
			HttpResponse response2 = http2.send(request2);
 
			if (response2.getStatusCode() == 200) {
    			allJsonForms = ApexDeserializeJSON.parse(response2.getBody());
    			for(ApexDeserializeJSON.Responses_Z r : allJsonForms.responses){
					//Get Id Account from URL
        			String accountId = r.metadata.referer.substringAfter('uid=');
                    accountIdList.add(accountId);
    			}
			}

			List<Account> accList = new List<Account>();
			try{
 				accList = [Select id, name from Account where id IN : accountIdList];
			}catch(exception e){
    			accList = null;
			}
			if(accList != null){
    			for(Account a : accList){
        			String aId = a.id;
                    String accID = aId.substring(0,aId.length()-3);
        				for(String accIdTypeform : accountIdList){
            				if(accID==accIdTypeform){
              					
								String SobjectApiName = 'Typeform__c';
								Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
                                Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
                                String commaSepratedFields = '';
                                for(String fieldName : fieldMap.keyset()){
                                    if(commaSepratedFields == null || commaSepratedFields == ''){
                                        commaSepratedFields = fieldName;
                                    }else{
                                        commaSepratedFields = commaSepratedFields + ', ' + fieldName;
                                    }
        						}
 								system.debug('***: '+aId);
                              String  query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' WHERE Account__c = :aId  AND Form_ID__c =:formId';
                             
                              	typeformsList = Database.query(query);
                              
                                system.debug('***: '+typeformsList);
                			  if(typeformsList==null ||typeformsList.size()==0){
                              	Typeform__c type = new Typeform__c();
                                 
                                 type.Account__c = accIdTypeform;
                                 type.Form_ID__c = formId;
                                 newTypeformsList.add(type);
                                 
                			  }
								
        					}
    					}
					}
				}
			}
        	if(newTypeformsList!=null){
            	insert newTypeformsList;
        	}


    	}
	
}