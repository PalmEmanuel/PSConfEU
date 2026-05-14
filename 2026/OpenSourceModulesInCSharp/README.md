# Building Open Source Modules in C#

Slides and notes for the presentation about building open source modules in C# at PSConfEU 2026.

The demo module was built with [Sampler](https://github.com/gaelcolas/Sampler) and can be found at [PalmEmanuel/AzPigeon](https://github.com/PalmEmanuel/AzPigeon).

```powershell
# Generated with Sampler
$ModuleSplat = @{
    ModuleName = 'AzPigeon'
    ModuleDescription = 'A PowerShell module to read and write messages in Azure Storage Queues.'
    ModuleVersion = '1.0.0'
    ModuleAuthor = 'Emanuel Palm'
    LicenseType = 'MIT'
    DestinationPath = Resolve-Path '..'
    ModuleType = 'SimpleModule'
}
New-SampleModule @ModuleSplat
```

Demos use the Visual Studio Code Extension [StageCoder](https://marketplace.visualstudio.com/items?itemName=EngstromJimmy.stagecoderVSCode).

---

Some of the best modules you're using have been written in C#. Why, and how?

C# brings performance, language features, dependency isolation options, and taps into the full .NET ecosystem which is sometimes hard to use directly in PowerShell.

In this session we're going to show how we can author PowerShell modules in C# directly on GitHub as open source, using community tools such as Sampler and Pester, and take a look at some existing example modules like AzAuth and AzBobbyTables.

The goal of this session is to equip you with tools and knowledge to be able to build and publish your own binary community modules in C# for PowerShell.
