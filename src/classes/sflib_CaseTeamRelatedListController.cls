/**
 *  This file is part of sflib.
 *
 *  sflib is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License,
 *  or any later version.
 *
 *  sflib is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with sflib.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  @author: architect William Velzeboer  wim@velzeboer.nl
 *  @date: January 2018
 *  @version: 1.0
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