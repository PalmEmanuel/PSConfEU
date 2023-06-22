param(
    [ValidateSet('Debug', 'Release')]
    [string]
    $Configuration = 'Debug',
    
    [string]
    $DotNetVersion = 'net6.0'
)

$Module = Get-ChildItem "$PSScriptRoot\*.psd1" -Recurse

# Define build output locations
$OutDir = "$PSScriptRoot\..\out"
$OutDependencies = "$OutDir\dependencies"

if (Test-Path $OutDir) {
    Remove-Item $OutDir -Recurse -Force -ErrorAction Stop
}

dotnet publish "$PSScriptRoot\Demo.sln"

# Ensure output directories exist and are clean for build
New-Item -Path $OutDir -ItemType Directory -ErrorAction Ignore
Get-ChildItem $OutDir | Remove-Item -Recurse
New-Item -Path $OutDependencies -ItemType Directory

# Copy .dll and .pdb files to the dependency directory
Get-ChildItem -Path "$PSScriptRoot\$($Module.BaseName)\bin\$Configuration\$DotNetVersion\publish" |
Where-Object { $_.Extension -in '.dll', '.pdb' } |
ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $OutDependencies
}

# Copy manifest and assembly resolving dll
Copy-Item -Path $Module -Destination $OutDir
Copy-Item -Path "$PSScriptRoot\ModuleIsolation\bin\$Configuration\$DotNetVersion\publish\ModuleIsolation.dll" -Destination $OutDependencies -ErrorAction SilentlyContinue