/**
 * File Name: sflib_CaseTeamAddMemberController 
 * Description: 
 * Copyright (c) 2018 Johnson & Johnson
 * @author: architect ir. William G.J. Velzeboer | wvelzebo@its.jnj.com 
 * 
 * Modification Log 
 * =============================================================== 
 * Ver  |Date        |Author                |Modification 
 * 1.0  | 15/01/2018 |wvelzebo@its.jnj.com  |   
 */
public with sharing class sflib_CaseTeamAddMemberController
{

	@AuraEnabled
	public static List<CaseTeamMemberRoleResult> getCaseTeamMemberRoles()
	{
		List<CaseTeamRole> caseTeamRoles =
				((sflib_CaseTeamRoleSelector) sflib_Application.Selector.newInstance(CaseTeamRole.SObjectType))
						.selectAll();

		List<CaseTeamMemberRoleResult> results = new List<CaseTeamMemberRoleResult>();
		for (CaseTeamRole caseTeamRole : caseTeamRoles)
		{
			results.add( new CaseTeamMemberRoleResult(caseTeamRole));
		}

		return results;
	}


	@AuraEnabled
	public static string addCaseTeamMember(Id caseId, Id memberId, Id roleId)
	{
		fflib_ISObjectUnitOfWork uow = sflib_Application.UnitOfWork.newInstance();
		CaseTeamMember caseTeamMember = new CaseTeamMember();
		caseTeamMember.ParentId = caseId;
		caseTeamMember.MemberId = memberId;
		caseTeamMember.TeamRoleId = roleId;
		System.debug('caseTeamMember:'+caseTeamMember);
		uow.registerNew(caseTeamMember);
		try
		{
			uow.commitWork();
			return 'SUCCESS';
		}
		catch (Exception e)
		{
			if (e.getMessage().contains('DUPLICATE_VALUE'))
			{
				return 'DUPLICATE_VALUE';
			}
			else
			{
				return 'ERROR';
			}
		}
	}


	public class CaseTeamMemberRoleResult
	{
		@AuraEnabled public String label;
		@AuraEnabled public String value;

		public CaseTeamMemberRoleResult(CaseTeamRole caseTeamRole)
		{
			this.label = caseTeamRole.Name + ' (' + caseTeamRole.AccessLevel + ')';
			this.value = caseTeamRole.Id;
		}
	}
}