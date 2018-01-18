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
@IsTest
private class sflib_CaseTeamRelatedListControllerTest
{

	static testMethod void itShouldReturnTheCaseTeam()
	{
		// GIVEN
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		sflib_CaseTeamMemberSelector selectorMock =
				(sflib_CaseTeamMemberSelector) mocks.mock(sflib_CaseTeamMemberSelector.class);

		final Id caseId = fflib_IDGenerator.generate(Case.SObjectType);
		final Id userId = fflib_IDGenerator.generate(User.SObjectType);
		final Id roleId = fflib_IDGenerator.generate(CaseTeamRole.SObjectType);

		final CaseTeamMember contributor = generateCaseTeamMember(caseId);
		final CaseTeamMember reviewer = generateCaseTeamMember(caseId);

		mocks.startStubbing();
		mocks.when(selectorMock.sObjectType()).thenReturn(CaseTeamMember.SObjectType);
		mocks.when(selectorMock.selectByParentId( new Set<Id>{ caseId } )).thenReturn(
				new List<CaseTeamMember>
				{
						contributor,
						reviewer
				}
		);
		mocks.stopStubbing();

		sflib_Application.Selector.setMock(selectorMock);

		// WHEN
		Test.startTest();
		List<sflib_CaseTeamRelatedListController.CaseTeamDataResult> results =
				sflib_CaseTeamRelatedListController.getCaseTeamData(caseId);
		Test.stopTest();

		// THEN
		((sflib_CaseTeamMemberSelector) mocks.verify(selectorMock)).selectByParentId( new Set<Id>{ caseId } );
		System.assertEquals(2, results.size(), 'Incorrect amount of returned Case Team roles');
	}


	static testMethod void itShouldDeleteTheCaseTeamMember()
	{
		// GIVEN
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		fflib_ISObjectUnitOfWork uowMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);
		sflib_Application.UnitOfWork.setMock(uowMock);

		final Id caseTeamMemberId = fflib_IDGenerator.generate(CaseTeamMember.SObjectType);


		// WHEN
		Test.startTest();
		String result = sflib_CaseTeamRelatedListController.removeCaseTeamMembers(new List<String>{caseTeamMemberId});
		Test.stopTest();

		// THEN

		((fflib_ISObjectUnitOfWork) mocks.verify(uowMock)).registerDeleted(
				new CaseTeamMember(Id = caseTeamMemberId)
		);
		((fflib_ISObjectUnitOfWork) mocks.verify(uowMock)).commitWork();
		System.assertEquals('SUCCESS', result, 'Incorrect returned result');
	}


	private static CaseTeamMember generateCaseTeamMember(Id caseId)
	{
		return generateCaseTeamMember(
				caseId,
				fflib_IDGenerator.generate(User.SObjectType),
				fflib_IDGenerator.generate(CaseTeamRole.SObjectType)
		);
	}

	private static CaseTeamMember generateCaseTeamMember(Id caseId, Id userId, Id roleId)
	{
		return new CaseTeamMember( TeamRoleId = roleId, ParentId = caseId, MemberId = userId);
	}
}