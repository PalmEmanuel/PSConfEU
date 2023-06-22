# Presentations for PowerShell Conference Europe 2023

## Write PowerShell modules without conflicts - Introducing Assembly Load Contexts

You run Import-Module and the terminal turns red: "Could not load file or assembly". You restart PowerShell and try the commands again in a different order, but it's red again: "Assembly with same name is already loaded".

If you recognize these errors you may have encountered a conflict between two modules. As a module-maker it can be frustrating to see users report issues when using another popular module outside your control. If only there was a way for you to ensure that your module never has a dependency conflict.

In this session we'll create a simple module in PowerShell that has a dependency conflict with a common module, and then go through how we can solve the problem by using an AssemblyLoadContext in C#.

## 	Creating your first PowerShell module in C#

Co-session by Emanuel Palm & Justin Grote

Do you sometimes wish that you could access things just a little bit deeper in the .NET stack? That you could use more of the published SDKs and packages as PowerShell commands? That your modules would run a little bit faster?

Sometimes you encounter scenarios where writing your module in PowerShell is just not quite enough, so in this follow-along session we'll take a look at situations where authoring modules in C# really shines.

We will use GitHub and git to create the project, and together write a simple PowerShell module using the .NET SDK and Visual Studio Code with the C# and PowerShell extensions. During the session will go through some of the tools and techniques not available when writing "normal" script modules, and cover some core module concepts for developing modules in C#.

By the end of the session we will have a fully working module with tests, ready to be shared with the community.

## 	Building a PowerShell module for Bicep using C# - almost 1.000.000 downloads later

Co-session by Emanuel Palm & Simon Wåhlin

Our Bicep PowerShell module was released in January 2021 and is approaching 1 million downloads from the PowerShell Gallery. What started as few simple commands has grown into a Bicep authoring tool, but it was not without a few hurdles along the way.

In August of 2020, Microsoft released their first alpha version of Azure Bicep, a new domain-specific language for deploying Azure resources declaratively. We jumped on the bandwagon at first sight and in January of 2021, our friend Stefan Ivemo had grown tired of keeping his Bicep version up to date and also wanted to simplify building all templates in a repository. He wrote a few scripts that soon turned into a module that started to grow. Not long thereafter, we took a dependency on the actual Bicep project and imported their DLLs in PowerShell to be able to get a more native PowerShell experience and access the inner functions of Bicep. What worked well in the beginning, soon resulted in dependency conflicts with other modules, and later on even with PowerShell itself. This was solved by breaking out the Bicep dependencies onto a binary module, which in turn led to more hurdles.

This is the story about how a PowerShell module was born and evolved into a C# project, the lessons we learned and how it helped a group of friends improve their coding skills.