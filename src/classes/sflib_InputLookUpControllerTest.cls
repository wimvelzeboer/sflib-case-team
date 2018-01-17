/*
 * Author: Enrico Murru (http://enree.co, @enreeco)
 */
@IsTest
private class sflib_InputLookUpControllerTest
{

	private static testMethod void test_search()
	{
		Test.startTest();
		List<SObject> results = sflib_InputLookUpController.searchSObject('Account', '', 'Test');
		Test.stopTest();

		System.assertEquals(true, results.isEmpty(), 'Should return nothing');
	}
}