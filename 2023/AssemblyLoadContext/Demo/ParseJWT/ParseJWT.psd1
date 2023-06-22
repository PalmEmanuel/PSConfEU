@{
    ModuleVersion      = '1.0.0'
    GUID               = '66cb985a-1f17-44b0-8603-925ae53c9237'
    Author             = 'Emanuel Palm'
    CompanyName        = 'pipe.how'
    Copyright          = '(c) Emanuel Palm. All rights reserved.'
    Description        = 'Module to parse a JWT.'
    CmdletsToExport    = '*'
    
    # 1. Assemblies that should be loaded before our module. This is before the Resolving event handler is registered, and is therefore not used.
    RequiredAssemblies = @()

    # 2. ModuleIsolation will resolve the ParseJWT assembly and dependencies into the custom ALC from its own folder (ie .\dependencies) if PowerShell doesn't find it
    NestedModules      = @('.\dependencies\ModuleIsolation.dll')

    # 3. The binary module is intentionally not specified to be in the dependencies folder, because we don't want PowerShell to find it and load it into the default ALC 
    RootModule         = 'ParseJWT.dll'
}
