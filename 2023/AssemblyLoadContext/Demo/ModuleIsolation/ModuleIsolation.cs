using System.Management.Automation;
using System.Reflection;
using System.Runtime.Loader;

namespace PipeHow.ParseJWT;

// Implement interfaces for interacting with loading logic of PowerShell
public class ModuleInitializer : IModuleAssemblyInitializer, IModuleAssemblyCleanup
{
    // Get directory of this assembly, and use that directory to load dependencies from
    private static readonly string? dependencyDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
    // Create a new custom ALC and provide the directory
    private static readonly ParseJwtAssemblyLoadContext alc = new(dependencyDirectory);

    // Runs when Import-Module is run on our module, but in this case also when referred to in NestedModules
    public void OnImport() => AssemblyLoadContext.Default.Resolving += ResolveAssembly;
    // Runs when user runs Remove-Module on our module
    public void OnRemove(PSModuleInfo psModuleInfo) => AssemblyLoadContext.Default.Resolving -= ResolveAssembly;

    // Resolve assembly by name if it's the ParseJWT dll being loaded by the default ALC
    // We know it's the default ALC because of line 16 above
    public static Assembly? ResolveAssembly(AssemblyLoadContext defaultAlc, AssemblyName assemblyName) {
        if (assemblyName.Name == "ParseJWT") {
            // Resolving it by name with our custom ALC will make sure that we don't try to load it multiple times
            // This will effectively run the Load() method in our custom ALC
            return alc.LoadFromAssemblyName(assemblyName);
        }

        // Returning null lets the loader know that we didn't load the module, and will let the next step try to resolve it
        return null;
    }
}

// We create our own ALC by inheriting from AssemblyLoadContext and overriding the Load() method
// We can also change the constructor to take a path which we load from, which we do here
public class ParseJwtAssemblyLoadContext : AssemblyLoadContext
{
    // The path which we try to load the assemblies from
    private readonly string dependencyDirectory;
    
    // We can call the base constructor to set a name for the ALC
    // There are more options such as marking our ALC as collectible to enable unloading it, but that doesn't work with PowerShell
    public ParseJwtAssemblyLoadContext(string path) : base("ParseJWTContext")
    {
        dependencyDirectory = path;
    }

    // Override the Load() method and try to load the module as a DLL file in the provided directory if it exists
    protected override Assembly? Load(AssemblyName assemblyName) {
        var assemblyPath = Path.Join(dependencyDirectory, $"{assemblyName.Name}.dll");

        // If it exists we can load it from the path
        if (File.Exists(assemblyPath)) {
            return LoadFromAssemblyPath(assemblyPath);
        }

        // Returning null once more lets the loader know that we didn't load the module, and lets it try something else
        return null;
    }
}