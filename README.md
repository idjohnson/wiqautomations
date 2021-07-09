# WIQ Automations
Azure DevOps work item automations.  I covered this in a tech talk during Open Source North 2021 Speaker Series (you can watch [here](https://youtu.be/NU-geyVygvQ)).  This will also be covered in a blog entry on https://freshbrewed.science


# Introduction 
This is a working example of a Work Item Query (WIQ) automation run in Azure DevOps.
In this example, we process tickets that add users.

# Getting Started

1.	Get a PAT token that can do user administration in an Azure DevOps organizaton
2.  Have BASH terminal to use; native Mac or Windows Subsystem for Linux (WSL) works well
3.  Onboard this repo or a fork to your org.

# Build and Test

You will likely want to globally find and replace:
- Pay-As-You-Go(d955c0ba-13dc-44cf-a29a-8fed74cbb22d)
  - this is my Azure subscription service connection name in AzDO, change to your own
- AzureDevOpsAutomationPAT
  - you can set a pipeline variable in AzDO or add a block to pull from a group variable (Pipelines/Library)
- 'princessking' is the name of AzDO org. You'll likely need to change your https://dev.azure.com/--yourorgname--/
- variables at the top of the pipeline refer to the user in AzDO and pipeline ID.
  - if the pipeline ID isnt set, that just means the semaphore will not work to start.

## testing the add user script 

You can test the adduser.sh with a working PAT for your Org

```
$ ./adduser.sh i*******mypat**************************q Tristan.Cormac.Moriartyyyy@gmail.com "HelloWorldPrj Team" HelloWorldPrj stakeholder
user: Tristan.Cormac.Moriartyyyy@gmail.com
group: HelloWorldPrj Team
Project: HelloWorldPrj
License: stakeholder
{
  "accessLevel": {
    "accountLicenseType": "stakeholder",
    "assignmentSource": "unknown",

```

In Azure DevOps we use a query that finds tickets that follow a work item template as such:

```
Please enter your user onboarding request

Please enter the fields:
manager: manager of this user's email address
user: email address of user
license: basic, stakeholder or VSE (default is stakeholder)
project: name of project
tps-enabled: true or false. If true, they must add a cover letter to all their outgoing TPS reports

---
manager: manager@company.com
user: user@company.com
license: stakeholder
project: Project Name
tps-enabled: false
```

The important part is really about the YAML at the end that is parsed by the template code

# Contribute

I welcome fork and PR to this.  This is an example, but the adduser.sh could be improved upon and the parsing of YAML made more robust

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
