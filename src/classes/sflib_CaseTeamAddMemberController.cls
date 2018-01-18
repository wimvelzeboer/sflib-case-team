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