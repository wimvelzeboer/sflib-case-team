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