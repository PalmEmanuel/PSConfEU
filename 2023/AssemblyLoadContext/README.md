# AssemblyLoadContextPresentation

Code and slides for the presentation on AssemblyLoadContexts for PSConfEU2023.

The demo shows a conflict between the module `Microsoft.Graph.Authentication` of version 1.28.0 and a custom module implementing the `System.IdentityModel.Tokens.Jwt` which is used by the Graph module, and the resulting code shows how to resolve the conflict using an AssemblyLoadContext.

The script `Build.ps1` creates a new folder structure for the module and manifest, and puts the assemblies in a subfolder called dependencies for loading them into a custom AssemblyLoadContext.

The demo also uses the fantastic extension to Visual Studio called StageCoder, with four demo steps, the last one implementing [Isol8, an experimental module for implementing AssemblyLoadContexts in PowerShell modules](https://github.com/PalmEmanuel/Isol8).
