/**
 * File Name: sflib_Application 
 * Description: 
 * Copyright (c) 2018 Johnson & Johnson
 * @author: architect ir. William G.J. Velzeboer | wvelzebo@its.jnj.com 
 * 
 * Modification Log 
 * =============================================================== 
 * Ver  |Date        |Author                |Modification 
 * 1.0  | 15/01/2018 |wvelzebo@its.jnj.com  |   
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
					Application.Selector,
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