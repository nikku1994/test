public class InterviewController {
 @AuraEnabled(cacheable=true)
    public static List<Interview__c> getInterviewDetails()

    {
    User username = [SELECT id,contactId FROM User WHERE id = :UserInfo.getUserId()]; 
       String queryConst;
        if(UserInfo.getProfileId()==System.label.panelProfileId)
        {
             //system.debug(UserInfo.getProfileId());
            //queryConst='and Panel_Member_Email__c =:UserInfo.getUserEmail()';
              queryConst=UserInfo.getUserEmail();
        }
        else
        {
            queryConst='%@ust-global.com';
        }
         system.debug(UserInfo.getProfileId());
        
           List<Interview__c>  allInterviews = [select Name,Candidate_Name__c,Candidate_Role__c,Interview_Date__c,Interview_Status__c,
                                            InterviewTimeDisplay__c,InterviewPanelName__c
                                            from Interview__c 
                                            where Interview_Status__c='Accepted' and Interview_Date__c>= today and Panel_Member_Email__c Like :queryConst ORDER BY Name];
       
        system.debug(allInterviews);
        if(allInterviews.size()>0)
        {
            return allInterviews;
        }
        else
        {
            return null;
        }
}
    @AuraEnabled(cacheable=true)
    public static List<InterviewPanel__c> getPanelDetails()
    {       
        system.debug('enteringg');
        List<InterviewPanel__c>  panel = [select id, name, Panel_Member_Location__c, Panel_Member_Mail_Id__c, Panel_Member_UID__c, Total_Interviews_Taken__c, 
                                             TotalPointsEarned__c from InterviewPanel__c where Panel_Member_Mail_Id__c Like :UserInfo.getUserEmail()];
		system.debug(UserInfo.getUserEmail());
        if(panel.size()>0)
        {
            system.debug(panel);
            system.debug('panelcheck');
            system.debug(panel[0].name);
            return panel;
        }
        else
        {
            return null;
        } 
    }
    @AuraEnabled(cacheable=true)
    public static List<Interview__c> getpendingfeedbackDetails()

    {
    User username = [SELECT id,contactId FROM User WHERE id = :UserInfo.getUserId()]; 
       String queryConst;
        if(UserInfo.getProfileId()=='00e63000000MxavAAC')
        {
             //system.debug(UserInfo.getProfileId());
            //queryConst='and Panel_Member_Email__c =:UserInfo.getUserEmail()';
              queryConst=UserInfo.getUserEmail();
        }
        else
        {
            queryConst='%@ust-global.com';
        }
         system.debug(UserInfo.getProfileId());        
           List<Interview__c>  allInterviews = [select Name,Candidate_Name__c,Candidate_Role__c,Interview_Date__c,Interview_Status__c,
                                            InterviewTimeDisplay__c,InterviewPanelName__c
                                            from Interview__c 
                                            where Interview_Date__c<today and Interview_Status__c = 'Accepted' and Panel_Member_Email__c Like :queryConst and (Id not In (SELECT Interview_ID__c FROM Candidate_Feedback__c where Mark_feedback_as_Draft__c = false)) ORDER BY Name];
       
        system.debug(allInterviews);
        if(allInterviews.size()>0)
        {
            system.debug(allInterviews);
            return allInterviews;
        }
        else
        {
            return null;
        }
}
}