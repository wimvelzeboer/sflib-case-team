# sflib-case-team
While waiting for the Salesforce Case Team solution for Lightning to be released, you can use this component as a temporary solution.

**Dependencies:** 
Must deploy [ApexMocks](https://github.com/wimvelzeboer/fflib-apex-mocks-plus) and [ApexCommons](https://github.com/wimvelzeboer/fflib-apex-common-plus) before deploying this library

<a href="https://githubsfdeploy.herokuapp.com?owner=wimvelzeboer&repo=sflib-case-team">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

## Donate
Please do not forget to donate something when you find this tool usefull. Thanks!
<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=H4L2B682AHSKW">
    <img alt="Donate"
         src="donate.gif" />
</a>



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

