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
private class sflib_CaseTeamAddMemberControllerTest
{

	static testMethod void itShouldReturnTheCaseTeamRoles()
	{
		// GIVEN
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		sflib_CaseTeamRoleSelector selectorMock =
				(sflib_CaseTeamRoleSelector) mocks.mock(sflib_CaseTeamRoleSelector.class);

		final CaseTeamRole contributorRole = generateCaseTeamRole('Contributor', 'Write');
		final CaseTeamRole reviewerRole = generateCaseTeamRole('Reviewer', 'Read');

		mocks.startStubbing();
		mocks.when(selectorMock.sObjectType()).thenReturn(CaseTeamRole.SObjectType);
		mocks.when(selectorMock.selectAll()).thenReturn(
				new List<CaseTeamRole>
				{
						contributorRole,
						reviewerRole
				}
		);
		mocks.stopStubbing();

		sflib_Application.Selector.setMock(selectorMock);

		// WHEN
		Test.startTest();
		List<sflib_CaseTeamAddMemberController.CaseTeamMemberRoleResult> results =
				sflib_CaseTeamAddMemberController.getCaseTeamMemberRoles();
		Test.stopTest();

		// THEN
		((sflib_CaseTeamRoleSelector) mocks.verify(selectorMock)).selectAll();
		System.assertEquals(2, results.size(), 'Incorrect amount of returned Case Team roles');
	}


	static testMethod void itShouldReturnAnEmptyListWhenNoCaseTeamRolesExist()
	{
		// GIVEN
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		sflib_CaseTeamRoleSelector selectorMock =
				(sflib_CaseTeamRoleSelector) mocks.mock(sflib_CaseTeamRoleSelector.class);

		mocks.startStubbing();
		mocks.when(selectorMock.sObjectType()).thenReturn(CaseTeamRole.SObjectType);
		mocks.when(selectorMock.selectAll()).thenReturn(new List<CaseTeamRole>());
		mocks.stopStubbing();

		sflib_Application.Selector.setMock(selectorMock);

		// WHEN
		Test.startTest();
		List<sflib_CaseTeamAddMemberController.CaseTeamMemberRoleResult> results =
				sflib_CaseTeamAddMemberController.getCaseTeamMemberRoles();
		Test.stopTest();

		// THEN
		((sflib_CaseTeamRoleSelector) mocks.verify(selectorMock)).selectAll();
		System.assertEquals(0, results.size(), 'Incorrect amount of returned Case Team roles');
	}


	static testMethod void itShouldAddACaseTeamMember()
	{
		// GIVEN
		fflib_ApexMocks mocks = new fflib_ApexMocks();
		fflib_ISObjectUnitOfWork uowMock = new fflib_SObjectMocks.SObjectUnitOfWork(mocks);
		sflib_Application.UnitOfWork.setMock(uowMock);

		Id caseId = fflib_IDGenerator.generate(Case.SObjectType);
		Id userId = fflib_IDGenerator.generate(User.SObjectType);
		Id roleId = fflib_IDGenerator.generate(CaseTeamRole.SObjectType);

		// WHEN
		test.startTest();
		String result = sflib_CaseTeamAddMemberController.addCaseTeamMember(caseId, userId, roleId);
		test.stopTest();

		// THEN
		CaseTeamMember record = new CaseTeamMember(parentId = caseId, MemberId = userId, TeamRoleId = roleId);
		((fflib_ISObjectUnitOfWork) mocks.verify(uowMock)).registerNew(record);
		System.assertEquals('SUCCESS', result, 'Incorrect return value');
	}


	private static CaseTeamRole generateCaseTeamRole(String roleName, String accessLevel)
	{
		return new CaseTeamRole(
				Name = roleName,
				AccessLevel = accessLevel,
				Id = fflib_IDGenerator.generate(CaseTeamRole.SObjectType)
		);
	}

	private class TestException extends Exception{}
}