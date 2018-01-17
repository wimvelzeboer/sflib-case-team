/**
 * File Name: sflib_CaseTeamMemberSelector 
 * Description: 
 * Copyright (c) 2018 Johnson & Johnson
 * @author: architect ir. William G.J. Velzeboer | wvelzebo@its.jnj.com 
 * 
 * Modification Log 
 * =============================================================== 
 * Ver  |Date        |Author                |Modification 
 * 1.0  | 15/01/2018 |wvelzebo@its.jnj.com  |   
 */
public class sflib_CaseTeamMemberSelector extends fflib_SObjectSelector
{
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				CaseTeamMember.MemberId,
				CaseTeamMember.ParentId,
				CaseTeamMember.TeamRoleId
		};
	}


	public Schema.SObjectType getSObjectType()
	{
		return CaseTeamMember.sObjectType;
	}


	public List<CaseTeamMember> selectById(Set<ID> idSet)
	{
		return (List<CaseTeamMember>) selectSObjectsById(idSet);
	}


	public List<CaseTeamMember> selectByParentId(Set<Id> idSet)
	{
		fflib_QueryFactory queryFactory = newQueryFactory();
		queryFactory
				.selectField('Member.Name')
				.selectField('LastModifiedBy.Name')
				.selectField('LastModifiedDate')
				.selectField('Member.Name')
				.selectField('TeamRole.Name')
				.selectField('TeamRole.AccessLevel')
				.setCondition('ParentId IN :idSet');
		return (List<CaseTeamMember>) Database.query(queryFactory.toSOQL());
	}
}