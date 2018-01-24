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
public class sflib_Application implements fflib_IApplication
{

	// Configure and create the UnitOfWorkFactory for this Application
	public static final fflib_Application.UnitOfWorkFactory UnitOfWork =
			new fflib_Application.UnitOfWorkFactory(
					new List<SObjectType>
					{
							CaseTeamMember.SObjectType
					});

	// Configure and create the ServiceFactory for this Application
	public static final fflib_Application.ServiceFactory Service =
			new fflib_Application.ServiceFactory(
					new Map<Type, Type>
					{
//							OpportunitiesService.class => OpportunitiesService.class
					});

	// Configure and create the SelectorFactory for this Application
	public static final fflib_Application.SelectorFactory Selector =
			new fflib_Application.SelectorFactory(
					new Map<SObjectType, Type>
					{
							CaseTeamMember.SObjectType => sflib_CaseTeamMemberSelector.class,
							CaseTeamRole.SObjectType => sflib_CaseTeamRoleSelector.class
					});

	// Configure and create the DomainFactory for this Application
	public static final fflib_Application.DomainFactory Domain =
			new fflib_Application.DomainFactory(
					sflib_Application.Selector,
					new Map<SObjectType, Type>
					{
//							Opportunity.SObjectType => Opportunities.Constructor.class
					});


	public fflib_Application.UnitOfWorkFactory getUnitOfWorkFactory()
	{
		return sflib_Application.UnitOfWork;
	}


	public fflib_Application.ServiceFactory getServiceFactory()
	{
		return sflib_Application.Service;
	}


	public fflib_Application.SelectorFactory getSelectorFactory()
	{
		return sflib_Application.Selector;
	}


	public fflib_Application.DomainFactory getDomainFactory()
	{
		return sflib_Application.Domain;
	}
}