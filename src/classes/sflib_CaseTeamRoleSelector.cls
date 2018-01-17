/**
 * File Name: sflib_CaseTeamRoleSelector 
 * Description: 
 * Copyright (c) 2018 Johnson & Johnson
 * @author: architect ir. William G.J. Velzeboer | wvelzebo@its.jnj.com 
 * 
 * Modification Log 
 * =============================================================== 
 * Ver  |Date        |Author                |Modification 
 * 1.0  | 15/01/2018 |wvelzebo@its.jnj.com  |   
 */
public class sflib_CaseTeamRoleSelector extends fflib_SObjectSelector
{
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				CaseTeamRole.Id,
				CaseTeamRole.AccessLevel,
				CaseTeamRole.Name
		};
	}


	public Schema.SObjectType getSObjectType()
	{
		return CaseTeamRole.sObjectType;
	}


	public List<CaseTeamRole> selectById(Set<ID> idSet)
	{
		return (List<CaseTeamRole>) selectSObjectsById(idSet);
	}


	public List<CaseTeamRole> selectAll()
	{
		return (List<CaseTeamRole>) Database.query(newQueryFactory().toSOQL());
	}
}