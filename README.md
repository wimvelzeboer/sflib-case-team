# sflib-case-team
While waiting for the Salesforce Case Team solution for Lightning to be released, you can use this component as a temporary solution.

**Dependencies:** 
Must deploy [ApexMocks](https://github.com/wimvelzeboer/fflib-apex-mocks-plus) and [ApexCommons](https://github.com/wimvelzeboer/fflib-apex-common-plus) before deploying this library

<a href="https://githubsfdeploy.herokuapp.com?owner=wimvelzeboer&repo=sflib-case-team">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>


## Setup
Use the "Deploy to Salesforce" button or follow the steps below:
- Clone this repo
- Copy the build.properties.template file into build.properties file and add your salesforce username and password.
- Do `ant deploy` to get the classes in your dev org.
