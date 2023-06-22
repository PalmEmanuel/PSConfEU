namespace PipeHow.ParseJWT;
using System.IdentityModel.Tokens.Jwt;
using System.Management.Automation;

[Cmdlet(VerbsCommon.Get, "TokenInfo")]
public class GetTokenInfoCmdlet : PSCmdlet
{
    [Parameter(Mandatory = true, Position = 0, ValueFromPipeline = true)]
    [ValidateNotNullOrEmpty()]
    public string Token { get; set; }

    protected override void EndProcessing()
    {
        var handler = new JwtSecurityTokenHandler();
        var jsonToken = handler.ReadJwtToken(Token);
        WriteObject(jsonToken);
    }
}