/**
 * File Name: sflib_CaseTeamRelatedListController 
 * Description: 
 * Copyright (c) 2018 Johnson & Johnson
 * @author: architect ir. William G.J. Velzeboer | wvelzebo@its.jnj.com 
 * 
 * Modification Log 
 * =============================================================== 
 * Ver  |Date        |Author                |Modification 
 * 1.0  | 15/01/2018 |wvelzebo@its.jnj.com  |   
 */
public with sharing class sflib_CaseTeamRelatedListController
{

	@AuraEnabled
	public static list<CaseTeamDataResult> getCaseTeamData(Id caseRecordId)
	{
		List<CaseTeamMember> caseTeamMembers =
				((sflib_CaseTeamMemberSelector) sflib_Application.Selector.newInstance(CaseTeamMember.SObjectType))
						.selectByParentId(new Set<Id>
				{
						caseRecordId
				});

		List<CaseTeamDataResult> results = new List<CaseTeamDataResult>();
		for (CaseTeamMember caseTeamMember : caseTeamMembers)
		{
			results.add(new CaseTeamDataResult(caseTeamMember));
		}
		return results;
	}


	@AuraEnabled
	public static Boolean isUpdateable(Id caseRecordId)
	{
		List<UserRecordAccess> access = [
				SELECT RecordId, HasEditAccess
				FROM UserRecordAccess
				WHERE UserId = :UserInfo.getUserId() AND RecordId = :caseRecordId
		];
		return (!access.isEmpty() && access.get(0).HasEditAccess);
	}

	@AuraEnabled
	public static string removeCaseTeamMembers(List<String> caseTeamMemberIds)
	{
		fflib_ISObjectUnitOfWork uow = sflib_Application.UnitOfWork.newInstance();

		for (Id memberId : caseTeamMemberIds)
		{
			uow.registerDeleted(new CaseTeamMember(Id = (Id) memberId));
		}
		try
		{
			uow.commitWork();
		}
		catch (Exception e)
		{
			return 'ERROR - ' + e.getMessage();
		}
		return 'SUCCESS';
	}


	public class CaseTeamDataResult
	{
		@AuraEnabled public Id caseTeamMemberId;
		@AuraEnabled public String MemberName;
		@AuraEnabled public String RoleName;
		@AuraEnabled public String AccessType;
		@AuraEnabled public String LastModifiedBy;
		@AuraEnabled public DateTime LastModifiedDate;

		public CaseTeamDataResult(CaseTeamMember caseTeamMember)
		{
			this.caseTeamMemberId = caseTeamMember.Id;
			this.MemberName = caseTeamMember.Member.Name;
			this.RoleName = caseTeamMember.TeamRole.Name;
			this.AccessType = caseTeamMember.TeamRole.AccessLevel;
			this.LastModifiedBy = caseTeamMember.LastModifiedBy.Name;
			this.LastModifiedDate = caseTeamMember.LastModifiedDate;
		}
	}


	public class CaseTeamRelatedListControllerException extends Exception
	{
	}
}