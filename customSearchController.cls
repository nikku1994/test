public class customSearchController  {
    @AuraEnabled(cacheable=true)
    public static list<Panel_Member_Availability__c> getContactList(string searchKey,string searchKeydes) {
        system.debug('pos:'+searchKey);
        system.debug('pos:'+searchKeydes);
        string sTempSearchKey = '%' + searchKey + '%';
        string sTempSearchKeydes = '%' + searchKeydes + '%';
        Date dateToMeasure = date.newinstance(2006,01,01);
        Integer weeknumfortoday = math.mod(Integer.valueOf(dateToMeasure.daysBetween(system.today())/7),52)-1;
        // create panle member list to store search result
        list<Panel_Member_Availability__c> IntvwPanellst = new list<Panel_Member_Availability__c>();
        
        // query panel memberavailabilty records
        if(sTempSearchKey != '' && sTempSearchKeydes != ''){
            for(Panel_Member_Availability__c oCon : [Select Designation__c,DayTime_of_Availability__c,PanelMemberName__c,Week__c,WeekDisplay__c,Panel_Member_Name__c,Scheduled_Time__c,Time_zone__c
                                                     From Panel_Member_Availability__c
                                                     WHERE (Position_Panel_Member_Can_Hire__c LIKE : sTempSearchKeydes)
                                                     and (PanelMemberName__c LIKE : sTempSearchKey)  and (Week__c>=:weeknumfortoday)]){
                                                         IntvwPanellst.add(oCon);
                                                     }
        }
        if(sTempSearchKey != '' && sTempSearchKeydes == ''){
            for(Panel_Member_Availability__c oCon : [Select Designation__c,DayTime_of_Availability__c,PanelMemberName__c,Week__c,WeekDisplay__c,Panel_Member_Name__c,Scheduled_Time__c,Time_zone__c
                                                     From Panel_Member_Availability__c
                                                     WHERE (PanelMemberName__c LIKE : sTempSearchKey)  and (Week__c>=:weeknumfortoday)]){
                                                         IntvwPanellst.add(oCon);
                                                     }
        }
        if(sTempSearchKey == '' && sTempSearchKeydes != ''){
            for(Panel_Member_Availability__c oCon : [Select Designation__c,DayTime_of_Availability__c,PanelMemberName__c,Week__c,WeekDisplay__c,Panel_Member_Name__c,Scheduled_Time__c,Time_zone__c
                                                     From Panel_Member_Availability__c
                                                     WHERE (Position_Panel_Member_Can_Hire__c LIKE : sTempSearchKeydes)
                                                     and (Week__c>=:weeknumfortoday)]){
                                                         IntvwPanellst.add(oCon);
                                                     }
        }
                           
        //If there are no records found with searchKey then, throw aura exception with a message
        if(IntvwPanellst.size() == 0){
            throw new AuraHandledException('No Availability found for the given search key');
        }
        system.debug(IntvwPanellst);
        return IntvwPanellst;
        
    }
     @AuraEnabled(cacheable=true)
    public static integer getWeekList(){
        system.debug('Entered');
        Date dateToMeasure = date.newinstance(2006,01,01);
        Integer weeknumfortoday = math.mod(Integer.valueOf(dateToMeasure.daysBetween(system.today())/7),52)-1;
        system.debug('Week'+weeknumfortoday);
        return weeknumfortoday;
        }
}