# sflib-case-team
While waiting for the Salesforce Case Team solution for Lightning to be released, you can use this component as a temporary solution.

**Dependencies:** 
Must deploy [ApexMocks](https://github.com/wimvelzeboer/fflib-apex-mocks-plus) and [ApexCommons](https://github.com/wimvelzeboer/fflib-apex-common-plus) before deploying this library

<a href="https://githubsfdeploy.herokuapp.com?owner=wimvelzeboer&repo=sflib-case-team">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="H4L2B682AHSKW">
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/nl_NL/i/scr/pixel.gif" width="1" height="1">
</form>


## Setup
Use the "Deploy to Salesforce" button or follow the steps below:
- Clone this repo
- Copy the build.properties.template file into build.properties file and add your salesforce username and password.
- Do `ant deploy` to get the classes in your dev org.


After installation:
- Login to Salesforce
- Goto a detailpage of a case 
- Under setup (The cog in the upper right corner), select 'Edit Page'
- Select the component, from the custom components at the bottom in the left hand side, and drag it onto the page

